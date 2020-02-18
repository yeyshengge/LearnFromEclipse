
public class MathRandomChar {
public static char GetRandomChar(char cha1,char cha2){
	return (char)(cha1+Math.random()*(cha2-cha1+1));}
public static void main(String[] args){
	System.out.println(GetRandomChar('0','9'));
}
}
