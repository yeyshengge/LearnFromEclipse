package Study;
import java.util.Scanner;

/*��Ŀ����ҵ���ŵĽ������������ɡ�����(I)���ڻ����10��Ԫʱ���������10%��
 * �������10��Ԫ������20��Ԫʱ������10��Ԫ�Ĳ��ְ�10%��ɣ�����10��Ԫ�Ĳ��֣��ɿ����7.5%��
 * 20��40��֮��ʱ������20��Ԫ�Ĳ��֣������5%��
 * 40��60��֮��ʱ����40��Ԫ�Ĳ��֣������3%��
 * 60��100��֮��ʱ������60��Ԫ�Ĳ��֣������1.5%��
 * ����100��Ԫʱ������100��Ԫ�Ĳ��ְ�1%��ɣ�
 * �Ӽ������뵱������I����Ӧ���Ž��������� 
1.����������������������ֽ磬��λ��ע�ⶨ��ʱ��ѽ�����ɳ����͡�
 */
public class Prog12 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        Scanner input= new Scanner(System.in);
        System.out.println("������������");
        double i =input.nextDouble();
        if(i>=0&&i<=100000){
        	System.out.println(i*0.1);
        	}
        	else if(i>100000&&i<=200000){
        		System.out.println((i-100000)*0.075+10000);
        	}
        	else if(i>200000&&i<=400000){
        		System.out.println((i-200000)*0.05);
        	}
        	else if(i>400000&&i<=600000){
        		System.out.println((i-400000)*0.03);
        	}
        	else if(i>600000&&i<=1000000){
        		System.out.println((i-600000)*0.015);
        	}
        	else{
        		System.out.println((i-1000000)*0.01);
        	}
	
        }
	}


