package com.cl.util;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * 事务管理类，主要是处理在对数据库操作的时候添加事务提交，回滚等操作
 */
public class TransactionManager {

	/**
	 * 创建一个静态的本地线程的局部变量的实例
	 * ThreadLocal<Connection> 线程类
	 * 为解决多线程程序的并发提供的一种新的思路
	 * 当使用ThreadLocal维护变量时，
	 * ThreadLocal为每个使用该变量的线程提供独立的变量副本，
	 * 所以每一个线程都可以独立地改变自己的副本，
	 * 而不会影响其它线程所对应的副本。
	 * 在JDK 1.5之后添加了泛型
	 */
	public static ThreadLocal<Connection> local = new ThreadLocal<Connection>();
	
	/**
	 * 获取数据库连接类实例
	 */
	public static DBUtils dbUtils = new DBUtils();
	
	/**
	 * 开启事务
	 * 判断连接对象是否为空
	 * 如果为不为空，让事物不自动提交
	 */
	public static void openTransaction(){
		Connection conn = dbUtils.conn;
		if(conn == null){
			try {
				throw new BaseException("please create connection!!!");
			} catch (BaseException e) {
				e.printStackTrace();
			}
		}
		try {
			conn.setAutoCommit(false);
			local.set(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 事物提交
	 * 提交完之后清空ThreadLocal
	 */
	public static void commit(){
		Connection conn = local.get();
		try {
			if(conn != null){
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		local.remove();
	}
	
	/**
	 * 事物回滚
	 * 关闭连接
	 * 清空local
	 */
	public static void rollback(){
		Connection conn = local.get();
		if(conn != null){
			try {
				conn.rollback();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			local.remove();
		}
		
	}
	
	/**
	 * 关闭事务(自动提交)，
	 * 并且调用数据库关闭的动作
	 * 清空local
	 */
	public static void closeTransaction(){
		Connection conn = local.get();
		if(conn != null){
			try {
				conn.setAutoCommit(true);
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			local.remove();
		}
	}
	
	
}
