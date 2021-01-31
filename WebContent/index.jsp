<%@page import="org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation"%>
<%@page import="evaluation.EvaluationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.net.*" %>
    <%@ page import="util.PageCreator" %>
    <%@page import="evaluation.EvaluationDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content ="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의평가 사이트</title>
<!-- 부트스트랩 css추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 추가 -->
<link rel="stylesheet" href="./css/custom.css">


</head>
<body>

<%

	request.setCharacterEncoding("UTF-8");
	

	//검색시 및 페이징 초기화 값들
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

	
	//pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int emailChecked = userDAO.getUserEmailChecked(userID);
	
	if(emailChecked == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	//페이징을 위해서 선언
	PageCreator pc = new PageCreator();
  	pc.setPageNum(pageNum);
  	pc.setArticleTotalCount(keyword, lectureDivide);
  	
  	ArrayList<EvaluationVO> evalArrayList = new ArrayList<EvaluationVO>();
	evalArrayList = new EvaluationDAO().getList(lectureDivide, searchType, keyword, pageNum);
	System.out.println("사이즈 체크"+evalArrayList.size());
%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">

		<a class="navbar-brand" href="index.jsp"><img src="img/jsp2.png">JSP대학 대학교 강의평가</a>
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
				<input class="form-control mr-sm-2" name="keyword" type="text" placeholder="검색할 내용 입력." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">검색</button>
			</form>
		</div>
		
		
	</nav>
	
	<section class="container" >
		
	<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">등록하기</a>
		<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#reportModal" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">신고</a>
		
<%
	
	
	if(evalArrayList != null){
		for(int i=0; i < evalArrayList.size(); i++){
		
		EvaluationVO evalVO = evalArrayList.get(i);	
		
%>		
		<!-- 강의 평가 글 -->
		<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row" >
				<div class="col-8 text-left">강의명 : <%=evalVO.getLectureName() %>,  <span>교수명 : <%=evalVO.getUserID()%></span>
					<br><small>작성자 : <%=evalVO.getUserID()%></small></div>
				<div class="col-4 text-right">
					<span style="color: purple;">  추천 : <%=evalVO.getLikeCount() %></span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title">
				<%=evalVO.getEvaluationTitle() %> <small><%=evalVO.getSemesterDivide() %></small>
			</h5>
			<p class="card-text"><%=evalVO.getEvaluationContent() %></p>
		</div>
		<div class="row">
			<div class="col-9 text-left">
			 	성적 <span style="color: purple;"><%=evalVO.getCreditScore() %></span>
			 	강의 <span style="color: purple;"><%=evalVO.getLectureScore() %></span>
			 	흥미 <span style="color: purple;"><%=evalVO.getInterestScore() %></span>
			 	종합 <span style="color: red;"><%=evalVO.getTotalScore() %></span>
			 	
			</div>
			<div class="col-3 text-right">
				<a class="btn btn-primary mx-1 mt-2" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24;
				 opacity: 0.8" onclick="return confirm('추천 하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evalVO.getEvaluationID()%>&pageNum=<%=pc.getPageNum()%>&keyword=<%=keyword%>&lectureDivide=<%=lectureDivide %>">추천</a>
				
				<a class="btn btn-primary mx-1 mt-2" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24;
				 opacity: 0.8" onclick="return confirm('삭제 하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evalVO.getEvaluationID()%>&pageNum=<%=pc.getPageNum()%>&keyword=<%=keyword%>&lectureDivide=<%=lectureDivide %>">삭제</a>
			</div>
		</div>
		</div>
		<br>
<%
		}
	}
%>		

		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공" <% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
				<option value="교양" <% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
				<option value="기타" <% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
					<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
					<option value="최신순" <% if(searchType.equals("최신순")) out.println("selected"); %>>최신순</option>
				</select>
			<input type="text" name="keyword" class="form-control mx-1 mt-2" placeholder="검색할 내용 입력.">
			<button type="submit" class="btn btn-primary mx-1 mt-2" style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">검색</button>
		</form><br>

<!-- 페이징 처리 부분  -->
			<ul class="pagination justify-content-center">
                      <% 
                      	
                      	
                      	System.out.println("pageNum의 번호 값 "+pc.getPageNum());
                      	if(pc.isPrev()){
                      %>
	                     	<li class="page-item">
								<a class="page-link" href="index.jsp?pageNum=<%=pc.getBeginPage()-1%>&keyword=<%=keyword%>&lectureDivide=<%=lectureDivide %>"
								style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8"> 이전</a>
							</li>
					  <% 
                      	}
                      	for(int i=pc.getBeginPage();i<=pc.getEndPage();i++){
                      %>		
							<li class="page-item"> 
							   <a href="index.jsp?pageNum=<%=i%>&keyword=<%=keyword%>&lectureDivide=<%=lectureDivide %>" class="page-link page-active" <%-- <%if(pc.getPageNum()==i){out.println("page-active");} %> --%> style="margin-top: 0; height: 40px; color: pink; border: 1px solid #643691;"> <%=i %></a>
							</li>
					  <%
					    }
					  %>
					  <%
					  	if(pc.isNext()){
					  %>
					   	    <li class="page-item">
						      <a class="page-link" href="index.jsp?pageNum=<%=pc.getEndPage()+1%>&keyword=<%=keyword%>&lectureDivide=<%=lectureDivide %>" 
						      style="background-color: #643691; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">다음</a>
						    </li>
					 <%
					  	}
					 %>
				    </ul>
					<!-- 페이징 처리 끝 -->

		
	</section>
	
	
	
	<!-- 평가 모달 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">
							&times;
						</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<input type="text" name="professorName" class="form-control" maxlength="20">
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-4"> 
								<label>수강 연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" selected>2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
								</select>
							</div>
								
							<div class="form-group col-sm-4"> 
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기" selected>1학기</option>								
									<option value="2학기">2학기</option>								
								</select>
							</div>
								
							<div class="form-group col-sm-4"> 
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						 </div>
						 <div class="form-group">
						 	<label>제목</label>
						 	<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						 </div>
						 <div class="form-group">
						 	<label>내용</label>
						 	<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						 </div>
						 <div class="form-row">
						 	<div class="form-group col-sm-3">
						 		<label>종합</label>
						 		<select name="totalScore" class="form-control">
						 			<option value="A" selected>A</option>
						 			<option value="B">B</option>
						 			<option value="C">C</option>
						 			<option value="D">D</option>
						 			<option value="E">E</option>
						 			<option value="F">F</option>
						 		</select>
						 	</div>
						 	<div class="form-group col-sm-3">
						 		<label>성적</label>
						 		<select name="creditScore" class="form-control">
						 			<option value="A" selected>A</option>
						 			<option value="B">B</option>
						 			<option value="C">C</option>
						 			<option value="D">D</option>
						 			<option value="E">E</option>
						 			<option value="F">F</option>
						 		</select>
						 	</div>
						 	<div class="form-group col-sm-3">
						 		<label>흥미</label>
						 		<select name="interestScore" class="form-control">
						 			<option value="A" selected>A</option>
						 			<option value="B">B</option>
						 			<option value="C">C</option>
						 			<option value="D">D</option>
						 			<option value="E">E</option>
						 			<option value="F">F</option>
						 		</select>
						 	</div>
						 	<div class="form-group col-sm-3">
						 		<label>강의력</label>
						 		<select name="lectureScore" class="form-control">
						 			<option value="A" selected>A</option>
						 			<option value="B">B</option>
						 			<option value="C">C</option>
						 			<option value="D">D</option>
						 			<option value="E">E</option>
						 			<option value="F">F</option>
						 		</select>
						 	</div>
						 </div>
						 <div class="modal-footer">
						 	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						 	<button type="submit" class="btn btn-secondary">등록</button>
						 </div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 신고 모달 -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">
							&times;
						</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./ReportAction.jsp" method="post">
						 <div class="form-group">
						 	<label>신고 제목</label>
						 	<input type="text" name="reportTitle" class="form-control" maxlength="30">
						 </div>
						 <div class="form-group">
						 	<label>신고 내용</label>
						 	<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						 </div>
						 
						 <div class="modal-footer">
						 	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						 	<button type="submit" class="btn btn-danger">신고</button>
						 </div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2020 하일호 All Right Reserved.
	</footer>
	<!-- jquery 및 js 추가 -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/jqpooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>