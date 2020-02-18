package com.zps.erweiarray;

/*Í¨¹ý¿½±´À©ÈÝ
 * 
 * */
public class Arraytest02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
       int [] a= {1,2,3,4,5,6};
       int [] b= {7,8,9,10,11,12,13,14,15,16,17,18,19,20};
       System.arraycopy(a, 2,b, 2, 4);
       for(int i=0;i<b.length;i++) {
    	   System.out.print(b[i]+" ");
       }
	}

}
