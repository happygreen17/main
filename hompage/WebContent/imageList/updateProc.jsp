<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="image.ImageDAO" />
<jsp:useBean id="dto" class="image.ImageDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir2);
	dto.setMname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	
	dto.setNum(Integer.parseInt(upload.getParameter("num")));
	String nowPage = upload.getParameter("nowPage"); 
	String col = upload.getParameter("col"); 
	String word = UploadSave.encode(upload.getParameter("word")); 
	String oldfile = UploadSave.encode(upload.getParameter("oldfile")); 
	int oldfile_size = Integer.parseInt(upload.getParameter("oldfile_size")); 
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String filename = oldfile;
			
	if(size>0){
		if(oldfile != null && !oldfile.equals("defalut.jpg"))      /* null이거나 기본사진이면 삭제하지 말아라*/{
			UploadSave.deleteFile(upDir2, oldfile);           /* (folder, fileName)형식 */
		}
			filename = UploadSave.saveFile(fileItem, upDir2);
	}

	dto.setFname(filename);
	dto.setFilesize(oldfile_size);
	
	boolean flag = false;
	flag = dao.update(dto);
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
		url += "?col=<%=col%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		
		location.href = url;
	}
</script>
</head>

<!-- *********************************************** -->
<body>
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
