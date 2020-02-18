/*题目：输入三个整数x,y,z，请把这三个数由小到大输出。

程序分析：我们想办法把最小的数放到x上，先将x与y进行比较，
如果x>y则将x与y的值进行交换，
然后再用x与z进行比较，
如果x>z则将x与z的值进行交换，这样能使x最小。*/
package Study;
import java.util.Scanner;
public class Prog15 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
    Scanner input =new Scanner(System.in);
        System.out.println("请输入X:");
        int x=input.nextInt();
        System.out.println("请输入Y:");
        int y=input.nextInt();	
        System.out.println("请输入Z:");
        int z=input.nextInt();	
        int A;
	if(x>y){
		A=y;
		y=x;
		x=A;
	}
	if(x>z){
		A=z;
		z=x;
		x=A;	
	}
	if(y>z){
		A=y;
		y=z;
		z=A;
	}
	System.out.println(x+"  "+y+"  "+z);
	}
	}

