package test2;

import java.util.Scanner;

public class test {

	public static void main(String[] args) {
		
		Scanner input =new Scanner(System.in);
		int s=input.nextInt();
		if(s<60) {
			System.out.println("去死");
		}else if(s>60&&s<90) {
			System.out.println("100元");
		}else if(s>90&&s<100) {
			System.out.println("兰博基尼");
		}else {
			System.out.println("请输入正确的分数");
		}
		
		
		
        		 }

}
