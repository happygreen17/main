<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>

<!DOCTYPE html>
<html>
<head>

<title>'*.about me.*'</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
body {
	font: 20px Montserrat, sans-serif;
	line-height: 1.8;
	color: #f5f6f7;
}

p {
	font-size: 16px;
}

.margin {
	margin-bottom: 45px;
}

.bg-1 {
	background-color: #8d8dc2 /* #aed2e6 */;
	color: #ffffff;
}

.bg-2 {
	background-color: #474e5d; /* Dark Blue */
	color: #ffffff;
}

.bg-3 {
	background-color: #ffffff; /* White */
	color: #555555;
}

.bg-4 {
	background-color: #2f2f2f; /* Black Gray */
	color: #fff;
}

.container-fluid {
	padding-top: 70px;
	padding-bottom: 70px;
}

.navbar {
	border: 0;
	border-radius: 0;
	margin-bottom: 0;
	font-size: 12px;
	letter-spacing: 5px;
}
</style>

</head>
<!-- 내용 시작 -->
<div style="padding-top: 10px;">

	<!-- 상단 메뉴 -->
	<div class="navbar">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#myNavbar">
			<span class="icon-bar"></span>
		</button>
		<a href="<%=root%>/index.jsp" class="navbar-brand"><span
			class="glyphicon glyphicon-home"></span></a>
	</div>
	<!-- 상단 메뉴 끝 -->


	<body>
		<!-- First Container -->
		<div class="container-fluid bg-1 text-center">
			<h3 class="margin">자기소개 페이지</h3>
			<img src="<%=root%>/images/11-2.JPG"
				class="img-responsive img-circle margin" style="display: inline"
				alt="Bird" width="350" height="350">
			<h3>김서연</h3>
		</div>

		<!-- Second Container -->
		<div class="container-fluid bg-2">
			<table class="table" style="width:80%; margin:0 auto;">
				<tbody>
					<tr>
						<th style="width:25%;">이름</th>
						<td style="width:75%;">김서연</td>
					</tr>
					<tr>
						<th>나이</th>
						<td>24 (1995년생, 2018년 현재)</td>
					</tr>
					<tr>
						<th>거주지</th>
						<td>서울 동작구 여늬대방로 28 (현대아파트) </td>
					</tr>
					<tr>
						<th>학력</th>
						<td>동덕여자대학교 졸업 (2017년 8원)</td>
					</tr>
					<tr>
						<th>이력</th>
						<td>빅데이터 오픈소스기반 자바 웹개발-국비지원 6개월 과정 이수중 (솔데스크)</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>여자</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- Third Container (Grid) -->
		<div class="container-fluid bg-3 text-center">
			<h3 class="margin">Where To Find Me?</h3>
			<br>
			<div class="row">
				<div class="col-sm-4">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
					<a href="https://www.dongduk.ac.kr/index.do">
						<img src="<%=root %>/images/dongduk.jpg" class="img-responsive margin" style="width: 100%" alt="동덕여대">
					</a>
				</div>
				<div class="col-sm-4">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
					<img src="birds2.jpg" class="img-responsive margin"
						style="width: 100%" alt="Image">
				</div>
				<div class="col-sm-4">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
					<img src="birds3.jpg" class="img-responsive margin"
						style="width: 100%" alt="Image">
				</div>
			</div>
		</div>

		<!-- *********************************************** -->
		<jsp:include page="/menu/bottom.jsp" flush="false" />
	</body>
</html>
