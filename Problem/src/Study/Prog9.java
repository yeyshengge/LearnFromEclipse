package Study;
/*
 * ��Ŀ��һ�������ǡ�õ�����������֮�ͣ�������ͳ�Ϊ"����"��
 * ����6=1��2��3.����ҳ�1000���ڵ�����������
 */
public class Prog9 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int i,j;
		int sum=0;
        for(i=1;i<1001;i++){
        sum=0;
    	for(j=1;j<i;j++){
    		if(i%j == 0){
    			sum = sum+j;
    			}
    	}
       if(i == sum){
    	   System.out.println(i+"  ");
    	   }
       }
}
}
