/*��Ŀ��������������x,y,z���������������С���������

���������������취����С�����ŵ�x�ϣ��Ƚ�x��y���бȽϣ�
���x>y��x��y��ֵ���н�����
Ȼ������x��z���бȽϣ�
���x>z��x��z��ֵ���н�����������ʹx��С��*/
package Study;
import java.util.Scanner;
public class Prog15 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
    Scanner input =new Scanner(System.in);
        System.out.println("������X:");
        int x=input.nextInt();
        System.out.println("������Y:");
        int y=input.nextInt();	
        System.out.println("������Z:");
        int z=input.nextInt();	
        int A;
	if(x>y){
		A=y;
		y=x;
		x=A;
	}
	if(x>z){
		A=z;
		z=x;
		x=A;	
	}
	if(y>z){
		A=y;
		y=z;
		z=A;
	}
	System.out.println(x+"  "+y+"  "+z);
	}
	}

