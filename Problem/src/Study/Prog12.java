package Study;
import java.util.Scanner;

/*题目：企业发放的奖金根据利润提成。利润(I)低于或等于10万元时，奖金可提10%；
 * 利润高于10万元，低于20万元时，低于10万元的部分按10%提成，高于10万元的部分，可可提成7.5%；
 * 20万到40万之间时，高于20万元的部分，可提成5%；
 * 40万到60万之间时高于40万元的部分，可提成3%；
 * 60万到100万之间时，高于60万元的部分，可提成1.5%，
 * 高于100万元时，超过100万元的部分按1%提成，
 * 从键盘输入当月利润I，求应发放奖金总数？ 
1.程序分析：请利用数轴来分界，定位。注意定义时需把奖金定义成长整型。
 */
public class Prog12 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        Scanner input= new Scanner(System.in);
        System.out.println("请输入月利润：");
        double i =input.nextDouble();
        if(i>=0&&i<=100000){
        	System.out.println(i*0.1);
        	}
        	else if(i>100000&&i<=200000){
        		System.out.println((i-100000)*0.075+10000);
        	}
        	else if(i>200000&&i<=400000){
        		System.out.println((i-200000)*0.05);
        	}
        	else if(i>400000&&i<=600000){
        		System.out.println((i-400000)*0.03);
        	}
        	else if(i>600000&&i<=1000000){
        		System.out.println((i-600000)*0.015);
        	}
        	else{
        		System.out.println((i-1000000)*0.01);
        	}
	
        }
	}


