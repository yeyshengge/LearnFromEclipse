package Study;
import java.util.Scanner;

/*��Ŀ����s=a+aa+aaa+aaaa+aa...a��ֵ������a��һ�����֡�
 * ����2+22+222+2222+22222(��ʱ����5�������)������������м��̿��ơ� 
1.����������ؼ��Ǽ����ÿһ���ֵ��*/
public class Prog8 {

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
  Scanner input = new Scanner(System.in);
 System.out.println("����������֣�");
  int n=input.nextInt();
  Scanner input2=new Scanner(System.in);
  System.out.println("���������������");
  int num=input2.nextInt();
	double sums=0.0;
  double sum=0.0;
  for(int i=0;i<num;i++){
	  sum+=Math.pow(10, i)*n;
	  
	  sums+=sum;
	
  }
  System.out.println("����ǣ�"+sums); 
	}

}
