package com.zps.test;
import java.util.Random;
import java.util.Scanner;
    public class test001{
    	public static void main(String args[]) {
    	Random s= new Random();
    	int ss=s.nextInt(100)+1;
    		for(int i=1;i<101;i++) {
    			Scanner input =new Scanner(System.in);
    			System.out.println("请输入数字：");
    			int sss=input.nextInt();
    			
    			if(sss>ss) {
    				System.out.println("你输入的大了");
    			}else if(sss<ss) {
    				System.out.println("你输入的小了");
    			}else if(sss==ss) {
    					System.out.println("恭喜你答对了!");
    			}else {
    						System.out.println("输入有误");
    					}
    				}
    			}
    		
    	}
    