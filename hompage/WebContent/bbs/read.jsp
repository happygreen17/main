<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	/* 얘는 형변환은 아니고 그냥 이 메소드의 값이 스트링형이어야 하기 때문이다. */
	String id = (String) session.getAttribute("id");
	String b_id = dao.readId(bbsno);

	dao.upViewcnt(bbsno); //조회수 증가
	BbsDTO dto = dao.read(bbsno);

	String content = dto.getContent();
	content = content.replaceAll("\r\n", "<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function fileDown(filename){
	var url = "<%=root%>/download";
	url += "?filename="+filename;
	url += "&dir=/bbs/storage";
	
	location.href = url;
}

	function blist(){
		var url = "./list.jsp";
		url += "?col=<%=request.getParameter("col")%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";
		
		location.href= url;
	}
	function bupdate(bbsno){
		var url = "";
		if("<%=id%>" == "null") { /* 이것이 실행될 리는 없다(버튼이 보이지 않기 때문에) 그렇지만 혹시몰라서 써둠ㅇㅇ */
			var flag = confirm("로그인 한 회원만 글 작성이 가능합니다. 로그인창으로 이동하시겠습니까?");
			if(flag == true) {
				url = "../member/loginForm.jsp";
				
				location.href = url;
			}
		}else if("<%=b_id%>" != "<%=id%>"){  /* 이것이 실행될 리는 없다(버튼이 보이지 않기 때문에) 그렇지만 혹시몰라서 써둠ㅇㅇ */
			alert("글수정은 본인만 가능합니다.");
		}else{
			url ="./updateForm.jsp";
			url += "?bbsno=" + bbsno;
			url += "&col=<%=request.getParameter("col")%>";         /* jsp변수는 이렇게 넣는다 */
			url += "&word=<%=request.getParameter("word")%>";
			url += "&nowPage=<%=request.getParameter("nowPage")%>";
			
			location.href= url;
		}			
	}
	function bdel(){	
		var url = "";
		if("<%=id%>" == "null") { /* 이것이 실행될 리는 없다(버튼이 보이지 않기 때문에) 그렇지만 혹시몰라서 써둠ㅇㅇ */
			var flag = confirm("로그인 한 회원만 글 삭제가 가능합니다. 로그인창으로 이동하시겠습니까?");
			if(flag == true) {
				url = "../member/loginForm.jsp";
				
				location.href = url;
			}
		}else if("<%=b_id%>" != "<%=id%>"){  /* 이것이 실행될 리는 없다(버튼이 보이지 않기 때문에) 그렇지만 혹시몰라서 써둠ㅇㅇ */
			alert("글삭제는 본인만 가능합니다.");
		}else{
			if(confirm("정말로 삭제하시겠습니까?")){		
				var url = "./deleteProc.jsp";
				url += "?bbsno=<%=bbsno%>";
				url += "&oldfile=<%=dto.getFilename()%>";
				url += "&col=<%=request.getParameter("col")%>";         /* jsp변수는 이렇게 넣는다 */
				url += "&word=<%=request.getParameter("word")%>";
				url += "&nowPage=<%=request.getParameter("nowPage")%>";
			
				location.href = url;
			}
		}
	}
	function reply(bbsno){
		var url = "";
		if("<%=id%>" == "null") { 
			var flag = confirm("로그인 한 회원만 답글 작성이 가능합니다. 로그인창으로 이동하시겠습니까?");
			if(flag == true) {
				url = "../member/loginForm.jsp";
				
				location.href = url;
			}
		}else{
			url = "./replyForm.jsp";
			url += "?bbsno="+ bbsno;
			url += "&col=<%=request.getParameter("col")%>";         /* jsp변수는 이렇게 넣는다 */
			url += "&word=<%=request.getParameter("word")%>";
			url += "&nowPage=<%=request.getParameter("nowPage")%>";
		
			location.href=url;
		}
	}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<TABLE>
		<TR>
			<TH width="10%">성명</TH>
			<TD width="90%"><%=dto.getWname()%></TD>
		</TR>
		<TR>
			<TH>제목</TH>
			<TD><%=dto.getTitle()%></TD>
		</TR>
		<TR>
			<TH>내용</TH>
			<TD style="height: 100px;"><%=content%></TD>
		</TR>
		<TR>
			<TH>조회수</TH>
			<TD><%=dto.getViewcnt()%></TD>
		</TR>
		<TR>
			<TH>등록날짜</TH>
			<TD><%=dto.getWdate()%></TD>
		</TR>
		<TR>
			<TH>첨부파일</TH>
			<Td>
				<%
					if (dto.getFilename() == null) {
						out.print("(파일없음)");
					} else {
						String ext = dto.getFilename();
						ext = ext.toLowerCase();
						if(!(ext.lastIndexOf(".jpg")>0 || ext.lastIndexOf(".jpeg")>0 || ext.lastIndexOf(".png")>0 || ext.lastIndexOf(".gif")>0)){
				%>		
						<a href="javascript:fileDown('<%=dto.getFilename()%>')"> 
						<%=dto.getFilename()%>(<%=dto.getFilesize()%>)</a> 
				<%
						}
 					}
 				%>
			</Td>
		</TR>
		<TR>
			<TH>이미지</TH>
			<Td>
				<%
					if (dto.getFilename() == null || dto.getFilename().equals("default.jpg")) {
						out.print("(이미지 없음)");
					} else {
						String ext = dto.getFilename();
						ext = ext.toLowerCase();
						if(ext.lastIndexOf(".jpg")>0 || ext.lastIndexOf(".jpeg")>0 || ext.lastIndexOf(".png")>0 || ext.lastIndexOf(".gif")>0){
				%>
							<img src="./storage/<%=dto.getFilename()%>" width="200px">
				<%
						}
 					}
 				%>
			</Td>
		</TR>
	</TABLE>

	<DIV class='bottom'>
		<button type="button" onclick="reply('<%=dto.getBbsno()%>')">답글</button>
		<!-- 부모의 번호를 알아야 한다 -->
		<%if((id != null) && id.equals(b_id)){ //로그인 정보(id)가 글과 일치하면 버튼이 보이게%>
		<button type="button" onclick="bdel()">삭제</button>
		<input type='button' value='수정' onclick="bupdate('<%=dto.getBbsno()%>')"> 
		<%} %>
		<input type='button' value='목록' onclick="blist()">
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
</html>
