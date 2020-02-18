package com.cl.util;

import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Stack;

/**
 * 数据库连接池，具体实现
 * 分析：
 * 	数据库连接池：
 * 	存储多个数据库连接对象的集合
 * 	数据库连接对象：ConnectionUtil
 * 	1.需要被操作的数据库连接对象connection
 *     2.该链接是是否为空闲状态
 *     
 * 	该连接池中的成员变量：
 * 	1、数据连接初始连接数量
 * 	2、数据连接最大连接数量
 * 	3、数据库连接自动扩容的数量
 * 	4、存储数据库连接的集合stack，vector;
 * 
 *  连接池的创建和用户使用数据库连接：
 * 	1、存储数据连接的几个对象，可使用堆栈或者序列或者向量来存储，保证线程安全
 * 	2、当用户需要访问数据库的时候，需要从线程池中获取一个数据库连接的权利，
 * 		但是需要判断当前的数据库中是否含有空闲的数据库连接，
 * 		如果含有那么就将含有的数据库连接开发给这个请求数据库连接的用户使用
 * 		如果已经没有足够的连接数量提供给该用户，也就当前连接数量已经大于数据连接池的最大允许连接数量
 * 		那么就让该用户等该一小会，在看连接池中是否含有空余的连接，如果还是没有，
 * 		那么就根据连接池可允许的自动扩容数量，增加一定数量的数据库连接，让其他用户可以正常的访问数据库 
 * 		当用户拿到数据库连接的使用权之后，需要将改数据库的连接状态改为工作中，避免多个用户拿到相同的连接 
 *  3、当用户使用完数据连接之后，这个时候需要返还数据库的连接，也就是将当前的数据库连接再次放回连接池
 * 		而且需要将数据库连接对象的状态更改为空闲
 * 	
 *     获取连接使用动态代理来实现
 */
public class DBPool {
	/**
	 * 存储数据库连接的集合，即数据连接池
	 */
	private  Stack<ConnectionUtil> dbPoolStack=null;
	
	/**
	 * 	统计当前连接数量，避免连接数多于连接的创建
	 */
	private int current;
	
	/**
	 * 实例化连接池对象
	 * 通过静态内部类来实现懒加载创建实例
	 */
	private static class DBPoolnstance{
		private static final DBPool dbPool = new DBPool();
	}
	
	/**
	 * 将数据库连接池对象的构造函数私有化，防止其他对象对它实例化
	 * 初始化一定数量的数据库连接，创建出有一定数据量数据连接的数据连接池
	 * 在数据库连接池类对象被调用的时候就加载出现一定数量的数据库连接
	 */
	private DBPool(){
		if(dbPoolStack==null){
			dbPoolStack = new Stack<ConnectionUtil>();
		}
		for(int i=0;i<DB.DB_INIT_CONNECTIONS;i++){
			dbPoolStack.push(createDBConn());
		}
	}
	
	/**
	 * 返回连接池对象的实例
	 * @return
	 */
	public static DBPool getInstance(){
		return DBPoolnstance.dbPool;
	}
	
	/**
	 * 创建一个数据库连接的对象
	 * @return
	 */
	public ConnectionUtil createDBConn(){
		ConnectionUtil dbconn = new ConnectionUtil();
		if(dbPoolStack.size()<11){
			try {
				//获取数据库元数据，用于查看数据库所允许的最大数据库连接数
				DatabaseMetaData dbMetaData = dbconn.getConnection().getMetaData();
				//得到当前访问的数据库的最大所允许的连接数
				int maxDBConnect = dbMetaData.getMaxConnections();
				//判断数据库的最大访问量是否有设置，
				//如果设置，判断当前设置的最大连接是否超过数据库所允许的范围，
				//如果超过，那么将最大的数据库连接数改为数据库所允许的最大连接数
				if(maxDBConnect>0&&maxDBConnect>DB.DB_MAX_CONNECTIONS){
					DB.setDB_MAX_CONNECTIONS(maxDBConnect);
				}
				dbconn = DBInvocationHandler.getInstance().bind(dbconn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dbconn;
	}
	
	/**
	 * 获得一个数据库连接对象
	 * 判断获取连接是否为空闲，如果为空闲，那么则将该链接返回，并且将连接状态设置为不是空闲
	 * @return
	 */
	public ConnectionUtil getConnection(){
		ConnectionUtil dbconn = null;
		if(dbPoolStack.empty()){
			//先休眠一百毫秒,最多可循环两次
			int conut = 0;
			conut = wait(100,conut);
			//如果两次请求获取连接都没有空余的连接，那么新创建一个连接
			if(conut>=2){
				//如果当前的连接数量小于最大连接数-自动连接数，
				//则让其创建新的连接，
				//否则如果没有操作当前最大连接，则让其创建一个连接
				if(current<DB.DB_MAX_CONNECTIONS-DB.DB_INCREMENT_CONNECTIONS){
					incrementConection();
				}else{
					dbPoolStack.add(createDBConn());
				}
			}else{
				getConnection();
			}
		}
		for(Iterator<ConnectionUtil> it = dbPoolStack.iterator();it.hasNext(); ){
			ConnectionUtil conn = (ConnectionUtil)it.next();
			//判断数据库连接是否空闲，如果是空闲的那么就将该连接返回给用户使用
			if(conn.getIsFree()){
 				dbconn = dbPoolStack.pop();
				//将获取到的数据库连接状态更改为非空闲
 				dbconn.setIsFree(false);
				break;
			}else{
				//否则说明该链接出现异常，将其删除，并更新为新的连接，保持连接池连接数量
				dbPoolStack.pop();
				dbPoolStack.push(new ConnectionUtil());
			}
		}
		current++;
		return dbconn;
	}
	
	/**
	 * 释放数据库连接
	 * 将当前使用结束的链接状态设置为空闲，并且将连接添加进连接池的栈中
	 */
	public void releaseConnection(ConnectionUtil dbconn){
		try {
			dbconn.getConnection().close();
			dbPoolStack.push(dbconn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 当没有空余连接的时候添加新的连接
	 */
	public void incrementConection(){
		for(int i=0;i<DB.DB_INCREMENT_CONNECTIONS;i++){
			dbPoolStack.add(createDBConn());
		}
	}
	
	/**
	 * 如果在获取连接池中的连接时，发现连接池为空，那么请等待一段时间，时间过后再获取连接，
	 * 看有没有返还链接的用户，如果有则将该连接交给当前请求获取连接的用户，
	 * 如果没有，那么新增一定数量的连接，以保证用户访问的流程
	 * @param mSeconds
	 */
	private int wait(int ms,int conut) {
		try {
			// 尝试让本线程休眠一段时间，休眠的时长由参数mSeconds确定
			Thread.sleep(ms);
			conut++;
		} catch (InterruptedException e) {
			// 出现异常则输出异常信息
			e.printStackTrace();
		}
		return conut;
	}
	
	/**
	 * 获取数据库连接池的栈集合
	 * @return
	 */
	public Stack<ConnectionUtil> getDbPoolStack() {
		return dbPoolStack;
	}
}
