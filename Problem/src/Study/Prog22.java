/*
 * 题目：利用递归方法求5!。 
1.程序分析：递归公式：fn=fn_1*4!
 */

package Study;

import java.util.Scanner;

public class Prog22 {

	public static void main(String[] args) {
		// TODO Auto-generated method stubS
		Scanner input = new Scanner(System.in);
		System.out.println("Please int n:");
		int n=input.nextInt();
		System.out.println(JieCheng(n));
		
	}
	public static int  JieCheng(int n){
		if(n==0){
			return 1;
			
		}else{
			return JieCheng(n-1)*n;
		}
		
	}

}
