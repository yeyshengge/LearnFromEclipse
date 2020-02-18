package Number;

public class Chengfa {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
   for(int i=1;i<=9;i++){                  //外层循环
   for(int j=1;j<=9;j++){         //内层循环
		 if(i<j){    //判断变量j的值是否大于变量i的值
		 break;   
		 }
		        System.out.printf("%d*%d=%d ",i,j,i*j);   //输出i*j的值
  }
		       
		 System.out.printf("\n");               //输出换行
}
  }
		

	}


