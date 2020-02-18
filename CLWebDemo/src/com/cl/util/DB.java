package com.cl.util;

import java.io.IOException;
import java.util.Properties;

public final class DB {
	//���ݿ�����
	public static String DB_DRIVER;
	
	//���ݿ������
	public static String DB_NAME;
	
	//���ݿ��������
	public static String DB_PASSWORD;
	
	//���ݿ���ʵ�ַ
	public static String DB_URL;
	
	//��ʼ��������
	public static int DB_INIT_CONNECTIONS;
	
	//�Զ�����������
	public static int DB_INCREMENT_CONNECTIONS;
	
	//���������
	public static int DB_MAX_CONNECTIONS;
	
	/**
	 * ����ص�ʱ��ֻ���������ݿ��������Ҫ���ַ�
	 */ 
	static{ 
		Properties prop = new Properties();
		try { 
			prop.load(DB.class.getClassLoader().getResourceAsStream("jdbc.properties")); 
			DB_DRIVER = prop.getProperty("jdbcDriver"); 
			DB_URL = prop.getProperty("jdbcUrl"); 
			DB_NAME = prop.getProperty("username"); 
			DB_PASSWORD = prop.getProperty("password"); 
			DB_INIT_CONNECTIONS = Integer.parseInt(prop.getProperty("initConnectCount")); 
			DB_MAX_CONNECTIONS = Integer.parseInt(prop.getProperty("maxConnects")); 
			DB_INCREMENT_CONNECTIONS = Integer.parseInt(prop.getProperty("incrementCount")); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		} 
	} 
	
	/** 
	 * ��ȡ���ݿ�������������ַ
	 * com.mysql.jdbc.Driver 
	 * @return 
	 */ 
	public static String getDB_DRIVER() { 
		return DB_DRIVER; 
	} 
	
	/**
	 *  �������ݿ��������������ַ
	 *  @param dB_DRIVER 
	 */ 
	public static void setDB_DRIVER(String dB_DRIVER) { 
		DB_DRIVER = dB_DRIVER; 
	} 
	
	/** 
	 * ��ȡ���������ݿ������ 
	 * @return 
	 */ 
	public static String getDB_NAME() { 
		return DB_NAME; 
	} 
	
	/** 
	 * ���ñ��������ݿ������
	 * @param dB_NAME 
	 */ 
	public static void setDB_NAME(String dB_NAME) { 
		DB_NAME = dB_NAME; 
	} 
	
	/**
	 * ������ݿ���ʵ�����
	 * @return 
	 */ 
	public static String getDB_PASSWORD() { 
		return DB_PASSWORD; 
	} 
	
	/** 
	 * �������ݿ���ʵ����� 
	 * @param dB_PASSWORD 
	 */ 
	public static void setDB_PASSWORD(String dB_PASSWORD) { 
		DB_PASSWORD = dB_PASSWORD; 
	} 
	
	/**
	 * ������ݿ���ʵ�ַ 
	 * @return 
	 */ 
	public static String getDB_URL() { 
		return DB_URL; 
	} 
	
	/** 
	 * �������ݿ���ʷ��ʵ�ַ 
	 * @param dB_URL 
	 */ 
	public static void setDB_URL(String dB_URL) { 
		DB_URL = dB_URL; 
	} 
	
	/** 
	 * ��ȡ���ӳس�ʼ�������� 
	 * @return 
	 */ 
	public static int getDB_INIT_CONNECTIONS() { 
		return DB_INIT_CONNECTIONS; 
	} 
	
	/** 
	 * �������ӳس�ʼ�������� 
	 * @param dB_INIT_CONNECTIONS 
	 */ 
	public static void setDB_INIT_CONNECTIONS(int dB_INIT_CONNECTIONS) {
		DB_INIT_CONNECTIONS = dB_INIT_CONNECTIONS; 
	} 
	
	/** 
	 * ������ӳ��Զ����ݵ������� 
	 * @return 
	 */ 
	public static int getDB_INCREMENT_CONNECTIONS() { 
		return DB_INCREMENT_CONNECTIONS; 
	} 
	
	/** 
	 * �������ӳ��Զ����ݵ����� 
	 * @param dB_INCREMENT_CONNECTIONS 
	 */ 
	public static void setDB_INCREMENT_CONNECTIONS(int dB_INCREMENT_CONNECTIONS) { 
		DB_INCREMENT_CONNECTIONS = dB_INCREMENT_CONNECTIONS; 
	} 
	
	/** 
	 * ��ȡ���ݿ��������� 
	 * @return 
	 */ 
	public static int getDB_MAX_CONNECTIONS() { 
		return DB_MAX_CONNECTIONS; 
	} 
	
	/** 
	 * �������ݿ��������� 
	 * @param dB_MAX_CONNECTIONS 
	 */ 
	public static void setDB_MAX_CONNECTIONS(int dB_MAX_CONNECTIONS) { 
		DB_MAX_CONNECTIONS = dB_MAX_CONNECTIONS; 
	} 
	
	
}
