<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	String id = request.getParameter("id");
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
/* 입력안한값을 검증하는 함수 */
function incheck(){     /*  매개변수로 전달하지 않았을 때 f 사용법 */
	var f = document.frm;

	if(f.newpasswd1.value==""){   
		alert("새 비밀번호를 입력해 주세요");
		f.newpasswd1.focus(); 
		
		return;
	}
	if(f.newpasswd2.value==""){   
		alert("새 비밀번호 확인을 입력해 주세요");
		f.newpasswd2.focus();  
		
		return; 
	}
	if(f.newpasswd1.value!=f.newpasswd2.value){   
		alert("새 패스워드 값들이 일치하지 않습니다");
		f.newpasswd2.focus();  /* 포커싱 해준다 */
		
		return; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
	}
	
	f.submit();
}
</script>
</head> 
<!-- *********************************************** -->
<body>
 
<DIV class="title">비밀번호 변경</DIV>
<div class="content">
안전한 비밀번호로 내정보를 보호하세요<br><br>

다른 아이디/사이트에서 사용한 적 없는 비밀번호<br><br>

이전에 사용한 적 없는 비밀번호가 안전합니다.<br>
</div>

<FORM name='frm' method='POST' action='./updatePasswdProc.jsp'>
<input type="hidden" name="id" value="<%=id %>">
  <TABLE>
    <TR>
      <TH>현재 비밀번호</TH>
      <TD><input type="password" name="oldpasswd"/></TD>
    </TR>

     <TR>
      <TH>새 비밀번호</TH>
      <TD><input type="password" name="newpasswd1"/></TD>
    </TR>
     <TR>
      <TH>비밀번호 확인</TH>
      <TD><input type="password" name="newpasswd2"/></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='확인' onclick="incheck()">
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
</body>
<!-- *********************************************** -->
</html> 