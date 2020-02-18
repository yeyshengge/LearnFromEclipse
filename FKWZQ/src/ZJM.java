import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.Graphics;
import java.awt.Image;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JComboBox;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.ActionEvent;
import java.awt.Color;

public class ZJM extends JFrame {

	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ZJM frame = new ZJM();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		
		});
	}

	/**
	 * Create the frame.
	 */
	@SuppressWarnings("null")
	public ZJM() {
		setTitle("\u75AF\u72C2\u4E94\u5B50\u68CB");
		setBackground(Color.GREEN);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(1000, 1000,1384,1042);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);		
		


		
		
		JButton btnNewButton = new JButton("\u91CD\u65B0\u5F00\u59CB");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton.setBounds(1108, 811, 218, 106);
		contentPane.add(btnNewButton);
		
		JButton button = new JButton("\u7ED3\u675F\u6E38\u620F");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		button.setBounds(1108, 705, 218, 106);
		contentPane.add(button);
		
		JPanel zhujianmian = new JPanel();
		zhujianmian.setBounds(26, 0, 974, 875);
		contentPane.add(zhujianmian);
		
	}
}
	

