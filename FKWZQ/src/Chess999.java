
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
	// 保存棋子的坐标
	int x = 0;
	int y = 0;
	// 保存之前下过的全部棋子的坐标
	// 其中数据内容 0： 表示这个点并没有棋子， 1： 表示这个点是黑子， 2：表示这个点是白子
	int[][] allChess = new int[19][19];
	// 标识当前应该黑棋还是白棋下下一步
	boolean isBlack = true;
	// 标识当前游戏是否可以继续
	boolean canPlay = true;
	public Chess999() {
		//将窗口命名为“疯狂五子棋”
		this.setTitle("疯狂五子棋");
		//定义窗口的大小
		this.setSize(500, 500);
		//定义窗口出现的位置
		this.setLocation((width - 500) / 2, (height - 500) / 2);
		//将窗体设置为大小不可变
		this.setResizable(false);
		//将窗体的关闭方式设置为默认关闭后程序结束
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		//在窗体中加入鼠标监听器
		this.addMouseListener(this);
		//设置窗体为可见
		this.setVisible(true);
		//防止窗体打开时显示不出，刷新
		this.repaint();
		//为窗体加入背景图片
		String imagePath = "" ;
		try {
			imagePath = System.getProperty("user.dir")+"/bin/image/White3.jpg" ;
			bgImage = ImageIO.read(new File(imagePath.replaceAll("\\\\", "/")));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//开始在背景图片上画棋盘、棋子和一些按钮
	public void paint(Graphics g) {
		BufferedImage bi = new BufferedImage(500, 500,
				BufferedImage.TYPE_INT_RGB);
		Graphics g2 = bi.createGraphics();
		g2.setColor(Color.BLACK);
		g2.drawImage(bgImage, 1, 20, this);
		// 绘制棋盘
		for (int i = 0; i < 19; i++) {
			g2.drawLine(10, 70 + 20 * i, 370, 70 + 20 * i);
			g2.drawLine(10 + 20 * i, 70, 10 + 20 * i, 430);
		}
		// 标注点位
		g2.fillOval(68, 128, 4, 4);
		g2.fillOval(308, 128, 4, 4);
		g2.fillOval(308, 368, 4, 4);
		g2.fillOval(68, 368, 4, 4);
		g2.fillOval(308, 248, 4, 4);
		g2.fillOval(188, 128, 4, 4);
		g2.fillOval(68, 248, 4, 4);
		g2.fillOval(188, 368, 4, 4);
		g2.fillOval(188, 248, 4, 4);
		// 绘制全部棋子
		for (int i = 0; i < 19; i++) {
			for (int j = 0; j < 19; j++) {
				if (allChess[i][j] == 1) {
					// 黑子
					int tempX = i * 20 + 10;
					int tempY = j * 20 + 70;
					g2.fillOval(tempX - 7, tempY - 7, 14, 14);
				}
				if (allChess[i][j] == 2) {
					// 白子
					int tempX = i * 20 + 10;
					int tempY = j * 20 + 70;
					//棋子颜色
					g2.setColor(Color.WHITE);
					//棋子大小
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
		//游戏能否进行
		if (canPlay == true) {
			x = e.getX();
			y = e.getY();
			if (x >= 10 && x <= 370 && y >= 70 && y <= 430) {
				x = (x - 10) / 20;
				y = (y - 70) / 20;
				if (allChess[x][y] == 0) {
					//判断要下的是什么颜色的棋子
					if (isBlack == true) {
						allChess[x][y] = 1;
						isBlack = false;
					} else {
						allChess[x][y] = 2;
						isBlack = true;
					}
					//判断所下棋子能否与相同颜色的棋子连城五个，即判断是否胜利
					boolean winFlag = this.checkWin();
					if (winFlag == true) {
						JOptionPane.showMessageDialog(this, "游戏结束,"
								+ (allChess[x][y] == 1 ? "黑方" : "白方") + "获胜！");
						canPlay = false;
					}
				} else {
					JOptionPane.showMessageDialog(this, "当前位置已经有棋子，请重新落子！");
				}
				this.repaint();
			}
		}
		//绘制重新开始游戏按钮的位置及实现其功能
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 70
				&& e.getY() <= 100) {
			int result = JOptionPane.showConfirmDialog(this, "是否重新开始游戏?");
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
		//绘制认输按扭的位置及实现其功能
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 270
				&& e.getY() <= 300) {
			int result = JOptionPane.showConfirmDialog(this, "是否确认认输?");
			if (result == 0) {
				if (isBlack) {
					JOptionPane.showMessageDialog(this, "黑方已经认输,游戏结束!");
				} else {
					JOptionPane.showMessageDialog(this, "白方已经认输,游戏结束!");
				}
				canPlay = false;
			}
		}
		// 绘制关于按钮及实现其功能
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 320
				&& e.getY() <= 350) {
			JOptionPane.showMessageDialog(this,
					"本游戏由第25小组制作！");
		}
		// 绘制退出游戏按钮及实现其功能
		if (e.getX() >= 400 && e.getX() <= 470 && e.getY() >= 370
				&& e.getY() <= 400) {
			JOptionPane.showMessageDialog(this, "游戏结束");
			System.exit(0);
		}
	}
	public void mouseReleased(MouseEvent e) {
	}
	private boolean checkWin() {
		boolean flag = false;
		// 保存共有相同颜色多少棋子相连
		int count = 1;
		// 判断横向是否有5个棋子相连，特点 纵坐标 是相同， 即allChess[x][y]中y值是相同
		int color = allChess[x][y];
		// 判断横向
		count = this.checkCount(1, 0, color);
		if (count >= 5) {
			flag = true;
		} else {
			// 判断纵向
			count = this.checkCount(0, 1, color);
			if (count >= 5) {
				flag = true;
			} else {
				// 判断右上、左下
				count = this.checkCount(1, -1, color);
				if (count >= 5) {
					flag = true;
				} else {
					// 判断右下、左上
					count = this.checkCount(1, 1, color);
					if (count >= 5) {
						flag = true;
					}
				}
			}
		}
		return flag;
	}
	// 判断棋子连接的数量
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