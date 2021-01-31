<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyVO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();
	String userID =  null;
	if(session.getAttribute("userID") != null ){
		userID = (String)session.getAttribute("userID");
	}
	System.out.println("유저 아이디좀 체크함"+userID);
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
///////////검색시 및 페이징 값 유지 하기위한 선언
	String lectureDivide = "전체";   
	String searchType = "최신순";
	String keyword = "";
	int pageNum=1;
	int totalCount=0;
	
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("keyword") != null){
		keyword = request.getParameter("keyword");
	}
	try{
		
		if(request.getParameter("pageNum") != null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
			System.out.println("페이지가 숫자 형으로 변환됬다."+pageNum);
		}else{
			System.out.println("널이 아니다 페이지넘은 널이다."+request.getParameter("pageNum"));
		}
		
	}catch(Exception e){
		System.out.println(e);
	}
///////////////////////////////////////////

%>
<%	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	
	if(request.getParameter("evaluationID") != null){
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evalDAO = new EvaluationDAO();
	if(userID.equals(evalDAO.getUserID(evaluationID)) || userID.equals("admin")){
		
		int result =  new EvaluationDAO().delete(evaluationID);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제가 완료되었습니다.');");
			script.println("location.href='index.jsp?pageNum="+pageNum+"&keyword="+keyword+"&lectureDivide="+lectureDivide+"';");
			script.println("</script>");
			script.close();
		
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류 발생');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.');");
		script.println("location.href='index.jsp?pageNum="+pageNum+"&keyword="+keyword+"&lectureDivide="+lectureDivide+"';");
		script.println("</script>");
		script.close();
		return;
	}	
%>