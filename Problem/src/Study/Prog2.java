package Study;
//�ж�101-200֮���ж��ٸ��������������������
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
		System.out.println("\n101-200֮����"+n+"������");
		
	}
}
