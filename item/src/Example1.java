import java.awt.*;
import javax.swing.*;
public class Example1 extends JFrame {
	public void CreateFrame(String title){
	JFrame jf = new JFrame(title);
	Container container =jf.getContentPane();
	JLabel jl =new JLabel("����һ������");
	jl.setHorizontalAlignment(SwingConstants.CENTER);
	container.add(jl);
	container.setBackground(Color.white);//������ɫ
	jf.setVisible(true);
	jf.setSize(800,650);//�����С
	jf.setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
	}
public static void main(String args[]){
	new Example1().CreateFrame("����һ��JFrame����");
}

}
