package Study;
/*题目：输入某年某月某日，判断这一天是这一年的第几天？

程序分析：以3月5日为例，应该先把前两个月的加起来，
然后再加上5天即本年的第几天，
特殊情况，闰年且输入月份大于3时需考虑多加一天。
*/
import java.util.Scanner;

public class Prog14 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int day=0;
		int e=0;
		int d=0;
		Scanner input=new Scanner(System.in);
		System.out.println("please int year:");
		int year =input.nextInt();
		System.out.println("please int month:");
		int month =input.nextInt();
		System.out.println("please int day:");
		int days = input.nextInt();
		if(month<0||month>12||days<0||days>31){
			System.out.println("input error");
			e=1;
		}	
	while(e==1);
	for(int i=1;i<month;i++){
		switch(i){
		    case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:{
				day=31;
				break;
			}
			case 4:
			case 6:
			case 9:
			case 11:{
				day=30;
				break;		
			}
			case 2:{
				if((year%100!=0&&year%4==0)||(year%100==0&&year%400==0))
				{
	day=29;
			}else{
				day=28;
			}
		}
		default:
			break;
		}
		d+=day;
	}
	System.out.println(year+"-"+month+"-"+days+"是这一年的第:");
	System.out.println(d+days+"天");
	}
}
		