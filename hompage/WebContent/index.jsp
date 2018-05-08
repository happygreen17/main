<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<jsp:useBean id="image_dao" class="image.ImageDAO"></jsp:useBean>
<%
	String id = (String) session.getAttribute("id");
	String grade = (String) session.getAttribute("grade");

	String title = "어서오시게 낯선이여";
	if (id != null && grade.equals("A")) {
		title = "관리자 페이지 입니다.";
	}
	
	String str = null;
	if (id == null) {
		str = "(로그아웃 상태)";
	} else {
		str = "안녕하세요" + id + "님!";
	}	
	
	List<BbsDTO> list = dao.list();
	List<ImageDTO> list2 = image_dao.list();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title><%=title%></title>
<link href="<%=root%>/css/nav.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
	function read(bbsno) {
		var url = "<%=root%>/bbs/read.jsp";
		url += "?bbsno=" + bbsno;       /*  얘는 스크립트변수 */
		url += "&col= ";         /* jsp변수는 이렇게 넣는다 */
		url += "&word= ";
		url += "&nowPage=1";

		location.href = url;
	}
	function image_read(num) {
		var url = "<%=root%>/imageList/read.jsp";
		url += "?num=" + num;       /*  얘는 스크립트변수 */
		url += "&col= ";         /* jsp변수는 이렇게 넣는다 */
		url += "&word= ";
		url += "&nowPage=1";
		
		location.href = url;
	}
</script>
<style type="text/css">
.boxes{
	background-color:#f5f5f5;
	margin-left: 5px;
	margin-right: 5px;
}
</style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	
	<div align="right" style="position:relative; top:-45px; right: 150px;">
		<%=str%>
	</div>

	<div id="myCarousel" class="carousel slide" data-ride="carousel" style="top:-27px;">
		<!-- Indicators -->
		<ol class="carousel-indicators" style="left:100px; top:300px;">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img src="<%=root %>/images/main_theme.jpg" alt="Image">
			</div>
			<div class="item">
				<img src="<%=root %>/images/main_theme2.jpg" alt="Image">
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> 
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> 
			<span class="sr-only">Previous</span>
		</a> 
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> 
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>

	<div class="container text-center">
		<br>
		<div class="row">
			<div class="col-sm-4 boxes">
			<p>질문&답변 게시판</p>
			<br>
			<table class="table table-hover">			
				<%
					if (list.size() == 0) {
				%>
					<tbody>
					<tr>
						<td colspan="6">게시글이 없습니다</td>
					</tr>
					</tbody>
				<%
					} else {
						for (int i = 0; i < list.size(); i++) {
							BbsDTO dto = list.get(i);
				%>
							<tbody>
							<TR>					
						<%
							if (dto.getIndent() == 0) { /* 답변이 아닌 것들만 (질문만 출력) */
						%> 
								<td><%=dto.getBbsno()%></td> <!-- (디버깅용) -->
			 				<td><a href="javascript:read('<%=dto.getBbsno()%>')"><%=dto.getTitle()%></a>
			 			<%
			 				if(Utility.compareDay(dto.getWdate())){ %> <!-- Utility에서 새로 만든 메소드 호출하는데 매개변수는 글 작성날짜이다 -->
			 					<img src="<%=root %>/images/new.gif">
			 			<%	}	%>		
			 				</td>	
							<td>[<%=dto.getViewcnt()%>]</td>	<!-- 조회 수 -->
							</TR>
							</tbody>
						<%
							}
						}
					}
					%>					
				</table>
			</div>
			<div class="col-sm-4 boxes">
			<p>치료후기</p>
			<br>
			<table class="table table-hover">			
				<%
					if (list2.size() == 0) {
				%>
					<tbody>
					<tr>
						<td colspan="6">게시글이 없습니다</td>
					</tr>
					</tbody>
				<%
					} else {
						for (int i = 0; i < list2.size(); i++) {
							ImageDTO dto = list2.get(i);
				%>
							<tbody>
							<TR>					
								<td><%=dto.getNum()%></td> <!-- (디버깅용) -->
			 				<td><a href="javascript:image_read('<%=dto.getNum()%>')"><%=dto.getTitle()%></a>
			 			<%
			 				if(Utility.compareDay(dto.getWdate())){ %> <!-- Utility에서 새로 만든 메소드 호출하는데 매개변수는 글 작성날짜이다 -->
			 					<img src="<%=root %>/images/new.gif">	
			 				</td>	
							</TR>
							</tbody>
						<%
							}
						}
					}
					%>					
				</table>
			</div>
			
			<div class="col-sm-4 col-lg-3">
				<div class="well">
					<p><a href="<%=root %>/my_Info.jsp">개발자 소개</a></p>
				</div>
				<div class="box4 well" style="background-color:#fae100;">
					<p>카카오톡 플러스친구</p>
				</div>
			</div>
		</div>
	</div>
	<br>
	
	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />

</body>
</html>
