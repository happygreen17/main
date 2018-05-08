<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<jsp:useBean id="dto" class="bbs.BbsDTO"></jsp:useBean>
<%     
    int bbsno = Integer.parseInt(request.getParameter("bbsno"));     
    dto = dao.read(bbsno);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>등록</title> 
<script type="text/javascript">
/* 입력안한값을 검증하는 함수 */
function incheck(){     /*  매개변수로 전달하지 않았을 때 f 사용법 */
	var f = document.frm;
	
	if(f.title.value==""){   
		/* value값이 없다면 // 자바스크립트에서는태그를 객체로 인식한다!!. 하위요소는 .으로 접근이 가능하다.*/
		alert("제목 입력은 필수입니다");
		f.title.focus();  /* 포커싱 해준다 */
		
		return; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
	}
	
	if(f.content.value==""){   
		alert("내용 입력은 필수입니다");
		f.content.focus();  
		
		return; 
	}
	
	f.submit(); /*  submit이 없으므로 다시 써 준다(button 이었으므로) */
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body class="w3-light-grey w3-content" style="max-width:1600px;">
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<FORM name='frm' method='POST' action='./updateProc.jsp'
		onsubmit="return incheck(this)"
		enctype="multipart/form-data"
		>
		<!-- onsubmit: 제출 시~라는 뜻 (이때는 이미 요청이 되어서 응답이 온다-> return 이용해서 응답을 막는다) -->
  <!-- 자바스크립트에서의 this는 내 위치의 태그의 해시코드를 나타낸다 -->
  <input type="hidden" name="bbsno" value="<%= dto.getBbsno() %>">
  <input type="hidden" name="col" value="<%= request.getParameter("col") %>">
  <input type="hidden" name="word" value="<%= request.getParameter("word") %>">
  <input type="hidden" name="nowPage" value="<%= request.getParameter("nowPage") %>">
  <input type="hidden" name="oldfile" value="<%= dto.getFilename() %>">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname" value="<%= dto.getWname()%>" readonly></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%= dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"><%= dto.getContent()%></textarea></TD>
    </TR>
    <TR>
      <TH>파일명</TH>
      <TD><input type="file" name="filename">(<%=Utility.checkNull(dto.getFilename()) %>)</TD>
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