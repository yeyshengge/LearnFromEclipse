package com.java;

public class StaticTest {
	
	int commonint=0;//普通变量
	static int ststicint=0;//静态变量

	StaticTest(int x){
		this.commonint=x;
		
	}
	public static void main(String[] args){
		StaticTest s1=new StaticTest(1);
		StaticTest s2=new StaticTest(2);
		System.out.println("s1.commonint="+s1.commonint);
		System.out.println("s2.commonint="+s2.commonint);
	}
}
