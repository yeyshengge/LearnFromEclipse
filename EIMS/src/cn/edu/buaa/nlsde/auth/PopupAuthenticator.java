package cn.edu.buaa.nlsde.auth;
import javax.mail.*;
import javax.mail.internet.*;
public class PopupAuthenticator extends Authenticator {
	private String username = null;
	private String password = null;
	public PopupAuthenticator() {
	}
	public PasswordAuthentication performCheck(
		String user,
		String pass) {
		username = user;
		password = pass;
		return getPasswordAuthentication();
	}
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(username, password);
	}
}