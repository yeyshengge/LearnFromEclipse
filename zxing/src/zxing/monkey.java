package zxing;

public class monkey {

	public static void main(String[] args) {
        int num;

        for (int i=1 ;i<=300;i++){
            num = i*5+1;
            if(num/4*4!=num){
                continue;
            }else{
                    num = num/4*5+1;
                    if(num/4*4!=num) {
                        continue;
                    }else{
                        num = num/4*5+1;
                        if(num/4*4!=num) {
                            continue;
                        }else {
                            num = num / 4 * 5 + 1;
                            if (num / 4 * 4 != num) {
                                continue;
                            } else
                                num = num / 4 * 5 + 1;
                            System.out.println(i);
                            System.out.println(num);
                        }
                    }
            }
        }
    }

}
