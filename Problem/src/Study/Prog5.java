package Study;
import java.util.Scanner;

/*��Ŀ�����������������Ƕ������ɴ��⣺ѧϰ�ɼ�>=90�ֵ�ͬѧ��A��ʾ��
60-89��֮�����B��ʾ��60�����µ���C��ʾ��
���������(a>b)?a:b��������������Ļ������ӡ�*/
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
System.out.println("ѧϰ�ɼ�Ϊ��"+((N<60)?"C":(N<90)?"B":"A"));
	    b=false;  
	    } 
			catch (Exception e) {
	    input.nextLine();
	    System.out.println("����������");
}	
}
}
}