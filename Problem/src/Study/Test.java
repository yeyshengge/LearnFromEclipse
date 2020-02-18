package Study;

public class Test{
	public static void main(String[] args){
//for(int i=1;i<=4;i++){
//	for(int j=1;j<=5-i;j++){
//		System.out.print(" ");
//	}
//		for(int k=1;k<=2*i-1;k++){
//			System.out.print("*");	
//	}
//	System.out.println("");
//}
//	for(int a=1;a<4;a++){
//		for(int b=1;b<=a+1;b++){
//		System.out.print(" ");
//	}for(int x=1;x<=7-2*a;x++){
//		System.out.print("*");
//	}
//		
//		System.out.println("");
//	}
/*
###*
##*#*
#*###*
*#####*
#*###*
##*#*
###*
*/

     for(int a=1;a<5;a++){
    	 
    	 for(int b=1;b<=4-a;b++){
    	 System.out.print(" ");
    	 }
    	 System.out.print("*");
    	 for(int c=2;c<2*a-1;c++){
   		 System.out.print(" ");
    	 }
    	 int d=0;
    	 if( d<a-1){
    			System.out.print("*");
    	    		}
    	 System.out.println();
     }
	for(int x=1;x<4;x++){
		for(int y=1;y<x+1;y++){
			System.out.print(" ");
		}System.out.print("*");
		for(int z=1;z<=5-2*x;z++){
			System.out.print(" ");
		}
		
		if( x<=4-x){
			System.out.print("*");
		}
		System.out.println(" ");
	}
     
     
	}

		
	}

