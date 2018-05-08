<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"></jsp:useBean>
<jsp:useBean id="dto" class="image.ImageDTO"></jsp:useBean>
<%     
    int num = Integer.parseInt(request.getParameter("num"));     
    dto = dao.read(num);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>등록</title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
/* 입력안한값을 검증하는 함수 */
function incheck(){     /*  매개변수로 전달하지 않았을 때 f 사용법 */
	var f = document.frm;

	if(f.mname.value==""){   
		/* value값이 없다면 // 자바스크립트에서는태그를 객체로 인식한다!!. 하위요소는 .으로 접근이 가능하다.*/
		alert("이름을 입력은 필수입니다");
		f.mname.focus();  /* 포커싱 해준다 */
		
		return; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
	}
	
	if(f.title.value==""){   
		alert("제목 입력은 필수입니다");
		f.title.focus();  
		
		return; 
	}
	
	if(f.content.value==""){   
		alert("내용 입력은 필수입니다");
		f.content.focus();  
		
		return; 
	}
	
	f.submit(); /*  submit이 없으므로 다시 써 준다(button 이었으므로) */
}
</script>

</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<FORM name='frm' method='POST' action='./updateProc.jsp'
		enctype="multipart/form-data"
		>
  <input type="hidden" name="num" value="<%= dto.getNum() %>">
  <input type="hidden" name="col" value="<%= request.getParameter("col") %>">
  <input type="hidden" name="word" value="<%= request.getParameter("word") %>">
  <input type="hidden" name="nowPage" value="<%= request.getParameter("nowPage") %>">
  <input type="hidden" name="oldfile" value="<%= dto.getFname() %>">
  <input type="hidden" name="oldfile_size" value="<%= dto.getFilesize() %>">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD colspan= "3"><input type="text" name="mname" value="<%= dto.getMname()%>" readonly></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD colspan= "3"><input type="text" name="title" value="<%= dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD colspan= "3"><textarea rows="10" cols="45" name="content"><%= dto.getContent()%></textarea></TD>
    </TR>
    <TR>
      <TH>원본파일: </TH>
      <TD>
      	<img src="./storage/<%=Utility.checkNull(dto.getFname())%>">
      	원본파일명 : <%=Utility.checkNull(dto.getFname()) %>
      </TD>
      <TH>수정할 파일: (.jpg, .gif, .png만 가능합니다.)</TH>
      <TD><input type="file" name="fname" accept = ".jpg, .gif, .png">(<%=dto.getFilesize() %>)</TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='수정' onclick="incheck()">
    <input type='button' value='취소' onclick="history.back()">
   <!--  캐시를 통해 바로 전 페이지로 이동한다. -->
  </DIV>
</FORM>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 