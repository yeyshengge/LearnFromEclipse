package Study;
/**题目：输入一行字符，分别统计出其中英文字母、空格、数字和其它字符的个数。

程序分析：利用while语句,条件为输入的字符不为'\n'.*/


import java.util.Scanner;
public class Prog7 {
public static void main(String[] args) {
       int yingwen=0,shuzi = 0,kongge = 0,other = 0;
       Scanner in = new Scanner(System.in);
       System.out.println("请输入字符串");
       String s= in.nextLine();
	char[]x = s.toCharArray();
       for(int i=0;i<x.length;i++){
    	   if(Character.isDigit(x[i])){
    		  shuzi++;}
    	   else if(Character.isLetter(x[i])){
    		   yingwen++; }
    	   else if(Character.isSpaceChar(x[i])){
    		   kongge++; }
    	   else{
    		   other++;}  
       }
System.out.println("数字的个数是"+shuzi);
System.out.println("字母的个数是"+yingwen);
System.out.println("空格的个数是"+kongge);
System.out.println("其他的个数是"+other);

	}

}
