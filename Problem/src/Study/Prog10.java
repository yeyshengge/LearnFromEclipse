package Study;
/*��Ŀ��һ���100�׸߶��������£�ÿ����غ�����ԭ�߶ȵ�һ�룻
 * �����£������ڵ�10�����ʱ�������������ף���10�η�����ߣ�
 *   double s=0;
 *   double t=100;
 *   for(int i=1;i<=10;i++){
 *   s+=t;
 *   t=t/2;
 *   syso(s);
 *   syso(t);
 *   }
 */
public class Prog10 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
     double h=100;
     double sum=100;
     for(int i=2;i<=11;i++){
    	 h+=100/(Math.pow(2, i-2));	 
    	 sum=100/(Math.pow(2, i-1));
     }
     System.out.println("��10�ι�������"+h+"��");
     System.out.println("��10�η�����"+sum+"��");
 
    
	}

}
