package Study;
import java.util.Scanner;

/*题目：利用条件运算符的嵌套来完成此题：学习成绩>=90分的同学用A表示，
60-89分之间的用B表示，60分以下的用C表示。
程序分析：(a>b)?a:b这是条件运算符的基本例子。*/
/*public class Prog5{
	public static void main(String[]args){
		int sum;
		sum=60;
		if(sum>=90){
			System.out.println("A");
			
		}
		else if(sum>=60||sum<90){
			System.out.println("B");
		}
		else
			System.out.println("C");;
			
	}
}*/
public class Prog5{
	public static void main(String[]args){
		boolean b;
		int N;
		Scanner input = new Scanner(System.in);
		while(b=true){
		
			try {
		N=input.nextInt();
System.out.println("学习成绩为："+((N<60)?"C":(N<90)?"B":"A"));
	    b=false;  
	    } 
			catch (Exception e) {
	    input.nextLine();
	    System.out.println("请重新输入");
}	
}
}
}