import java.awt.*;
import javax.swing.*;
public class Example1 extends JFrame {
	public void CreateFrame(String title){
	JFrame jf = new JFrame(title);
	Container container =jf.getContentPane();
	JLabel jl =new JLabel("这是一个窗体");
	jl.setHorizontalAlignment(SwingConstants.CENTER);
	container.add(jl);
	container.setBackground(Color.white);//窗体颜色
	jf.setVisible(true);
	jf.setSize(800,650);//窗体大小
	jf.setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
	}
public static void main(String args[]){
	new Example1().CreateFrame("创建一个JFrame窗体");
}

}
