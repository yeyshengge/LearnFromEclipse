package com.cl.util;

import java.io.IOException;
import java.util.Properties;

public final class DB {
	//数据库驱动
	public static String DB_DRIVER;
	
	//数据库访问名
	public static String DB_NAME;
	
	//数据库访问密码
	public static String DB_PASSWORD;
	
	//数据库访问地址
	public static String DB_URL;
	
	//初始化连接数
	public static int DB_INIT_CONNECTIONS;
	
	//自动扩容连接数
	public static int DB_INCREMENT_CONNECTIONS;
	
	//最大连接数
	public static int DB_MAX_CONNECTIONS;
	
	/**
	 * 类加载的时候只创建次数据库访问所需要的字符
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
	 * 获取数据库驱动程序的类地址
	 * com.mysql.jdbc.Driver 
	 * @return 
	 */ 
	public static String getDB_DRIVER() { 
		return DB_DRIVER; 
	} 
	
	/**
	 *  设置数据库的驱动程序的类地址
	 *  @param dB_DRIVER 
	 */ 
	public static void setDB_DRIVER(String dB_DRIVER) { 
		DB_DRIVER = dB_DRIVER; 
	} 
	
	/** 
	 * 获取被访问数据库的名称 
	 * @return 
	 */ 
	public static String getDB_NAME() { 
		return DB_NAME; 
	} 
	
	/** 
	 * 设置被访问数据库的名称
	 * @param dB_NAME 
	 */ 
	public static void setDB_NAME(String dB_NAME) { 
		DB_NAME = dB_NAME; 
	} 
	
	/**
	 * 获得数据库访问的密码
	 * @return 
	 */ 
	public static String getDB_PASSWORD() { 
		return DB_PASSWORD; 
	} 
	
	/** 
	 * 设置数据库访问的密码 
	 * @param dB_PASSWORD 
	 */ 
	public static void setDB_PASSWORD(String dB_PASSWORD) { 
		DB_PASSWORD = dB_PASSWORD; 
	} 
	
	/**
	 * 获得数据库访问地址 
	 * @return 
	 */ 
	public static String getDB_URL() { 
		return DB_URL; 
	} 
	
	/** 
	 * 设置数据库访问访问地址 
	 * @param dB_URL 
	 */ 
	public static void setDB_URL(String dB_URL) { 
		DB_URL = dB_URL; 
	} 
	
	/** 
	 * 获取连接池初始化连接数 
	 * @return 
	 */ 
	public static int getDB_INIT_CONNECTIONS() { 
		return DB_INIT_CONNECTIONS; 
	} 
	
	/** 
	 * 设置连接池初始化连接数 
	 * @param dB_INIT_CONNECTIONS 
	 */ 
	public static void setDB_INIT_CONNECTIONS(int dB_INIT_CONNECTIONS) {
		DB_INIT_CONNECTIONS = dB_INIT_CONNECTIONS; 
	} 
	
	/** 
	 * 获得连接池自动扩容的数据量 
	 * @return 
	 */ 
	public static int getDB_INCREMENT_CONNECTIONS() { 
		return DB_INCREMENT_CONNECTIONS; 
	} 
	
	/** 
	 * 设置连接池自动扩容的数量 
	 * @param dB_INCREMENT_CONNECTIONS 
	 */ 
	public static void setDB_INCREMENT_CONNECTIONS(int dB_INCREMENT_CONNECTIONS) { 
		DB_INCREMENT_CONNECTIONS = dB_INCREMENT_CONNECTIONS; 
	} 
	
	/** 
	 * 获取数据库最大访问量 
	 * @return 
	 */ 
	public static int getDB_MAX_CONNECTIONS() { 
		return DB_MAX_CONNECTIONS; 
	} 
	
	/** 
	 * 设置数据库最大访问量 
	 * @param dB_MAX_CONNECTIONS 
	 */ 
	public static void setDB_MAX_CONNECTIONS(int dB_MAX_CONNECTIONS) { 
		DB_MAX_CONNECTIONS = dB_MAX_CONNECTIONS; 
	} 
	
	
}
