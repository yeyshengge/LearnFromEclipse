package Study;
import java.util.Scanner;

/**
 * ������6����Ŀ����������������m��n���������Լ������С�������� 
 *1.�������������շ������ 
 *2.ԭ���������������Լ���������н�С������������������������Լ���� 
 *3.��С��������������֮���������Լ��
 * @author Sheng
 */
public class Prog6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
System.out.println("������һ����");
@SuppressWarnings("resource")
Scanner in = new Scanner(System.in);
int num1=in.nextInt();
System.out.println("�����������");
int num2=in.nextInt();
int m=deff(num1,num2);
System.out.println("���Լ��"+m);
int n=num1*num2/m;
System.out.println("��С������"+n);
	}
public static int deff(int num1,int num2){
	//ȷ��NUM2��С���Ա����num2=0����ѭ��
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
