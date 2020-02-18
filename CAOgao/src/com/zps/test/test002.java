package com.zps.test;

public class test002 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
Object o1=new Object();
Object o2=new Object();
System.out.println(o1.equals(o2));
		
Object o3=o2;
System.out.println(o3.equals(o2));

Star s1=new Star(1001,"냥질");
Star s2=new Star(1001,"냥질");
	System.out.println(s1.equals(s2));
	}

}
class Star{
	String name;
	int id;
	public Star (int id,String name) {
		this.id=id;
		this.name=name;
	}
	
}