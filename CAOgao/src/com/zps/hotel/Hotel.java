package com.zps.hotel;

public class Hotel {
	
	Room[] [] room;
	//初始化房间编号类型
	public Hotel() {
		room = new Room[5][10];
		//1,2标准间,   101.102.103...
	//	3,4双人间,
		//5豪华间,
		for(int i=0;i<room.length;i++) {
			for( int j=0;j<room[i].length;j++) {
				if(i == 0 || i == 1) {//一层二层			
	   	room[i][j] =new Room((i+1)*100+j+1+"","标准间",false);//+““是强制转换为String 
			
					}
			if(i==2||i==3) {
				room[i][j] =new Room((i+1)*100+j+1+"","双人间",false);
			}
				if(i==4) {
					room[i][j] =new Room((i+1)*100+j+1+"","豪华间",false);
				}
			}
		}
	}
    //查看房间状态
    public void print() {
    	for( int i=0;i<room.length;i++) { //第一层遍历二维数组中的一维数组 
			  for(int j=0;j<room[i].length;j++) { //遍历一维数组 
				  System.out.print(room[i][j]+"   "); 
			  }
			  System.out.println();
			  } 
		  }
       //预订房间
	   public void order(String id) {
		   for( int i=0;i<room.length;i++) { //第一层遍历二维数组中的一维数组 
				  for(int j=0;j<room[i].length;j++) { //遍历一维数组 
					 
					  if(room[ i ][ j ].getId().equals(id)) {
                        //将房间状态改成ture占用
						  room[i][j].setUse(true);
					  }
				  }
				  } 
	}
     	//退房
	    public void checkOut(String id) {
	    	
	    	 for( int i=0;i<room.length;i++) { //第一层遍历二维数组中的一维数组 
				  for(int j=0;j<room[i].length;j++) { //遍历一维数组 
					 
					  if(room[ i ][ j ].getId().equals(id)) {
                       //将房间状态改成false空房
						  room[i][j].setUse(false);
					  }
				  }
				  } 
	    }
}
