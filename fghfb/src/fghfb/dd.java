package fghfb;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JButton;
import java.awt.Color;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class dd extends JFrame {

	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					dd frame = new dd();
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
	public dd() {
		setTitle("\u75AF\u72C2\u4E94\u5B50\u68CB");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 1395, 1233);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		//下面为两个按钮
		JButton button = new JButton("\u5F00\u59CB\u6E38\u620F");
		button.setBounds(480, 814, 347, 80);
		button.setForeground(new Color(124, 252, 0));
		button.setBackground(new Color(127, 255, 0));
	
				private JPanel contentPane;

				/**
				 * Launch the application.
				 */
				public static void main(String[] args) {
					EventQueue.invokeLater(new Runnable() {
						public void run() {
							try {
								game frame = new game();
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
				public game() {
					setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
					setBounds(100, 100, 450, 300);
					contentPane = new JPanel();
					contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
					contentPane.setLayout(new BorderLayout(0, 0));
					setContentPane(contentPane);
				}

			}

			public void actionPerformed(ActionEvent e) {
			}
		});
		contentPane.setLayout(null);
		contentPane.add(button);
		
		JButton button_1 = new JButton("\u7ED3\u675F\u6E38\u620F");
		button_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			System.exit(0);	
			}
		});
		button_1.setBounds(480, 960, 347, 80);
		button_1.setForeground(new Color(124, 252, 0));
		button_1.setBackground(new Color(0, 255, 0));
		contentPane.add(button_1);
		
		JButton button_2 = new JButton("\u5236\u4F5C\u4EBA\u5458");
		button_2.setBounds(480, 890, 347, 80);
		button_2.setForeground(new Color(124, 252, 0));
		button_2.setBackground(Color.GREEN);
		button_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		contentPane.add(button_2);
	}
}
