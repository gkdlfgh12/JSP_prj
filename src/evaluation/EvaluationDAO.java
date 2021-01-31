package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {


	//�۾��� �Լ�
	public int write(EvaluationVO evaluation) {
		String SQL = "INSERT INTO EVALUATION VALUES (EVALUATION_SEQ.NEXTVAL, ?,?,?,?,?,?,?,?,?,?,?,?,0)";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluation.getUserID());
			pstmt.setString(2, evaluation.getLectureName());
			pstmt.setString(3, evaluation.getProfessorName());
			pstmt.setInt(4, evaluation.getLectureYear());
			pstmt.setString(5, evaluation.getSemesterDivide());  //�б� ����
			pstmt.setString(6, evaluation.getLectureDivide());   
			pstmt.setString(7, evaluation.getEvaluationTitle());
			pstmt.setString(8, evaluation.getEvaluationContent());
			pstmt.setString(9, evaluation.getTotalScore());   //�� ����
			pstmt.setString(10, evaluation.getCreditScore()); //������ �󸶳� ���ֳ�
			pstmt.setString(11, evaluation.getInterestScore());  //�󸶳� ��հ� ����ġ��
			pstmt.setString(12, evaluation.getLectureScore());  //�󸶳� ���Ƿ��� ������
			return pstmt.executeUpdate();


		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1;  //������
	}

	//��ü �˻� (���� �ɾ ��õ�� �Ǵ� �ֽż����� ���� ����)
	public ArrayList<EvaluationVO> getList(String lectureDivide, String searchType, String keyword, int pageNum){

		//����� ��ü�� �˻��ҽ� lectureDivide�� ���� ��������� ����
		if(lectureDivide.equals("��ü")) {
			lectureDivide = "";
		}

		ArrayList<EvaluationVO> evaluationList = null;
		String SQL = "";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {


			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT evaluationID, USERID, LECTURENAME, PROFESSORNAME, LECTUREYEAR, SEMESTERDIVIDE, LECTUREDIVIDE, EVALUATIONTITLE, evaluationContent, totalScore, creditScore,interestScore,lectureScore,likeCount FROM\r\n"
						+ "(\r\n"
						+ "    SELECT ROWNUM AS RN, EVL.* FROM\r\n"
						+ "    (\r\n"
						+ "        SELECT * FROM EVALUATION\r\n"
						+ "        WHERE lectureDivide LIKE ? AND evaluationTitle || evaluationContent || lectureName || professorName LIKE ? ORDER BY evaluationid desc\r\n"
						+ "    )EVL\r\n"
						+ ")\r\n"
						+ "WHERE RN >" +(pageNum-1) * 5
						+ "AND   RN <="+ pageNum*5;
			}else if(searchType.equals("��õ��")) {

				SQL = "SELECT evaluationID, USERID, LECTURENAME, PROFESSORNAME, LECTUREYEAR, SEMESTERDIVIDE, LECTUREDIVIDE, EVALUATIONTITLE, evaluationContent, totalScore, creditScore,interestScore,lectureScore,likeCount FROM\r\n"
						+ "(\r\n"
						+ "    SELECT ROWNUM AS RN, EVL.* FROM\r\n"
						+ "    (\r\n"
						+ "        SELECT * FROM EVALUATION\r\n"
						+ "        WHERE lectureDivide LIKE ? AND evaluationTitle || evaluationContent || lectureName || professorName LIKE ? ORDER BY likecount desc\r\n"
						+ "    )EVL\r\n"
						+ ")\r\n"
						+ "WHERE RN >" +(pageNum-1) * 5
						+ " AND   RN <="+ pageNum*5;
			}

			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			System.out.println("44"+lectureDivide+keyword+"44");
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + keyword + "%");
			rs = pstmt.executeQuery();

			evaluationList = new ArrayList<EvaluationVO>();
			while(rs.next()) {
				EvaluationVO evaluation = new EvaluationVO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
						);
				evaluationList.add(evaluation);
			}

			return evaluationList;  //���̵� ������

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}

	//��� ����¡�� ���� ��� ���� Ȯ��
	public int getTotalCount(String keyword, String lectureDivide) {

		//����� ��ü�� �˻��ҽ� lectureDivide�� ���� ��������� ����
		if(lectureDivide.equals("��ü")) {
			lectureDivide = "";
		}

		String SQL = "";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			SQL = "SELECT COUNT(*) FROM EVALUATION WHERE lectureDivide like ? AND evaluationTitle || evaluationContent || lectureName || professorName LIKE ?";

			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			System.out.println("44"+lectureDivide+keyword+"44");
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			//System.out.println("���� Ȯ��"+rs.getInt(0)+"rs");
			if(rs.next()) {
				System.out.println("���� Ȯ��"+rs.getInt(1)+"rs");
				return rs.getInt(1);
			}

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}

		return 0;
	}

	//��õ ó�� �Լ�
	public int like(String evaluationID) {
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount+ 1 WHERE EVALUATIONID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));

			return pstmt.executeUpdate();

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}

	//�Խñ� ����
	public int delete(String evaluationID) {
		String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}

	//�Խñ��� userid �ҷ�����
	public String getUserID(String evaluationID) {
		String SQL = "SELECT USERID FROM evaluation WHERE evaluationID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			
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
		return null;
	}
}
