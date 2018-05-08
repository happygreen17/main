<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO" />
<jsp:useBean id="dto" class="member.MemberDTO" />
<!-- setProperty 못쓴다... -->
<%
	UploadSave upload = (UploadSave) request.getAttribute("upload");

	dto.setId(UploadSave.encode(upload.getParameter("id")));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address2")));
	/* job은 value값이 0, A01 같으거라 한글 인코딩 안해도됨 */
	dto.setZipcode(upload.getParameter("zipcode"));
	dto.setPasswd(upload.getParameter("passwd"));
	dto.setJob(upload.getParameter("job"));
	dto.setEmail(upload.getParameter("email"));
	dto.setTel(upload.getParameter("tel"));

	FileItem fileItem = upload.getFileItem("fname");
	String fname = "member.jpg";
	int size = (int) fileItem.getSize();

	if (size > 0) {
		fname = UploadSave.saveFile(fileItem, upDir);
	}

	dto.setFname(fname);
	boolean flag = dao.create(dto);
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
<script type="text/javascript">
function login(){
	var url = "./loginForm.jsp";
	location.href=url;
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">회원가입 처리</DIV>
	
	<div class="content">
	<%
		if(flag){
			out.print("회원가입을 했습니다.");
			out.print(" <br><button type='button' onclick='location.href='./list.jsp''>로그인폼</button> ");
		}else{
			out.print("회원가입을 실패했습니다.");
		}
	%>
	</div>

	<DIV class='bottom'>
		<input type='button' value='홈' onclick="location.href='./list.jsp'">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
