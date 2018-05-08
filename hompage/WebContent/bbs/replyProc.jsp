<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<jsp:useBean id="dto" class="bbs.BbsDTO"></jsp:useBean>
<%	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir3);
	dto.setId(UploadSave.encode(upload.getParameter("id")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	dto.setIndent(Integer.parseInt(upload.getParameter("indent")));
	dto.setAnsnum(Integer.parseInt(upload.getParameter("ansnum")));
	dto.setGrpno(Integer.parseInt(upload.getParameter("grpno")));
	
	String nowPage = upload.getParameter("nowPage"); 
	String col = upload.getParameter("col"); 
	String word = UploadSave.encode(upload.getParameter("word")); 
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
			
	if(size>0){
			filename = UploadSave.saveFile(fileItem, upDir3);
	}
	dto.setFilename(filename);
	dto.setFilesize(size);

	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());

	//ansnum 증가시키고 답변 추가할 것임 내 밑에있는 넘들의 ansnum을 +1시케겠다
	dao.updateAnsnum(map);
	//답변추가
	boolean flag = dao.createReply(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
	function blist() {
		var url = "./list.jsp";
		url += "?col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";

		location.href = url;
	}
</script>
</head>

<body class="w3-light-grey w3-content" style="max-width: 1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<div class="content">
		<%
			if (flag) {
				out.print("답변이 성공적으로 생성되었습니다~!~!");
				response.sendRedirect("./list.jsp");
			} else {
				out.print("답변 등록 도중 오류가 생겼습니다 -- 등록실패");
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
