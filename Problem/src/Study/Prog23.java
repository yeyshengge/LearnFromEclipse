/*
 * ��Ŀ����5��������һ���ʵ�����˶����ꣿ
 * ��˵�ȵ�4���˴�2�ꡣ�ʵ�4������������˵�ȵ�3���˴�2�ꡣ
 * �ʵ������ˣ���˵�ȵ�2�˴����ꡣ�ʵ�2���ˣ�˵�ȵ�һ���˴����ꡣ
 * ����ʵ�һ���ˣ���˵��10�ꡣ���ʵ�����˶�� 
������������õݹ�ķ������ݹ��Ϊ���ƺ͵��������׶Ρ�
Ҫ��֪�����������������֪�������˵�����,��
�����ƣ��Ƶ���һ�ˣ�10�꣩���������ơ�
 */
package Study;

public class Prog23 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
System.out.println(DiGui(5));
	
	}
	public static int DiGui(int n){
		if(n==1)
			return 10;
		else
			return DiGui(n-1)+2;
		
	}

}
