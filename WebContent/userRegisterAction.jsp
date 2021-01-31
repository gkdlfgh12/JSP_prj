<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter"%>

<%

	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}

	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('현재 로그인 중입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	request.setCharacterEncoding("UTF-8");
	String password = null;
	String userPassword = null;
	String userNicname = null;
	String userEmail = null;
	
	
	
	if(request.getParameter("userID") != null){
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = request.getParameter("userPassword");
		//userPassword = SHA256.encodeSha256(password);
	}
	if(request.getParameter("userNicname") != null){
		userNicname = request.getParameter("userNicname");
	}
	if(request.getParameter("userEmail") != null){
		userEmail = request.getParameter("userEmail");
	}
	if(userID == null || userPassword == null || userNicname == null || userEmail == null || userID == "" || userPassword == "" || userNicname == "" || userEmail == ""){
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
	// 회원가입
	int result = userDAO.join(userVO); 
	System.out.print("여기는 if 밖 ");
	
	if(result == -1){
		System.out.print("여기는 첫번째 if 안");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 중복!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	
	}else{
		System.out.print("여기는 두번째 if 아이디 체크"+userID);
		session.setAttribute("userID", userID);
		session.getAttribute("userID");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	
		
	}
	
%>