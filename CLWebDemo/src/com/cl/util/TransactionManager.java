package com.cl.util;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * ��������࣬��Ҫ�Ǵ����ڶ����ݿ������ʱ����������ύ���ع��Ȳ���
 */
public class TransactionManager {

	/**
	 * ����һ����̬�ı����̵߳ľֲ�������ʵ��
	 * ThreadLocal<Connection> �߳���
	 * Ϊ������̳߳���Ĳ����ṩ��һ���µ�˼·
	 * ��ʹ��ThreadLocalά������ʱ��
	 * ThreadLocalΪÿ��ʹ�øñ������߳��ṩ�����ı���������
	 * ����ÿһ���̶߳����Զ����ظı��Լ��ĸ�����
	 * ������Ӱ�������߳�����Ӧ�ĸ�����
	 * ��JDK 1.5֮������˷���
	 */
	public static ThreadLocal<Connection> local = new ThreadLocal<Connection>();
	
	/**
	 * ��ȡ���ݿ�������ʵ��
	 */
	public static DBUtils dbUtils = new DBUtils();
	
	/**
	 * ��������
	 * �ж����Ӷ����Ƿ�Ϊ��
	 * ���Ϊ��Ϊ�գ������ﲻ�Զ��ύ
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
	 * �����ύ
	 * �ύ��֮�����ThreadLocal
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
	 * ����ع�
	 * �ر�����
	 * ���local
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
	 * �ر�����(�Զ��ύ)��
	 * ���ҵ������ݿ�رյĶ���
	 * ���local
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
