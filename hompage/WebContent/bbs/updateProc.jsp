<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<jsp:useBean id="dto" class="bbs.BbsDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir3);
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	String nowPage = upload.getParameter("nowPage"); 
	String col = upload.getParameter("col"); 
	String word = UploadSave.encode(upload.getParameter("word")); 
	String oldfile = UploadSave.encode(upload.getParameter("oldfile")); 
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
			
	if(size>0){
		UploadSave.deleteFile(upDir3, oldfile);	
		filename = UploadSave.saveFile(fileItem, upDir3);
	}
	dto.setFilename(filename);
	dto.setFilesize(size);
	
	boolean flag = dao.update(dto);
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
		url += "?col=<%=col%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		
		location.href = url;
	}
</script>
</head>

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<div class="content">
		<%
			if (flag) {
				out.print("글 수정을 -성공-했습니다.");
			} else {
				out.print("글 수정을 -실패-했습니다.");
			}
		%>
	</div>

	<DIV class='bottom'>
		<input type='button' value='목록' onclick="blist()">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
