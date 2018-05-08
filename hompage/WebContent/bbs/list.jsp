<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>

<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	String id = (String) session.getAttribute("id");

	//검색관련------------------------------------------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

	if (col.equals("total")) {
		word = "";
	}

	//페이징 관련------------------------------------------------------------
	int nowPage = 1; //현재 보고 있는 페이지
	if (request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	//페이지번호를 받아온다

	int recordPerPage = 8; //한 페이지에 보여줄 레코드 갯수이다.
	//변경될 수 있으므로 Constant에다가 static으로 넣어주는 것이 좋다. ~!~!~!

	int sno = ((nowPage - 1) * recordPerPage) + 1; //현재 페이지에서 보여지는 페이지 시작번호
	int eno = nowPage * recordPerPage; //현재 페이지에서 보여지는 페이지 끝번호

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	List<BbsDTO> list = dao.list(map);

	//전체 레코드 갯수 가져오기
	int totalRecord = dao.total(map);
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

	function bcreate() {
		var url = "";
		if("<%=id%>" == "null") {
			var flag = confirm("로그인 한 회원만 글 작성이 가능합니다. 로그인창으로 이동하시겠습니까?");
			if(flag == true) {
				url = "../member/loginForm.jsp";
				
				location.href = url;
			}
		}else{
			url = "./createForm.jsp";
			url += "?id=<%=id%>";
			location.href = url;
		}	
	}
	function read(bbsno) {
		var url = "./read.jsp";
		url += "?bbsno=" + bbsno;       /*  얘는 스크립트변수 */
		url += "&col=<%=col%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";

		location.href = url;
	}
</script>
</head>

<body class="w3-light-grey w3-content" style="max-width:1600px;">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	
<!-- !PAGE CONTENT! -->
<div class="w3-main" style="width: 90%; margin:auto; min-height: 500px">
	<header id="portfolio">
    <div class="w3-container">
    	<h1 style="text-align: center;"><b>질문&답변 게시판</b></h1>
    </div>
    <!-- 검색 -->
	<div style="text-align: center;" class="w3-section w3-bottombar w3-padding-16">
		<form method="POST" action="./list.jsp">
			<select name="col">
				<!-- 검색할 컬럼 -->
				<option value="wname"
					<%if (col.equals("wname"))
				out.print("selected='selected'");%>>성명</option>
				<option value="title"
					<%if (col.equals("title"))
				out.print("selected='selected'");%>>제목</option>
				<option value="content"
					<%if (col.equals("content"))
				out.print("selected='selected'");%>>내용</option>
				<option value="total">전체출력</option>
			</select> <input type="text" name="word" value="<%=word%>">
			<!-- 검색어 -->
			<input type="submit" value="검색"> 
			<input type='button' value='글쓰기' onclick="bcreate()">
		</form>
	</div>
	</header>
	
	<div class="container-fluid">
	<h4><span class="glyphicon glyphicon-th-list"></span>게시판 목록</h4>
	
	<table class="table table-hover">
	<thead>
		<TR>
			<TH>번호</TH>			
			<Th>제목</Th>
			<Th>글쓴이</Th>
			<Th>등록날짜</Th>
			<Th>조회</Th>
		</TR>
		</thead>
		<%
			if (list.size() == 0) {
		%>
		<tbody>
		<tr>
			<td colspan="6">검색 결과가 없습니다</td>
		</tr>
		</tbody>
		<%
			} else {
				for (int i = 0; i < list.size(); i++) {
					BbsDTO dto = list.get(i);
		%>
		<tbody>
		<TR>
			<Td><%=dto.getBbsno()%></Td>
			<Td>
			<%
			if (dto.getIndent() > 0) { /* 답변 */
			%> 
			<%
 				for (int r = 0; r < dto.getIndent(); r++) { //들여쓰기값만큼 들여주는 것을 출력
 					out.println("&nbsp; &nbsp");
 				}
 			%> <img src="../images/ans.jpg" width="30px" /> 
 			<%
 			}
 			%> <a href="javascript:read('<%=dto.getBbsno()%>')"><%=dto.getTitle()%></a>
 			<%
 				if(Utility.compareDay(dto.getWdate())){ %> <!-- Utility에서 새로 만든 메소드 호출하는데 매개변수는 글 작성날짜이다 -->
 					<img src="../images/new.gif">
 			<%	
 				}
 			%>			
			</Td>
			<Td><a href="read()"><%=dto.getWname()%></a></Td>
			<Td><%=dto.getWdate()%></Td>
			<Td><%=dto.getViewcnt()%></Td>	
		</TR>
		</tbody>
		<%
			}
			}
		%>
	</TABLE>

	<DIV class='bottom'>
		<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word)%>
	</DIV>
	</div>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</div>
	
</body>
</html>