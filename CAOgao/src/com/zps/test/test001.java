package com.zps.test;
import java.util.Random;
import java.util.Scanner;
    public class test001{
    	public static void main(String args[]) {
    	Random s= new Random();
    	int ss=s.nextInt(100)+1;
    		for(int i=1;i<101;i++) {
    			Scanner input =new Scanner(System.in);
    			System.out.println("���������֣�");
    			int sss=input.nextInt();
    			
    			if(sss>ss) {
    				System.out.println("������Ĵ���");
    			}else if(sss<ss) {
    				System.out.println("�������С��");
    			}else if(sss==ss) {
    					System.out.println("��ϲ������!");
    			}else {
    						System.out.println("��������");
    					}
    				}
    			}
    		
    	}
    