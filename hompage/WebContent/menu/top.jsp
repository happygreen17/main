<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<%
	String id = (String) session.getAttribute("id");
	String grade = (String) session.getAttribute("grade");
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet"> <!-- 개발자 자기소개페이지 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.navbar {
    position: relative;
    min-height: 50px;
    margin-bottom: 0px;
    border: 1px solid transparent;
}

.member_log { /* 오른쪽 맨위 부분 스타일지정 */
	color:#222222;
	font-size:12px;
}
.nav_list_style{
	font-size:18px;
}
</style>
</head>

<body>
	<!-- 상단 메뉴 -->
	<nav class="navbar" style="width:100%; height: 110px; background-color:#f6f5ef; position:relative;">
		<div class="container-fluid">
			<a href="<%=root%>/index.jsp" class="navbar-brand">
				<img src="<%=root%>/images/main_icon.png" width="85px" height="80px" style="margin-left:100px"/>
			</a>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right" style="padding-right:100px;">
				<%if(id == null){ //로그인  되어있지 않다면 %> 
					<li class="member_log" style="padding:15px 0;"> | </li>
					<li><a href="<%=root%>/member/agreement.jsp" class="member_log"> 회원가입 </a></li>
					<li class="member_log" style="padding:15px 0;"> | </li>
					<li><a href="<%=root%>/member/loginForm.jsp" class="member_log">
						<span class="glyphicon glyphicon-log-in"></span> Login</a></li>
				<%}else{ //로그인  되어있다면 %>
					<li class="member_log" style="padding:15px 0;"> | </li>
					<li><a href="<%=root%>/member/read.jsp" class="member_log">
						<span class="glyphicon glyphicon-user"></span> 마이메뉴 </a></li>
					<li class="member_log" style="padding:15px 0;"> | </li>
					<li><a href="<%=root%>/member/logout.jsp" class="member_log">
						<span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				<%} %>
				</ul>
			</div>
			<div class="collapse navbar-collapse nav_list_style" id="myNavbar" style="position:absolute; left:220px; margin-top:9px;">
				<ul class="nav navbar-nav">
					<li style="padding:0 5px;"><a href="<%=root%>/bbs/list.jsp">질문게시판</a></li>
					<li style="padding:0 5px;"><a href="<%=root%>/search/search_map.jsp">치과 검색&예약</a></li>
					<li style="padding:0 5px;"><a href="<%=root%>/imageList/list.jsp">치료후기</a></li>
					<%if(id!=null && grade.equals("A")){ //로그인 되어있는데 관리자라면 %>
     					<li style="padding:0 5px;"><a href="<%=root%>/admin/list.jsp">회원목록(관리자)</a></li>
   				<%} %>
				</ul>				
			</div>
		</div>
		<div style="position:absolute; top: 109px; width:100%; height: 3px; background-color:black;"></div>
	</nav>
	<!-- 상단 메뉴 끝 -->

	<!-- 내용 시작 -->
	<div style="padding-top: 10px;">
	<!-- div태그를 bottom에서 끝낼 것임 -->