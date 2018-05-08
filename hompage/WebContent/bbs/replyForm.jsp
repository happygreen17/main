<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsDTO dto = dao.readReply(bbsno);
	//부모의 gropno, indent, ansnum, title 읽어오는 메소드
	
	String id = (String) session.getAttribute("id");
	String wname = dao.readMname(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글 등록</title>

<script type="text/javascript">
	/* 입력안한값을 검증하는 함수 */
	function incheck(f) {
		if (f.wname.value == "") {
			/* value값이 없다면 // 자바스크립트에서는태그를 객체로 인식한다!!. 하위요소는 .으로 접근이 가능하다.*/
			alert("이름을 입력은 필수입니다");
			f.wname.focus(); /* 포커싱 해준다 */

			return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
		}

		if (f.title.value == "") {
			alert("제목 입력은 필수입니다");
			f.title.focus(); /* 포커싱 해준다 */

			return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
		}

		if (f.content.value == "") {
			alert("내용 입력은 필수입니다");
			f.content.focus(); /* 포커싱 해준다 */

			return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
		}

		if (f.passwd.value == "") {
			alert("패스워드 입력은 필수입니다");
			f.passwd.focus(); /* 포커싱 해준다 */

			return false; /* submit 되지 말고 멈춰라 -그러면 폼이 안넘어가고 페이지가 유지된다.*/
		}
	}
</script>

</head>

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<div class="container">
		<h4>
			<span class="glyphicon glyphicon-pencil">답변쓰기</span>
		</h4>

		<FORM name='frm' method='POST' action='./replyProc.jsp'
			onsubmit="return incheck(this)" 
			enctype="multipart/form-data">
			<!-- onsubmit: 제출 시~라는 뜻 (이때는 이미 요청이 되어서 응답이 온다-> return 이용해서 응답을 막는다) -->
			<!-- 자바스크립트에서의 this는 내 위치의 태그의 해시코드를 나타낸다 -->
			<input type="hidden" name="bbsno" value="<%=dto.getBbsno()%>">
			<input type="hidden" name="grpno" value="<%=dto.getGrpno()%>">
			<input type="hidden" name="indent" value="<%=dto.getIndent()%>">
			<input type="hidden" name="ansnum" value="<%=dto.getAnsnum()%>">
			<input type="hidden" name="col" value="<%=request.getParameter("col")%>"> 
			<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
			<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
			<input type="hidden" name="id" value="<%=id%>">
			<TABLE class="table table-bordered">
				<TR>
					<TH>성명</TH>
					<TD><input type="text" name="wname" value="<%=wname %>" readonly></TD>
				</TR>
				<TR>
					<TH>제목</TH>
					<TD><input type="text" name="title"
						value="<%=dto.getTitle()%>"></TD>
				</TR>
				<TR>
					<TH>내용</TH>
					<TD><textarea rows="10" cols="45" name="content"></textarea></TD>
				</TR>
				<TR>
					<TH>파일명</TH>
					<TD><input type="file" name="filename"></TD>
				</TR>
			</TABLE>

			<DIV class='bottom'>
				<input type='submit' value='답변등록'> <input type='button' value='취소' onclick="history.back()">
				<!--  캐시를 통해 바로 전 페이지로 이동한다. -->
			</DIV>
		</FORM>
	</div>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
</html>
