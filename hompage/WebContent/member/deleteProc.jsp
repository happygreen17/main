<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String fname = request.getParameter("fname");
	
	boolean flag = dao.delete(id);
	
	if(flag){
		if(fname != null && !fname.equals("member.jpg"))
			UploadSave.deleteFile(upDir, fname);         //서버의 사진도 지운다.
			
		session.invalidate();               //세션의 정보도 지워지고 로그아웃된다.
	} 
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">탈퇴 확인</DIV>

<DIV class="content">
<%
	if(flag){
		out.print("탈퇴되었습니다. 자동 로그아웃됩니다.");
	}else{
		out.print("탈퇴에 실패하였습니다..");
	}
%>
</DIV>

<DIV class='bottom'>
  <input type='button' value='홈' onclick="location.href='../index.jsp'">
  <input type='button' value='다시시도' onclick="history.back()">
</DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 