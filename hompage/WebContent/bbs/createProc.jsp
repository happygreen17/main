<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<jsp:useBean id="dto" class="bbs.BbsDTO" />
<%-- <jsp:setProperty name="dto" property="*" /> --%> <!-- from의 타입이 달라서 못받음 -->
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir3);
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setId(UploadSave.encode(upload.getParameter("id")));

	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
			
	if(size>0){
			filename = UploadSave.saveFile(fileItem, upDir3);
	}
	dto.setFilename(filename);
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
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body class="w3-light-grey w3-content" style="max-width:1600px;">
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
</html>
