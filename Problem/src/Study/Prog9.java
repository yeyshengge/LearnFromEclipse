package Study;
/*
 * 题目：一个数如果恰好等于它的因子之和，这个数就称为"完数"。
 * 例如6=1＋2＋3.编程找出1000以内的所有完数。
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
