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
				
			</ul>
			
			<form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" name="search" type="text" placeholder="검색할 내용 입력." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" id="joinForm" action="./userRegisterAction.jsp">
			<div class="form-group">
				<label>아이디</label><span id="idChk"></span>
				<input type="text" name="userID" id="userID" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label><span id="pwChk"></span>
				<input type="password" id="userPassword" name="userPassword" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label><span id="pwChk2"></span>
				<input type="password" id="userPassword2" name="userPassword2" class="form-control">
			</div>
			<div class="form-group">
				<label>닉네임</label><span id="nameChk"></span>
				<input type="text" name="userNicname" id="userNicname" class="form-control">
			</div>
			<div class="form-group">
				<label>이메일</label><span id="emailChk"></span>
				<input type="text" name="userEmail" id="userEmail" class="form-control">
			</div>
			
			<button  class="btn btn-outline-success my-2 my-sm-0" type="button" id="joinBtn" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">
			회원가입
			</button>
		</form>
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
<script>
	//jquery 시작
	$(function() {
		
		//이메일 정규표현식
		const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		
		let chkid = false, chkpass=false, chkpass2=false, chkname=false, chkemail=false;
		
		//id 입력값 확인
		$("#userID").on('keyup', function() {
			
			if($("#userID").val() === ""){
				$("#userID").css("background-color","pink");    
				$("#idChk").html('<b style="font-size:14px; color:red;"> [아이디는 필수 정보 입니다.]</b>');
				chkid = false;
			}else{
				$("#userID").css("background-color","aqua"); 
				$("#idChk").html('<b style="font-size:14px; color:blue;"> [조건 충족!]</b>');
				chkid = true;
			}
		});
		
		//1차pw 검증
		$("#userPassword").on('keyup', function() {
			
			if($("#userPassword").val() === ""){
				$("#userPassword").css("background-color","pink");    
				$("#pwChk").html('<b style="font-size:14px; color:red;"> [비밀번호는 필수 정보 입니다.]</b>');
				chkpass = false;
			}else{
				$("#userPassword").css("background-color","aqua"); 
				$("#pwChk").html('<b style="font-size:14px; color:blue;"> [조건 충족!]</b>');
				chkpass = true;
			}
		});
		
		//2차 검증
		$("#userPassword2").on('keyup', function() {
			
			if($("#userPassword2").val() != $("#userPassword").val()){
				$("#userPassword2").css("background-color","pink");
				$("#pwChk2").html('<b style="font-size:14px; color:red;"> [비밀번호 정보가 다릅니다.]</b>');
				chkpass2 = false;
			}else{
				$("#userPassword2").css("background-color","aqua"); 
				$("#pwChk2").html('<b style="font-size:14px; color:blue;"> [체크 완료!]</b>');
				chkpass2 = true;
			}
			
		});//2차pw 끝
		
		//닉네임 체크
		$("#userNicname").on('keyup', function() {
			
			if($("#userNicname").val() === ""){
				$("#userNicname").css("background-color","pink");    
				$("#nameChk").html('<b style="font-size:14px; color:red;"> [닉네임 정보는 필수 정보 입니다.]</b>');
				chkname = false;
			}else{
				$("#userNicname").css("background-color","aqua"); 
				$("#nameChk").html('<b style="font-size:14px; color:blue;"> [체크 완료!]</b>');
				chkname = true;
			}
		});
		
		//이메일 체크
		$("#userEmail").on('keyup', function() {
			if($("#userEmail").val() === ""){
				$("#userEmail").css("background-color","pink");    
				$("#emailChk").html('<b style="font-size:14px; color:red;"> [이메일 정보는 필수 정보 입니다.]</b>');
				chkemail = false;
			}else if(!getMail.test($("#userEmail").val())){
				$("#userEmail").css("background-color","pink");    
				$("#emailChk").html('<b style="font-size:14px; color:red;"> [이메일 정보가 유효하지 않습니다.]</b>');
				chkemail = false;
			}else{
				$("#userEmail").css("background-color","aqua"); 
				$("#emailChk").html('<b style="font-size:14px; color:blue;"> [체크 완료!]</b>');
				chkemail = true;
			}
			
		});
		
		$("#joinBtn").click(function() {
			
			if(chkid && chkpass && chkpass2 && chkname && chkemail){
				$("#joinForm").submit();
			}else{
				alert("입력값 재확인 부탁드립니다.");
			}
		
		});
		
	});
</script>