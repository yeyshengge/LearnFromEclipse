package com.zps.hotel;

import java.util.Scanner;

//酒店管理系统
public class test {

	public static void main(String[] args) {

Scanner s =new Scanner(System.in);
	System.out.println("欢迎使用酒店管理系统");		
		Hotel h= new Hotel();
		h.print();
		
		while(true) {
			System.out.println("请输入退房或预定：");
			String order =s.next();
			if("预定".equals(order)) {
				System.out.println("请输入房间编号");
				String id =s.next();
				h.order(id);
			}else if("退房".equals(order)) {
				System.out.println("请输入房间编号");
				String id =s.next();
				h.checkOut(id);	
			}else {
				System.out.println("请输入退房或预定：");
			}
		h.print();	
		}
		
		

}
}