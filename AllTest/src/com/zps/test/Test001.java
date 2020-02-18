package com.zps.test;

public class Test001 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Honest v=new Angel();
		v.helpother();
	}

}


interface Volant{
	int fly_hight=100;
	void fly();
}
interface Honest{
	void helpother();
}

class Angel implements Volant,Honest{

	@Override
	public void helpother() {
System.out.println("Angle.helpother()");
		
	}

	@Override
	public void fly() {
System.out.println("Angle.fly()");		
	}
	
}