/*
 * 题目：给一个不多于5位的正整数，要求：
 * 一、求它是几位数，二、逆序打印出各位数字。
 */
package Study;

import java.util.Scanner;

public class Prog24 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
Scanner input=new Scanner(System.in);
System.out.println("Please int num:");
int n=input.nextInt();
int c=0;
if(0>n||n>10000){
	System.out.println("error input");
}else{
	while(n>0){
		System.out.print(n%10);
		n=n/10;
		c++;	
	}System.out.println("是一个"+c+"位数");
}
	}
}
	

