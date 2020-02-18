/***
 * 题目：输出9*9口诀。
程序分析：分行与列考虑，共9行9列，i控制行，j控制列。
 */


package Study;

public class Prog16 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
    int i;
    int j;
    for(i=1;i<10;i++){
    	for(j=1;j<=i;j++){
    		System.out.print(j+"*"+i+"="+(i*j)+" ");
 
    	}System.out.println();
    }
	}

}
