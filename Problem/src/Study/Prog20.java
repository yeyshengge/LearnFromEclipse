/*
 * 题目：有一分数序列：2/1，3/2，5/3，8/5，13/8，21/13...
 * 求出这个数列的前20项之和。 
1.程序分析：请抓住分子与分母的变化规律。
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
  //把前一项的值赋给前一项的再前面一项
  sum1=sum2;
  //把当前项赋给前一项
  sum2=flag;
  
  sum+=sums;
  System.out.print(sum);
}
		
}
}
	

