<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String email = request.getParameter("email");

	boolean flag= dao.duplicateEmail(email);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function use(){
	opener.frm.email.value='<%=email%>';  /* opener는 createForm을 말하낟. */
	self.close();
}
</script>
</head>
<!-- *********************************************** -->
<body>

	<DIV class="title">이메일 중복확인</DIV>
	
	<div class="content">
	입력된 Email : <%= email %><br><br>
	<%
		if(flag){
			out.print("중복되어 사용할 수 없습니다.<br><br>");
		}else{
			out.print("중복 아님, 사용 가능합니다.<br><br>");
			out.print("<button type='button' onclick='use()'>사용</button>");
		}
	%>
	</div>

	<DIV class='bottom'>
		<input type='submit' value='다시 시도' onclick="location.href='./email_form.jsp'"> 
		<input type='button' value='닫기' onclick="window.close()">
	</DIV>

</body>
<!-- *********************************************** -->
</html>
