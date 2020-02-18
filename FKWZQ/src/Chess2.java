
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

public class Chess2 extends JFrame implements MouseListener {
	public Chess2() {
		this.setTitle("五子");
		this.setSize(1000, 700);
		this.setResizable(false) ;
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		int width = Toolkit.getDefaultToolkit().getScreenSize().width;
		int height = Toolkit.getDefaultToolkit().getScreenSize().height;	
		this.setLocation((width - 200)/2, (height-100)/2);
		
		this.addMouseListener(this);
		
		this.setVisible(true);
	}
	
	public void paint(Graphics g) {

		BufferedImage image = null;
		try {
			image = ImageIO.read(new File("E:/image/MLDN文字01.jpg"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		g.drawImage(image,0,0,this);
		g.drawOval(20, 40, 40, 40);
		g.setColor(Color.BLUE);
		g.fillRect(80, 40, 40, 20);
		g.setFont(new Font("宋体",40,40));		
		g.drawString("五子棋游戏", 20, 100);
	}

	public void mouseClicked(MouseEvent arg0) {
		
	}

	public void mouseEntered(MouseEvent arg0) {
		
	}

	public void mouseExited(MouseEvent arg0) {
		
	}

	public void mousePressed(MouseEvent arg0) {
		
	}

	public void mouseReleased(MouseEvent arg0) {
		
	}
	

}
