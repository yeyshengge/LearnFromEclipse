package com.cl.util;

public class BaseException extends Exception{
	
	public BaseException() {
		super("不好意思，请将正确的表名写到注解中！");
	}
	
	public BaseException(String ex) {
		super(ex);
	}
}
