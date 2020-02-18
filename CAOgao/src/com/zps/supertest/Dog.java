package com.zps.supertest;

public class Dog extends animal {
	
	public String name ="旺财";
	
void eat() {
		System.out.println("吃狗粮");
	}
public Dog() {
	//super("土豪金", "藏獒");
	System.out.println("Dog中的无参构造方法");
}




public void m1() {
	System.out.println(super.name);
	System.out.println(this.name);
	super.eat();
	this.eat();
}
}
