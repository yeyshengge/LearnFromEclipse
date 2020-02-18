package com.zps.supertest;

public class animal {

String name="动物";
	
	String color;
	String category;
	
	public animal() {
		System.out.println("animal中的无参构造方法");
	}
		public animal(String color,String category) {
			this.color=color;
			this.category=category;
		}
		
	void eat() {
		System.out.println("吃东西");
	}
}
