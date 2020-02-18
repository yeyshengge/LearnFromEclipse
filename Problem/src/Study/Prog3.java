package Study;
//打印出所有的"水仙花数"，所谓"水仙花数"是指一个三位数，
//其各位数字立方和等于该数本身。例如：153 是一个"水仙花数"，
//因为153=1的三次方＋5的三次方＋3的三次方

public class Prog3{
	public static void main (String[] args){
		int num =100;
		int x,y,z;
		for(num=100;num<1000;num++){
			x=num/1%10;
			y=num/10%10;
			z=num/100%10;
			if(num==x*x*x+y*y*y+z*z*z)
				System.out.println(num);
		}
	}
}