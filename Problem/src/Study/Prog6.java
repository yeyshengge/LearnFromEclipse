package Study;
import java.util.Scanner;

/**
 * 【程序6】题目：输入两个正整数m和n，求其最大公约数和最小公倍数。 
 *1.程序分析：利用辗除法。 
 *2.原理：两个整数的最大公约数等于其中较小的数和两数的相除余数的最大公约数。 
 *3.最小公倍数等于两数之积除以最大公约数
 * @author Sheng
 */
public class Prog6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
System.out.println("请输入一个数");
@SuppressWarnings("resource")
Scanner in = new Scanner(System.in);
int num1=in.nextInt();
System.out.println("请输入二个数");
int num2=in.nextInt();
int m=deff(num1,num2);
System.out.println("最大公约数"+m);
int n=num1*num2/m;
System.out.println("最小公倍数"+n);
	}
public static int deff(int num1,int num2){
	//确定NUM2最小，以便后面num2=0结束循环
	if(num1<num2){
	int a;
	a=num2;
	num2=num1;
	num1=a;
	}
	while(num2!=0){
		if(num1==num2){
			return num1;
		}else{
			int b=num1%num2;
			num1=num2;
			num2=b;
		}
	}
	return num1;
	
	
}
}
