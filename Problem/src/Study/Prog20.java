/*
 * ��Ŀ����һ�������У�2/1��3/2��5/3��8/5��13/8��21/13...
 * ���������е�ǰ20��֮�͡� 
1.�����������ץס�������ĸ�ı仯���ɡ�
 */

package Study;

public class Prog20 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int sum=0;
int sums=0;
int sum1=1;
int sum2=1;
for(int i=1;i<10;i++){

  int flag=sum1+sum2;
  sums=sum2/sum1;
  //��ǰһ���ֵ����ǰһ�����ǰ��һ��
  sum1=sum2;
  //�ѵ�ǰ���ǰһ��
  sum2=flag;
  
  sum+=sums;
  System.out.print(sum);
}
		
}
}
	

