package com.zps.hotel;

import java.util.Scanner;

//�Ƶ����ϵͳ
public class test {

	public static void main(String[] args) {

Scanner s =new Scanner(System.in);
	System.out.println("��ӭʹ�þƵ����ϵͳ");		
		Hotel h= new Hotel();
		h.print();
		
		while(true) {
			System.out.println("�������˷���Ԥ����");
			String order =s.next();
			if("Ԥ��".equals(order)) {
				System.out.println("�����뷿����");
				String id =s.next();
				h.order(id);
			}else if("�˷�".equals(order)) {
				System.out.println("�����뷿����");
				String id =s.next();
				h.checkOut(id);	
			}else {
				System.out.println("�������˷���Ԥ����");
			}
		h.print();	
		}
		
		

}
}