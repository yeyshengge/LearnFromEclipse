package com.zps.supertest;

public class Dog extends animal {
	
	public String name ="����";
	
void eat() {
		System.out.println("�Թ���");
	}
public Dog() {
	//super("������", "����");
	System.out.println("Dog�е��޲ι��췽��");
}




public void m1() {
	System.out.println(super.name);
	System.out.println(this.name);
	super.eat();
	this.eat();
}
}
