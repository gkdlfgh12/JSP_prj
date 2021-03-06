<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.io.PrintWriter" %>
    <%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content ="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>JSP대학 강의평가 사이트</title>
<!-- 부트스트랩 css추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('현재 비로그인 입니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp"><img src="img/jsp2.png">JSP대학 강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">MAIN</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
	<%
		if(userID == null){
	%>				
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
						
	<%
		}else{
	%>
		<a class="dropdown-item" href="userLogoutAction.jsp">로그아웃</a>
	<%
		}
	%>
					</div>
				</li>
				<li class="nav-item active">
					<a class="nav-link"><%=userID %>님이 입장했습니다.</a>
				</li>
			</ul>
			
			<form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" name="search" type="text" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
		
		<div class="alert alert-warning mt-4" role="alert">
			이메일 주소 인증을 하십시오.
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 재전송</a>
		
	</section>
	
	
	
	
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2020 하일호 All Right Reserved.
	</footer>
	<!-- jquery 및 js 추가 -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/jqpooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>