<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String oldpasswd = request.getParameter("oldpasswd");
	
	String newpasswd1 = request.getParameter("newpasswd1");
	
	/* MemberDTO dto = dao.readPw(id); */
	
	boolean okflag = false; //기존비밀번호와 일치하는지
	
	boolean flag = false;   //변경성공
	
	if(oldpasswd.equals(dao.readPw(id))){
		okflag = true;
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("newpasswd", newpasswd1);
		
		flag = dao.updatePw(map);
	}else{
		okflag = false;
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
<script>
function mlist(){
	var url = "./list.jsp";
	
	opener.location.href=url;
	self.close();
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<div class="content">
<%
if(!okflag){
	out.println("비밀번호가 일치하지 않습니다");
%>
	<input type='button' value='다시 변경하기' onclick="history.back()">
<%
}else if(flag){
	out.println("변경성공!");
}else{
	out.println("비밀번호 변경 실패");
}

%>
</div>
  
  <DIV class='bottom'>
    <input type='button' value='목록으로' onclick="mlist()">
  </DIV>

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 