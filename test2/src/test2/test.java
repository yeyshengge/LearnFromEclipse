package test2;

import java.util.Scanner;

public class test {

	public static void main(String[] args) {
		
		Scanner input =new Scanner(System.in);
		int s=input.nextInt();
		if(s<60) {
			System.out.println("ȥ��");
		}else if(s>60&&s<90) {
			System.out.println("100Ԫ");
		}else if(s>90&&s<100) {
			System.out.println("��������");
		}else {
			System.out.println("��������ȷ�ķ���");
		}
		
		
		
        		 }

}
