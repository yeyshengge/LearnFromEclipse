package com.zps.jdbc;


public class MyException extends Exception{
	
	public MyException() {
		super("不好意思，请将正确的表名写到注解中！");
	}
}
