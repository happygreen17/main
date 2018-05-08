<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<jsp:useBean id="dto" class="member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />
<%
	boolean flag = dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function read(){
	var url="./read.jsp";
	url += "?id=<%=dto.getId()%>";
	
	location.href=url;
}
</script>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">정보수정</DIV>
	<DIV class="content">
	<%
		if(flag){
			out.print("정보수정을 했습니다.");
		}else{
			out.print("정보수정을 실패했습니다.");
		}
	%>
	</DIV>
	<DIV class='bottom'>
		<input type='button' value='정보확인' onclick="read()">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
