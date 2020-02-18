package Study;

public class Prog11 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        int t = 0;
		for(int i=1;i<=4;i++){
			for(int j=1;j<=4;j++){
				for(int k=1;k<=4;k++){
					if(i!=j&&i!=k&&j!=k){
						t+=1;
						System.out.println(i*100+j*10+k);
					
						
					}
				}	
			}
		}
		System.out.println("一共有:"+t+"个");
	
	}

}
