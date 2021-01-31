<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userNicname = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null){
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userNicname") != null){
		userNicname = request.getParameter("userNicname");
	}
	if(request.getParameter("userEmail") != null){
		userEmail = request.getParameter("userEmail");
	}
	if(userID == null || userPassword == null || userID == "" || userPassword == ""){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('미입력 존재');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		System.out.println("\n여기는 미입력 체크 ");
	}
	
	UserDAO userDAO = new UserDAO();
	UserVO userVO = new UserVO(userID, SHA256.getSHA256(userPassword), userNicname, userEmail, SHA256.getSHA256(userEmail),0);
	
	//로그인 체크
	int result = userDAO.login(userID, SHA256.getSHA256(userPassword));
	System.out.print("여기는 if 밖 ");
	
	if(result == 1){
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 또는 비밀번호가 올바르지 않습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 또는 비밀번호가 올바르지 않습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류 발생.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>