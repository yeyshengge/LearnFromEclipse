import java.until.Data;


public class Eval01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
Data data = new Data();
String year= String.format("%tY",data);
String month = String.format("%tB",data);
String day = String.format("%td", data);
System.out.println(year);
System.out.println(month);
System.out.println(day);
}

}
