package com.zps.thistest;

public class actor {

      private String name;
      
    
      void act1() {
    	  String name ="����";
    			  System.out.println(name);//����
    	  System.out.println(this.name );//fang
      }
      
      void act2() {
    	  System.out.println(name);//fang
      }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
      
      
      

	

}
