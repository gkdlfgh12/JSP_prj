<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
</head>
<body>

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
			</ul>
			
			<form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" name="search" type="text" placeholder="검색할 내용 입력." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="error-template">
                <h1>
                    에러 페이지!
                </h1>
                <h1>
                    400
                </h1>
                <div class="error-details">
                   페이지를 정상적으로 불러올 수 없습니다.
                </div>
                <div class="error-actions">
                    <a href="index.jsp" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-home"></span>
                       	메인페이지로 이동
                    </a>
                       	
                </div>
            </div>
        </div>
    </div>
    </div><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2020 하일호 All Right Reserved.
	</footer>
	<!-- jquery 및 js 추가 -->
	<script src="./js/jquery.min.js"></script>
	<script src="./js/jqpooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>