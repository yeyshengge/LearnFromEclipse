package com.zps.erweiarray;

public class arraytest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
  
		  int [] []  a={
			  {1,2,3},
			  {10,18,161},
			  {12,50,60},
			  {1024,50,62}
		  };
		  System.out.println(a.length);
		
		  for( int i=0;i<a.length;i++) { //第一层遍历二维数组中的一维数组 
			  for(int j=0;j<a[i].length;j++) { //遍历一维数组 
				  System.out.print(a[i][j]+" "); 
				  }System.out.println();
			  } 
		 
		  }
		 
		  
		  
		  
		  
		  
		  

		  
		  
		  
		  
	}


