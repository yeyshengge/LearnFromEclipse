package Study;
/**��Ŀ������һ���ַ����ֱ�ͳ�Ƴ�����Ӣ����ĸ���ո����ֺ������ַ��ĸ�����

�������������while���,����Ϊ������ַ���Ϊ'\n'.*/


import java.util.Scanner;
public class Prog7 {
public static void main(String[] args) {
       int yingwen=0,shuzi = 0,kongge = 0,other = 0;
       Scanner in = new Scanner(System.in);
       System.out.println("�������ַ���");
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
System.out.println("���ֵĸ�����"+shuzi);
System.out.println("��ĸ�ĸ�����"+yingwen);
System.out.println("�ո�ĸ�����"+kongge);
System.out.println("�����ĸ�����"+other);

	}

}
