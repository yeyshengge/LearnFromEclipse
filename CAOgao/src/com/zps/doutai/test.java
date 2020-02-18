package com.zps.doutai;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
Cat c=new Cat();
c.move();

animal  a=new Cat();//父类引用子类对象
a.eat();//动态绑定，静态绑定
System.out.println(a.num);//说明成员变量不存在重写
	}

}
