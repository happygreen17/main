<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="image.ImageDAO" />
<jsp:useBean id="dto" class="image.ImageDTO" />
<%-- <jsp:setProperty name="dto" property="*" /> --%> <!-- from의 타입이 달라서 못받음 -->
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir2);
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setId(UploadSave.encode(upload.getParameter("id")));

	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String filename = "default.jpg";
			
	if(size>0){
			filename = UploadSave.saveFile(fileItem, upDir2);
	}
	dto.setFname(filename);
	dto.setFilesize(size);

	boolean flag = dao.create(dto);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	function blist(){
		var url = "./list.jsp";
		location.href= url;
	}
</script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="content">
		<%
			if (flag) {
				out.print("글 등록 성공~!");
			} else {
				out.print("글 등록 실패-");
			}
		%>
	</DIV>

	<DIV class='bottom'>
		<input type='button' value='목록' onclick='blist()'>
	</DIV>


	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
