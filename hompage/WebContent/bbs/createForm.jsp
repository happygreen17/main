<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
<%  request.setCharacterEncoding("utf-8");
    root = request.getContextPath();
%> 
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	System.out.println(id);
	String wname = dao.readMname(id);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>등록</title> 
<script type="text/javascript">
/* 입력안한값을 검증하는 함수 */
function incheck(f){
	if(f.title.value==""){   
		alert("제목 입력은 필수입니다");
		f.title.focus();  /* 포커싱 해준다 */
		
		return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
	}
	
	if(f.content.value==""){   
		alert("내용 입력은 필수입니다");
		f.content.focus();  /* 포커싱 해준다 */
		
		return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
	}
}
</script>
</head> 

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false"/>
	<!-- *********************************************** -->

	<div class="container">
		<h4><span class="glyphicon glyphicon-pencil">등록</span></h4>
 
<!-- onsubmit: 제출 시~라는 뜻 (이때는 이미 요청이 되어서 응답이 온다-> return 이용해서 응답을 막는다) -->
<!-- 자바스크립트에서의 this는 내 위치의 태그의 해시코드를 나타낸다 -->
	<FORM name='frm' method='POST' action='./createProc.jsp'
		onsubmit="return incheck(this)"
		enctype="multipart/form-data"
		>
		<input type="hidden" name="id" value="<%=id %>"/>		
  		<TABLE class="table table-bordered"> 
   			<TR>
      			<TH>글쓴이</TH>
      			<TD><input type="text" name="wname" value="<%=wname %>" readonly></TD>
    		</TR>
    		<TR>
      			<TH>제목</TH>
      			<TD><input type="text" name="title"></TD>
    		</TR>
    		<TR>
    			<TH>내용</TH>
      			<TD><textarea rows="10" cols="45" name="content"></textarea></TD>
    		</TR>
    		<TR>
      			<TH>파일</TH>
      			<TD><input type="file" name="filename"></TD>
    		</TR>
  		</TABLE>
  
  		<DIV class='bottom'>
    		<input type='submit' value='등록'>
    		<input type='button' value='취소' onclick="history.back()">
   		<!--  캐시를 통해 바로 전 페이지로 이동한다. -->
  		</DIV>
		</FORM>
	</div>
 
	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 