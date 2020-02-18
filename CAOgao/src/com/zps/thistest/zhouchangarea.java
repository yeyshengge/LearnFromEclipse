package com.zps.thistest;

public class zhouchangarea {

	private int width;
	private int length;
	
public zhouchangarea() {
	
}
public zhouchangarea(int width,int length) {
	this.width=width;
	this.length =length;
}	
	
	int zhouchang() {
		return 2*(width+length);
	}
	
	int area () {
		return width*length;
	}
	

	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		zhouchangarea zc =new zhouchangarea(15,10);
		System.out.println(zc.zhouchang());
		System.out.println(zc.area());
	}
}

