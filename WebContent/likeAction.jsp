<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyVO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%!
	//현재 사용자의 ip주소를 불러온다.
	public static String getCilentIP(HttpServletRequest request){
	String ip = request.getHeader("X-FORWARDED-FOR");
	
	if(ip == null || ip.length() == 0){  
		ip=request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0){  
		ip=request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0){  
		ip=request.getRemoteAddr();
	}
	return ip;
}

%>
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
		
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	
	if(request.getParameter("evaluationID") != null){
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evalDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO(); 
	
	//좋아요 중복 확인
	int result = likeyDAO.like(userID, evaluationID, getCilentIP(request));
		
		//이미 추천한 게시글이 있는지 확인
		if(result == 1){
			result = evalDAO.like(evaluationID);
			
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('추천이 완료되었습니다.');");
				script.println("location.href='index.jsp?pageNum="+pageNum+"&keyword="+keyword+"&lectureDivide="+lectureDivide+"';");
				script.println("</script>");
				script.close();
				return;
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('오류 발생!.');");
				script.println("location.href='index.jsp?pageNum="+pageNum+"&keyword="+keyword+"&lectureDivide="+lectureDivide+"';");
				script.println("</script>");
				script.close();
				return;
			}
			
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 추천할 게시글 입니다.');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
%>