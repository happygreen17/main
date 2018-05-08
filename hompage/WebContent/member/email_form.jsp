<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
 
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
</head> 
<!-- *********************************************** -->
<body>
 
<DIV class="title">Email 중복확인</DIV>
 
<div class="content">
Email을 입력하세요<br><br>
</div>
<FORM name='frm' method='POST' 
		action='./email_proc.jsp'
		>
  <TABLE>
    <TR>
      <TH>이메일</TH>
      <TD><input type="text" name="email" size="20" required></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='중복확인'>
    <input type='button' value='취소' onclick="window.close()">  
    <!-- window.close() 현재 열린 창이 닫히게(새창에서 주로 많이 쓴다.) -->
  </DIV>
</FORM>
 
</body>
<!-- *********************************************** -->
</html> 