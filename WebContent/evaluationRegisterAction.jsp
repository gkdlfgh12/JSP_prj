<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationVO" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}

	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	String lectureName =null;  
	String professorName=null;
	int lectureYear=0;
	String semesterDivide=null;
	String lectureDivide=null;
	String evaluationTitle=null;
	String evaluationContent=null;
	String totalScore=null;
	String creditScore=null;
	String interestScore=null;
	String lectureScore=null;
		
	boolean nullChk=true;
	//강의 평가 등록 처리
	if(request.getParameter("lectureName") != null){
		lectureName = request.getParameter("lectureName");
	}
	if(request.getParameter("professorName") != null){
		professorName = request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear") != null){
		try{
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		}catch(Exception e){
			System.out.println(" 강의 연도 오류입니다");
		}
		
	}
	if(request.getParameter("semesterDivide") != null){
		semesterDivide = request.getParameter("semesterDivide");
	}
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("evaluationTitle") != null){
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null){
		evaluationContent = request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore") != null){
		totalScore = request.getParameter("totalScore");
	}
	if(request.getParameter("creditScore") != null){
		creditScore = request.getParameter("creditScore");
	}
	if(request.getParameter("interestScore") != null){
		interestScore = request.getParameter("interestScore");
	}
	if(request.getParameter("lectureScore") != null){
		lectureScore = request.getParameter("lectureScore");
	}
	
	//값이 널로 들어오면 다시 빽!
	if(lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null || lectureDivide == null ||
			evaluationTitle == null || evaluationContent == null || totalScore == null || creditScore == null || interestScore == null || lectureScore == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('미입력 존재');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		System.out.println("\n여기는 미입력 체크 ");
		nullChk=false;
	}
	//값이 빈공간으로 들어오면 다시 빽!
	if(lectureName.equals("") || professorName.equals("") || lectureYear == 0 || semesterDivide.equals("") || lectureDivide.equals("") ||
			evaluationTitle.equals("") || evaluationContent.equals("") || totalScore.equals("") || creditScore.equals("") || interestScore.equals("") || lectureScore.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('미입력 존재');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		System.out.println("\n여기는 미입력 체크 ");
		nullChk=false;
	}
	if(nullChk==true){		
	EvaluationDAO evalDAO = new EvaluationDAO();
	
	int result = evalDAO.write(new EvaluationVO(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide, 
			evaluationTitle, evaluationContent, totalScore, creditScore, interestScore, lectureScore, 0));  // 회원가입
		
	System.out.print("여기는 if 밖 ");
	
	if(result == 1){
		System.out.print("여기는 첫번째 if 안");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가 등록 완료');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	
	}else{
		System.out.print("여기는 두번째 if 아이디 체크"+userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류 발생');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
		
	}
	
%>