package com.zps.hotel;

public class Hotel {
	
	Room[] [] room;
	//��ʼ������������
	public Hotel() {
		room = new Room[5][10];
		//1,2��׼��,   101.102.103...
	//	3,4˫�˼�,
		//5������,
		for(int i=0;i<room.length;i++) {
			for( int j=0;j<room[i].length;j++) {
				if(i == 0 || i == 1) {//һ�����			
	   	room[i][j] =new Room((i+1)*100+j+1+"","��׼��",false);//+������ǿ��ת��ΪString 
			
					}
			if(i==2||i==3) {
				room[i][j] =new Room((i+1)*100+j+1+"","˫�˼�",false);
			}
				if(i==4) {
					room[i][j] =new Room((i+1)*100+j+1+"","������",false);
				}
			}
		}
	}
    //�鿴����״̬
    public void print() {
    	for( int i=0;i<room.length;i++) { //��һ�������ά�����е�һά���� 
			  for(int j=0;j<room[i].length;j++) { //����һά���� 
				  System.out.print(room[i][j]+"   "); 
			  }
			  System.out.println();
			  } 
		  }
       //Ԥ������
	   public void order(String id) {
		   for( int i=0;i<room.length;i++) { //��һ�������ά�����е�һά���� 
				  for(int j=0;j<room[i].length;j++) { //����һά���� 
					 
					  if(room[ i ][ j ].getId().equals(id)) {
                        //������״̬�ĳ�tureռ��
						  room[i][j].setUse(true);
					  }
				  }
				  } 
	}
     	//�˷�
	    public void checkOut(String id) {
	    	
	    	 for( int i=0;i<room.length;i++) { //��һ�������ά�����е�һά���� 
				  for(int j=0;j<room[i].length;j++) { //����һά���� 
					 
					  if(room[ i ][ j ].getId().equals(id)) {
                       //������״̬�ĳ�false�շ�
						  room[i][j].setUse(false);
					  }
				  }
				  } 
	    }
}
