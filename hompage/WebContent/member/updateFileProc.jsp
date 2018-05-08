<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	String id = upload.getParameter("id");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));

	FileItem fileItem = upload.getFileItem("fname");
	
	int size = (int)fileItem.getSize();
	String fname = "member.jpg";

	if(size > 0){
		if(oldfile != null && !oldfile.equals("member.jpg"))      /* null이거나 기본사진이면 삭제하지 말아라??????????*/{
			UploadSave.deleteFile(upDir, oldfile);           /* (folder, fileName)형식 */
		}
		fname = UploadSave.saveFile(fileItem, upDir);
	}

	Map<String, String> map = new HashMap<String, String>();
	map.put("id", id);
	map.put("fname", fname);
	
	boolean flag = dao.updateFile(map);
%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function read(){
	var url = "./read.jsp";
	url += "?id=<%=id%>";
	
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">사진변경</DIV>
 
<div class="content">
<%
	if(flag){
		out.print("사진을 변경했습니다.");
		response.sendRedirect("./list.jsp");
	}else{
		out.print("사진변경을 실패했스빈다.");
	}

%>
</div>
  
  <DIV class='bottom'>
    <input type='button' value='나의 정보' onclick="read()">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 