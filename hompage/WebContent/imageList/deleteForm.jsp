<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="image.ImageDAO"></jsp:useBean>
<%
	int num = Integer.parseInt(request.getParameter("num"));
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
	function blist() {
		var url = "list.jsp";
		url += "?col=<%=request.getParameter("col")%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";
		location.href = url;
	}
</script>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	
	<FORM name='frm' method='POST' action='./deleteProc.jsp'>
		<input type="hidden" name="num" value="<%=num%>"> 
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>"> 
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">	
		<input type="hidden" name="oldfile" value="<%= request.getParameter("oldfile") %>">
		<TABLE>
			<TR>
				<TH>패스워드</TH>
				<TD><input type="password" name="passwd"
					placeholder="비번을 입력하세요" required></TD>
				<!-- required 를 쓰면 크롬에서 자동으로 입력하라고 뜬다 -->
			</TR>
		</TABLE>

		<DIV class='bottom'>
			<input type='submit' value='삭제'> <input type='button'
				value='목록가기' onclick="blist()">
		</DIV>
	</FORM>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
