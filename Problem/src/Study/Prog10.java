package Study;
/*题目：一球从100米高度自由落下，每次落地后反跳回原高度的一半；
 * 再落下，求它在第10次落地时，共经过多少米？第10次反弹多高？
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
     System.out.println("第10次共经过："+h+"米");
     System.out.println("第10次反弹："+sum+"米");
 
    
	}

}
