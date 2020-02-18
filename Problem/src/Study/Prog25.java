/*
题目：一个5位数，判断它是不是回文数。
即12321是回文数，个位与万位相同，十位与千位相同。
 */

package Study;

import java.util.Scanner;

public class Prog25 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
     Scanner input=new Scanner(System.in);
      System.out.println("Please int number:");
      int num=input.nextInt();
	int a,b,c,d,e;
	e=num%10;
	d=num/10%10;
	c=num/100%10;
	b=num/1000%10;
	a=num/10000%10;
	if(e==a&&b==d){
		System.out.println("回文数");
		
	}else{
		System.out.println("不是回文数");
	}

	}}

	

