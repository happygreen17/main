<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"></jsp:useBean>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String oldfile = request.getParameter("oldfile");
	String passwd = request.getParameter("passwd");
	
	boolean flag = false;

	flag = dao.delete(num);
	
	if(flag){
		if(oldfile != null && !oldfile.equals("default.jpg"))
			UploadSave.deleteFile(upDir2, oldfile);         //서버의 사진도 지운다.
	} 	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
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
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<div class="content">
	<%
		if(flag){
			out.print("글을 삭제했습니다");
		}else{
			out.print("삭제 도중 오류가 생겼습니다 -- 삭제실패");
		}
	%>
	</div>

	<DIV class='bottom'>
		<input type='button' value='목록' onclick="blist()">
	</DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 