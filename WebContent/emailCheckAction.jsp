<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String code = null;
	if(request.getParameter("code") != null){
		code = request.getParameter("code");
	}
	
	UserDAO userDAO = new UserDAO();
	String userID = null;
		
	if(session.getAttribute("userID") != null){
		
		userID = (String)session.getAttribute("userID");
		System.out.println(userID);
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('현재 비로그인 상태입니다.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
	}
	String userEmail = userDAO.getUserEmail(userID);
	System.out.println("이메일 체크!" +userEmail);
	System.out.println("아이디 체크!" +userID);
	boolean emailChk = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
	if(emailChk){
		userDAO.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증 성공!!.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('코드가 유효하지 않습니다!!.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>