package Study;
/*һ��������������100����һ����ȫƽ�������ټ���168����һ����ȫƽ������
 * ���ʸ����Ƕ��٣� 
1.�����������10�������жϣ��Ƚ���������100���ٿ�����
�ٽ���������268���ٿ�����
���������Ľ�������������������ǽ�����뿴���������
 */
public class Prog13 {

	public static void main(String[] args) {
		// TODO Auto-generated method 
       for(int i=0;i<=100000;i++){
       if(Math.sqrt(i+100)%1==0&&Math.sqrt(i+268)%1==0){
				System.out.println(i);
			}
		}
	}

}
