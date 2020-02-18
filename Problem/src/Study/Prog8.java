package Study;
import java.util.Scanner;

/*题目：求s=a+aa+aaa+aaaa+aa...a的值，其中a是一个数字。
 * 例如2+22+222+2222+22222(此时共有5个数相加)，几个数相加有键盘控制。 
1.程序分析：关键是计算出每一项的值。*/
public class Prog8 {

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
  Scanner input = new Scanner(System.in);
 System.out.println("请输入该数字：");
  int n=input.nextInt();
  Scanner input2=new Scanner(System.in);
  System.out.println("请输入运算次数：");
  int num=input2.nextInt();
	double sums=0.0;
  double sum=0.0;
  for(int i=0;i<num;i++){
	  sum+=Math.pow(10, i)*n;
	  
	  sums+=sum;
	
  }
  System.out.println("结果是："+sums); 
	}

}
