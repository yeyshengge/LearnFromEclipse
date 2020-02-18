package com.cl.util;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;

/**
 * ͨ����̬��������Connection �е�close������
 * ʵ���������ӳ��е�û��һ�����ݿ����Ӷ������ٵ��� Connection�е�close����
 * ��ʱ��������ݿ�����Ƶ���رյ����
 */
public class DBInvocationHandler implements InvocationHandler {
	/**
	 * ���������
	 */
	private ConnectionUtil dbconn;
	private Connection conn;
	
	/**
	 * ������򴴽������ʵ��
	 */
	private static DBInvocationHandler dbInvocation = new DBInvocationHandler();
	
	
	/**
	 * ���ر����ʵ��
	 * @return
	 */
	public static  DBInvocationHandler getInstance(){
		return dbInvocation;
	}
	
	/**
	 * �����캯��˽�л�
	 */
	private DBInvocationHandler(){
		
	}
	
	/**
	 * �������ݿ����ӹرն���
	 */
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		//������ݿ���ùر����Ӳ�������ô���ر����ӵķ���������д
		Object obj = null;
		System.out.println("Connection���ڵ��ã�------------------"+method.getName()+"------------------����");
		if("close".equals(method.getName())){
			//�����ݿ����Ӷ����״̬����Ϊ����
			dbconn.setIsFree(true);
		}else{
			obj = method.invoke(conn, args);
		}
		return obj;
	}
	
	/**
	 * ���ؾ�����̬������֮������ݿ���ʶ���
	 * ��Ҫ����Connection�е�close������
	 * ��д�ر����ݿ�������������ص����ݿ����Ӷ���Ĳ�������Ϊ���У�
	 * ��������close�����ļ���ִ��ԭ�еĹ���
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

