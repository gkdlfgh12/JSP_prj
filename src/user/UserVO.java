package user;

public class UserVO {
	
	private String userID;
	private String userPassword;
	private String userNicname;
	private String userEmail;
	private String userEmailHash;
	private int userEmailChecked;
	
	public UserVO() {
		
	}
	
	public UserVO(String userID, String userPassword, String userNicname, String userEmail, String userEmailHash,
			int userEmailChecked) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userNicname = userNicname;
		this.userEmail = userEmail;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserNicname() {
		return userNicname;
	}
	public void setUserNicname(String userNicname) {
		this.userNicname = userNicname;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public int getUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(int userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	@Override
	public String toString() {
		return "UserVO [userID=" + userID + ", userPassword=" + userPassword + ", userNicname=" + userNicname
				+ ", userEmail=" + userEmail + ", userEmailHash=" + userEmailHash + ", userEmailChecked="
				+ userEmailChecked + "]";
	}
	
	
	
}
