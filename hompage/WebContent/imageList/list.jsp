<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>

<jsp:useBean id="dao" class="image.ImageDAO"></jsp:useBean>
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

	List<ImageDTO> list = dao.list(map);

	//전체 레코드 갯수 가져오기
	int totalRecord = dao.total(map);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
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
	function read(num) {
		var url = "./read.jsp";
		url += "?num=" + num;       /*  얘는 스크립트변수 */
		url += "&col=<%=col%>";         /* jsp변수는 이렇게 넣는다 */
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";

		location.href = url;
	}
</script>
<style type="text/css">
.thumnail-wrapper{
	position: relative;
	padding-top: 80%;
	overflow:hidden;
}
.thumnail-wrapper .centered{
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	-webkit-transform: translate(50%, 50%);
	-ms-transform: translate(50%, 50%);
	transform: translate(50%, 50%);
}
.thumnail-wrapper .centered .img_thum{
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	/* max-width: 100%; */
	height:auto;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}
.img_thum.portrait{
	width: 100%;
	height: auto;
}
.img_thum.landscape{
	width: auto%;
	height: 100%;
}
</style>
</head>

<body class="w3-light-grey w3-content" style="max-width:1600px">
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="width: 90%; margin:auto;">
  
  <header id="portfolio">
    <div class="w3-container">
    	<h1 style="text-align: center;"><b>치료후기 게시판</b></h1>
    </div>
    <!-- 검색 -->
    <div style="text-align: center;" class="w3-section w3-bottombar w3-padding-16">
		<form method="POST" action="./list.jsp">
			<select name="col">
				<!-- 검색할 컬럼 -->
				<option value="mname"
					<%if (col.equals("mname")) out.print("selected='selected'");%>>이름</option>
				<option value="title"
					<%if (col.equals("title")) out.print("selected='selected'");%>>제목</option>
				<option value="content"
					<%if (col.equals("content")) out.print("selected='selected'");%>>내용</option>
				<option value="total">전체출력</option>
			</select> <input type="text" name="word" value="<%=word%>">
			<!-- 검색어 -->
			<input type="submit" value="검색"> <input type='button' value='후기 올리기' onclick="bcreate()">
		</form>
	</div>	
  </header>
  
  <!-- First Photo Grid-->
	    <%
			if (list.size() == 0) {
		%>
			!검색 결과가 없습니다!
		<%
			} else {
				int record_cnt = 0;
				for (int i = 0; i < list.size(); i++) {
					ImageDTO dto = list.get(i);

					if(record_cnt > 3){
						if(record_cnt == 4){
	    					out.print("</div>");
							out.println("<div class='w3-row-padding' style='width:100%;'>");
	    					
	    				}					
						record_cnt++;
		%>				    
	    				<div class="w3-quarter w3-container w3-margin-bottom" >    				
	    <%			}else{ 
	    				if(record_cnt == 0){
	    					out.println("<div class='w3-row-padding' style='width:100%;'>");
	    				}
	    				record_cnt++;
	    %>		
	    				<div class="w3-quarter w3-container w3-margin-bottom" >
	    <%			} %>
	   			<div class="thumnail-wrapper">	
	   			<div class="centered">
				<a href="<%=request.getContextPath()%>/download?dir=/imageList/storage&filename=<%=dto.getFname()%>">
					<img class="img_thum w3-hover-opacity" src="<%=root %>/imageList/storage/<%=dto.getFname()%>" alt="<%=dto.getFname()%>" class="w3-hover-opacity"/>
				</a>
				</div>	
				</div>
		    <div class="w3-container w3-white">
		    	<span><%=dto.getNum()%></span>
		    	<h4>
		    		<a href="javascript:read('<%=dto.getNum()%>')"><%=dto.getTitle()%></a>
		 		<%
		 			if(Utility.compareDay(dto.getWdate())){ %> <!-- Utility에서 새로 만든 메소드 호출하는데 매개변수는 글 작성날짜이다 -->
		 				<img src="../images/new.gif">
		 		<%	
		 			}
		 		%>
		 		</h4>
		 		<p><%=dto.getWdate()%></p>
				<span>조회 <%=dto.getViewcnt()%>회</span>			
		 		<span>작성자: <a href="#"><%=dto.getMname()%></a></span>
			</div>
		</div>       	
	    	<%	
	 				}%>
	 				</div>	
	 				<%
				}
	 		%>
	

<%-- 	<div class="container">
	<TABLE class="table table-hover">
		<thead>
		<TR>
			<TH>번호</TH>
			<Th>제목</Th>
			<Th>등록날짜</Th>
			<Th>이름</Th>
			<Th>이미지</Th>
			<Th>조회수</Th>
		</TR>
		</thead>
		<tbody>
		<%
			if (list.size() == 0) {
		%>
		<tr>
			<td colspan="8">!등록된 글이 없습니다!</td>
		</tr>

		<%
			} else {
				for (int i = 0; i < list.size(); i++) {
					ImageDTO dto = list.get(i);
		%>
		<TR>
			<Td><%=dto.getNum()%></Td>
			<Td>
 			<a href="javascript:read('<%=dto.getNum()%>')"><%=dto.getTitle()%></a>
 			<%
 				if(Utility.compareDay(dto.getWdate())){ %> <!-- Utility에서 새로 만든 메소드 호출하는데 매개변수는 글 작성날짜이다 -->
 					<img src="../image/new.gif">
 			<%	
 				}
 			%>
 			</Td>
 			<Td><%=dto.getWdate()%></Td>
 			<Td><a href="#"><%=dto.getMname()%></a></Td> <!-- 일반계정용 사용자정보...? -->
			<Td><a href="<%=request.getContextPath()%>/download?dir=/imageList/storage&filename=<%=dto.getFname()%>">
				<img src="<%=root %>/imageList/storage/<%=dto.getFname()%>" width="150px" height="130px"/></a>
			</Td>
			<Td><%=dto.getViewcnt()%></Td>
			<%	
 				}
			}
 			%>
		</TR>
		</tbody>
	</TABLE>
	</div> --%>

	<DIV class='bottom'>
		<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word)%>
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" ></jsp:include>
	
	</div>
</body>
</html>
