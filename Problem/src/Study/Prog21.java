/*
 * ��1+2!+3!+...+20!�ĺ�
 * !!!!!!!!!!����longΪ������
 */
package Study;

public class Prog21 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
long n=1;
long sum=0;
for(int i=1;i<21;i++){
	n=n*i;
	sum=sum+n;
}System.out.println(sum);
	}

}
