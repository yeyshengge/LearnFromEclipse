/*
 * ��Ŀ����һ��������5λ����������Ҫ��
 * һ�������Ǽ�λ�������������ӡ����λ���֡�
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
	}System.out.println("��һ��"+c+"λ��");
}
	}
}
	

