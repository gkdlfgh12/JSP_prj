package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	//�α���
	public int login(String userID, String userPassword) {
		String SQL = "SELECT USERPASSWORD FROM USERTBL WHERE USERID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;  //���̵� ������
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -2; //db ����
	}
	
	
	//ȸ������
	public int join(UserVO user) {
		String SQL = "INSERT INTO USERTBL VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserNicname());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserEmailHash());
			pstmt.setInt(6, user.getUserEmailChecked());
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1; //ȸ������ ����
	}
	
	//�̸��� ���� üũ
	public int getUserEmailChecked(String userID) {
		String SQL = "SELECT USEREMAILCHECKED FROM USERTBL WHERE USERID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1; //db ����
	}
	
	//�̸��� ����
	public int setUserEmailChecked(String userID) {
		String SQL = "UPDATE USERTBL SET USEREMAILCHECKED = 1 WHERE USERID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
				
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1; //db ����
	}
	
	
	//�̸��� ��ȯ
	public String getUserEmail(String userID) {
		String SQL = "SELECT USEREMAIL FROM USERTBL WHERE USERID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
						
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return null; //db ����
	}
	
	
	
}
