
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class Chess999 extends JFrame implements MouseListener, Runnable {
	int width = Toolkit.getDefaultToolkit().getScreenSize().width;
	int height = Toolkit.getDefaultToolkit().getScreenSize().height;
	BufferedImage bgImage = null;
	// �������ӵ�����
	int x = 0;
	int y = 0;
	// ����֮ǰ�¹���ȫ�����ӵ�����
	// ������������ 0�� ��ʾ����㲢û�����ӣ� 1�� ��ʾ������Ǻ��ӣ� 2����ʾ������ǰ���
	int[][] allChess = new int[19][19];
	// ��ʶ��ǰӦ�ú��廹�ǰ�������һ��
	boolean isBlack = true;
	// ��ʶ��ǰ��Ϸ�Ƿ���Լ���
	boolean canPlay = true;
	public Chess999() {
		//����������Ϊ����������塱
		this.setTitle("���������");
		//���崰�ڵĴ�С
		this.setSize(500, 500);
		//���崰�ڳ��ֵ�λ��
		this.setLocation((width - 500) / 2, (height - 500) / 2);
		//����������Ϊ��С���ɱ�
		this.setResizable(false);
		//������Ĺرշ�ʽ����ΪĬ�Ϲرպ�������
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		//�ڴ����м�����������
		this.addMouseListener(this);
		//���ô���Ϊ�ɼ�
		this.setVisible(true);
		//��ֹ�����ʱ��ʾ������ˢ��
		this.repaint();
		//Ϊ������뱳��ͼƬ
		String imagePath = "" ;
		try {
			imagePath = System.getProperty("user.dir")+"/bin/image/White3.jpg" ;
			bgImage = ImageIO.read(new File(imagePath.replaceAll("\\\\", "/")));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//��ʼ�ڱ���ͼƬ�ϻ����̡����Ӻ�һЩ��ť
	public void paint(Graphics g) {
		BufferedImage bi = new BufferedImage(500, 500,
				BufferedImage.TYPE_INT_RGB);
		Graphics g2 = bi.createGraphics();
		g2.setColor(Color.BLACK);
		g2.drawImage(bgImage, 1, 20, this);
		// ��������
		for (int i = 0; i < 19; i++) {
			g2.drawLine(10, 70 + 20 * i, 370, 70 + 20 * i);
			g2.drawLine(10 + 20 * i, 70, 10 + 20 * i, 430);
		}
		// ��ע��λ
		g2.fillOval(68, 128, 4, 4);
		g2.fillOval(308, 128, 4, 4);
		g2.fillOval(308, 368, 4, 4);
		g2.fillOval(68, 368, 4, 4);
		g2.fillOval(308, 248, 4, 4);
		g2.fillOval(188, 128, 4, 4);
		g2.fillOval(68, 248, 4, 4);
		g2.fillOval(188, 368, 4, 4);
		g2.fillOval(188, 248, 4, 4);
		// ����ȫ������
		for (int i = 0; i < 19; i++) {
			for (int j = 0; j < 19; j++) {
				if (allChess[i][j] == 1) {
					// ����
					int tempX = i * 20 + 10;
					int tempY = j * 20 + 70;
					g2.fillOval(tempX - 7, tempY - 7, 14, 14);
				}
				if (allChess[i][j] == 2) {
					// ����
					int tempX = i * 20 + 10;
					int tempY = j * 20 + 70;
					//������ɫ
					g2.setColor(Color.WHITE);
					//���Ӵ�С
					g2.fillOval(tempX - 7, tempY - 7, 14, 14);
					g2.setColor(Color.BLACK);
					g2.drawOval(tempX - 7, tempY - 7, 14, 14);
				}
			}
		}
		g.drawImage(bi, 0, 0, this);
	}
	public void mouseClicked(MouseEvent e) {
	}
	public void mouseEntered(MouseEvent e) {
	}
	public void mouseExited(MouseEvent e) {
	}
	public void mousePressed(MouseEvent e) {
		//��Ϸ�ܷ����
		if (canPlay == true) {
			x = e.getX();
			y = e.getY();
			if (x >= 10 && x <= 370 && y >= 70 && y <= 430) {
				x = (x - 10) / 20;
				y = (y - 70) / 20;
				if (allChess[x][y] == 0) {
					//�ж�Ҫ�µ���ʲô��ɫ������
					if (isBlack == true) {
						allChess[x][y] = 1;
						isBlack = false;
					} else {
						allChess[x][y] = 2;
						isBlack = true;
					}
					//�ж����������ܷ�����ͬ��ɫ������������������ж��Ƿ�ʤ��
					boolean winFlag = this.checkWin();
					if (winFlag == true) {
						JOptionPane.showMessageDialog(this, "��Ϸ����,"
								+ (allChess[x][y] == 1 ? "�ڷ�" : "�׷�") + "��ʤ��");
						canPlay = false;
					}
				} else {
					JOptionPane.showMessageDialog(this, "��ǰλ���Ѿ������ӣ����������ӣ�");
				}
				this.repaint();
			}
		}
		//�������¿�ʼ��Ϸ��ť��λ�ü�ʵ���书��
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 70
				&& e.getY() <= 100) {
			int result = JOptionPane.showConfirmDialog(this, "�Ƿ����¿�ʼ��Ϸ?");
			if (result == 0) {
				for (int i = 0; i < 19; i++) {
					for (int j = 0; j < 19; j++) {
						allChess[i][j] = 0;
					}
				}
				isBlack = true;
				this.canPlay = true; 
				this.repaint();
			}
		}
		//�������䰴Ť��λ�ü�ʵ���书��
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 270
				&& e.getY() <= 300) {
			int result = JOptionPane.showConfirmDialog(this, "�Ƿ�ȷ������?");
			if (result == 0) {
				if (isBlack) {
					JOptionPane.showMessageDialog(this, "�ڷ��Ѿ�����,��Ϸ����!");
				} else {
					JOptionPane.showMessageDialog(this, "�׷��Ѿ�����,��Ϸ����!");
				}
				canPlay = false;
			}
		}
		// ���ƹ��ڰ�ť��ʵ���书��
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 320
				&& e.getY() <= 350) {
			JOptionPane.showMessageDialog(this,
					"����Ϸ�ɵ�25С��������");
		}
		// �����˳���Ϸ��ť��ʵ���书��
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 370
				&& e.getY() <= 400) {
			JOptionPane.showMessageDialog(this, "��Ϸ����");
			System.exit(0);
		}
	}
	public void mouseReleased(MouseEvent e) {
	}
	private boolean checkWin() {
		boolean flag = false;
		// ���湲����ͬ��ɫ������������
		int count = 1;
		// �жϺ����Ƿ���5�������������ص� ������ ����ͬ�� ��allChess[x][y]��yֵ����ͬ
		int color = allChess[x][y];
		// �жϺ���
		count = this.checkCount(1, 0, color);
		if (count >= 5) {
			flag = true;
		} else {
			// �ж�����
			count = this.checkCount(0, 1, color);
			if (count >= 5) {
				flag = true;
			} else {
				// �ж����ϡ�����
				count = this.checkCount(1, -1, color);
				if (count >= 5) {
					flag = true;
				} else {
					// �ж����¡�����
					count = this.checkCount(1, 1, color);
					if (count >= 5) {
						flag = true;
					}
				}
			}
		}
		return flag;
	}
	// �ж��������ӵ�����
	private int checkCount(int xChange, int yChange, int color) {
		int count = 1;
		int tempX = xChange;
		int tempY = yChange;
		while (x + xChange >= 0 && x + xChange <= 18 && y + yChange >= 0
				&& y + yChange <= 18
				&& color == allChess[x + xChange][y + yChange]) {
			count++;
			if (xChange != 0)
				xChange++;
			if (yChange != 0) {
				if (yChange > 0)
					yChange++;
				else {
					yChange--;
				}
			}
		}
		xChange = tempX;
		yChange = tempY;
		while (x - xChange >= 0 && x - xChange <= 18 && y - yChange >= 0
				&& y - yChange <= 18
				&& color == allChess[x - xChange][y - yChange]) {
			count++;
			if (xChange != 0)
				xChange++;
			if (yChange != 0) {
				if (yChange > 0)
					yChange++;
				else {
					yChange--;
				}
			}
		}
		return count;
	}
	public void run() {
	}
	public static void main(String[] args) {
		Chess999 ff = new Chess999();
	}
}