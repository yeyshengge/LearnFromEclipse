/*
 * 求1+2!+3!+...+20!的和
 * !!!!!!!!!!定义long为长整数
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
