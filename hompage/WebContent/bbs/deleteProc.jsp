<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String oldfile = request.getParameter("oldfile");
	
	boolean ref_flag = dao.checkRefnum(bbsno);

	boolean flag = false;

	if(ref_flag == false){
		flag = dao.delete(bbsno);
	}
	
	if(flag){
		UploadSave.deleteFile(upDir3, oldfile);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<%
		if (ref_flag) {
	%>
		<div class="content">부모글이므로 삭제할 수 없습니다</div>
		<DIV class='bottom'>
			<input type='button' value='뒤로가기' onclick="history.back()"> 
			<input type='button' value='목록가기' onclick="blist()">
		</DIV>
	<%
		} else {
	%>

		<div class="content">
		<%
			if(flag){
				out.print("글을 삭제했습니다");
				response.sendRedirect("./list.jsp");
			}else{
				out.print("삭제 도중 오류가 생겼습니다 -- 삭제실패");
			}
		
		%>
		</div>
	<%} %>

	<DIV class='bottom'>
		<input type='button' value='목록' onclick="blist()">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
</html>
