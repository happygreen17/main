<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");       /*  변경할 파일명과 id를 받는다(dao에 어떤 레코드를 변경할지 알아야 하므로) */
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function incheck(){     /*  매개변수로 전달하지 않았을 때 f 사용법 */
	var f = document.frm;

	if(f.fname.value==""){   
		alert("수정할 이미지가 선택되지 않았습니다. 기본 이미지로 변경됩니다.");
		 
		
	}
	
	f.submit();
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">사진 수정</DIV>
 
<FORM name='frm' method='POST' 
		action='./updateFileProc.jsp'
		enctype="multipart/form-data"	
		>
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="oldfile" value="<%=oldfile %>">
  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD>
      	<img src="./storage/<%=oldfile%>">
      	원본파일명 : <%=oldfile %>
      </TD>
      <TH>변경파일</TH>
      <TD>
      	<input type="file" name="fname" accept = ".jpg, .gif, .png">
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='변경' onclick="incheck()">
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 