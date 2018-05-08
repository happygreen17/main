<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	String id = upload.getParameter("id");
	String email = upload.getParameter("email");

	String str = "";
	if (dao.duplicateId(id)) {
		str = "중복된 아이디입니다. 아이디 중복 확인하세요.";
	} else if (dao.duplicateEmail(email)) {
		str = "중복된 이메일입니다. 이메일 중복 확인하세요.";
	} else {
		request.setAttribute("upload", upload); //request객체에다가 저장하는 것임.!!!!!!!!!!!!~!~!~!~
%>
		<!-- request.sendRedirect로 보내면 값이 사라짐. 그러므로 아래의 액션태그를 사용한다.forword -->
		<jsp:forward page="/member/createProc.jsp"/>			<!-- 이동하라는 뜻 -->
<%
	return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">아이디 및 이메일 중복확인</DIV>
	<div class="content">
		<%=str%>
	</div>
	<DIV class='bottom'>
		<input type='button' value='다시시도' onclick="history.back()">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
	</html>