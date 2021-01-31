package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {

		return new PasswordAuthentication("[아이디]","[비밀번호]");  //실제 이메일을 보낼 구글 계정 등록
	}
	
	
	
}
