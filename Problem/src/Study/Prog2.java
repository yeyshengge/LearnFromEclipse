package Study;
//判断101-200之间有多少个素数，并输出所有素数
public class Prog2{
	public static boolean Number(int n){
		if(n==2) return true;
		for(int i=2; i<=n/2;i++){
			if(n % i ==0)return false;
		}
		return true;
		}
	
	public static void main(String[] args){
		int n=0;
		for(int i=101;i<=200; i++){
			if(Number(i)){
				n++;
				System.out.println(i +",");
			}
		}
		System.out.println("\n101-200之间有"+n+"个素数");
		
	}
}
