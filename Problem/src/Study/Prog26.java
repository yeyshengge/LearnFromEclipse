package Study;

public class Prog26 {
	
	
	public static void yanghui(int n) {
	int[][] a =new int[n][n];
	for (int i = 0; i < n; i++) {
		a[i][0]=1;
		a[i][i]=1;
		if(i>=2) {
			for (int j = 1; j < i; j++) {
				a[i][j]=a[i-1][j]+a[i-1][j-1];
			}
		}
	}
	for(int i=0;i<n;i++) {
		
		for(int k=1;k<n-i;k++) {
			System.out.print(" ");
		}
		
		
		
		for (int j = 0; j <=i; j++) {
			System.out.print(a[i][j]);
		if(j!=i) 
			System.out.print(" ");
		
		}
		System.out.println();
	}
		
		
	}

	public static void main(String[] args) {
		yanghui(5);
	}
	}
