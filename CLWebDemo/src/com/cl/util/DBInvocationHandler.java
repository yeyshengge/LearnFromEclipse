package com.cl.util;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;

/**
 * 通过动态代理拦截Connection 中的close方法，
 * 实现数据连接池中的没有一个数据库连接都不会再调用 Connection中的close方法
 * 的时候出现数据库连接频繁关闭的情况
 */
public class DBInvocationHandler implements InvocationHandler {
	/**
	 * 被代理的类
	 */
	private ConnectionUtil dbconn;
	private Connection conn;
	
	/**
	 * 类加载则创建本类的实例
	 */
	private static DBInvocationHandler dbInvocation = new DBInvocationHandler();
	
	
	/**
	 * 返回本类的实例
	 * @return
	 */
	public static  DBInvocationHandler getInstance(){
		return dbInvocation;
	}
	
	/**
	 * 将构造函数私有化
	 */
	private DBInvocationHandler(){
		
	}
	
	/**
	 * 拦截数据库连接关闭动作
	 */
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		//如果数据库调用关闭连接操作，那么将关闭连接的方法进行重写
		Object obj = null;
		System.out.println("Connection正在调用：------------------"+method.getName()+"------------------方法");
		if("close".equals(method.getName())){
			//将数据库连接对象的状态设置为空闲
			dbconn.setIsFree(true);
		}else{
			obj = method.invoke(conn, args);
		}
		return obj;
	}
	
	/**
	 * 返回经过动态代理处理之后的数据库访问对象，
	 * 主要拦截Connection中的close方法，
	 * 重写关闭数据库操作，将被拦截的数据库连接对象的操作设置为空闲，
	 * 其他不是close方法的继续执行原有的功能
	 * @return
	 */
	public ConnectionUtil bind(ConnectionUtil dbconn){
		this.dbconn = dbconn;
		conn = dbconn.getConnection();
		Class<?> clz = dbconn.getConnection().getClass();
		Connection conn =  (Connection)Proxy.newProxyInstance(clz.getClassLoader(), new Class[]{Connection.class}, this);
		dbconn.setConnection(conn);
		return dbconn;
	}
}

