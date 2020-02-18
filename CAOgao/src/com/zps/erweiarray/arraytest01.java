package com.zps.erweiarray;



//动态初始化二维数组
public class arraytest01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
 int [][] a =new int [3][4];
 
 a[2][3]=36;
 
 
		for (int i=0;i<a.length;i++) {
			for (int j=0;j<a[i].length;j++) {
				System.out.print(a[i][j]+" ");
			}System.out.println();
		}
	}

}
