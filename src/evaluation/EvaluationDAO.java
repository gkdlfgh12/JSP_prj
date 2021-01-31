package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {


	//글쓰기 함수
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
			pstmt.setString(5, evaluation.getSemesterDivide());  //학기 구분
			pstmt.setString(6, evaluation.getLectureDivide());   
			pstmt.setString(7, evaluation.getEvaluationTitle());
			pstmt.setString(8, evaluation.getEvaluationContent());
			pstmt.setString(9, evaluation.getTotalScore());   //총 점수
			pstmt.setString(10, evaluation.getCreditScore()); //학점을 얼마나 잘주나
			pstmt.setString(11, evaluation.getInterestScore());  //얼마나 재밌게 가르치나
			pstmt.setString(12, evaluation.getLectureScore());  //얼마나 강의력이 좋은가
			return pstmt.executeUpdate();


		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return -1;  //오류시
	}

	//전체 검색 (조건 걸어서 추천순 또는 최신순으로 변경 가능)
	public ArrayList<EvaluationVO> getList(String lectureDivide, String searchType, String keyword, int pageNum){

		//여기는 전체로 검색할시 lectureDivide의 값을 빈공안으로 지정
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}

		ArrayList<EvaluationVO> evaluationList = null;
		String SQL = "";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {


			if(searchType.equals("최신순")) {
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
			}else if(searchType.equals("추천순")) {

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

			return evaluationList;  //아이디 미존재

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try { if(conn!=null) conn.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close(); }catch (Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close(); }catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}

	//댓글 페이징을 위한 댓글 갯수 확인
	public int getTotalCount(String keyword, String lectureDivide) {

		//여기는 전체로 검색할시 lectureDivide의 값을 빈공안으로 지정
		if(lectureDivide.equals("전체")) {
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
			//System.out.println("갯수 확인"+rs.getInt(0)+"rs");
			if(rs.next()) {
				System.out.println("갯수 확인"+rs.getInt(1)+"rs");
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

	//추천 처리 함수
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

	//게시글 삭제
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

	//게시글의 userid 불러오기
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
