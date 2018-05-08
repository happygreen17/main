<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
 <jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
//검색부분-------------------------------------------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word = "";
	}  
	
//페이징부분-------------------------------------------------------------
	int nowPage = 1;
	int recordPerPage = 5;
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);	
	
	List<MemberDTO> list = dao.list(map);
	
	int totalRecord = dao.total(map); 
	
	//페이징 출력메소드 호출
	String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function read(id){
	var url = "<%=root%>/member/read.jsp";
	url += "?id="+id;
	
	location.href=url;
}

</script>
<style type="text/css">
.search{
	width: 80%;
	text-align: center;
	margin: auto;
}
</style>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	
	<div class="search">
		<form method="post" action="./list.jsp">
			<select name="col">
				<option value="mname"
				<%if(col.equals("mname")) out.print("selected"); %>
				>성명</option>
				<option value="id"
				<%if(col.equals("id")) out.print("selected"); %>
				>ID</option>
				<option value="email"
				<%if(col.equals("email")) out.print("selected"); %>
				>E-mail</option>
				<option value="total"
				<%if(col.equals("total")) out.print("selected"); %>
				>전체출력</option>
			</select>
			<input type="search" name="word" value="<%= word %>">
			<button>검색</button>
			<button type="button" onclick= "location.href='<%=root%>/member/createForm.jsp'">회원가입</button>
			<br>
			<br>
		</form>
		
	<div class="container-fluid">
	<!-- <DIV class="title">회원목록</DIV> -->
	<h3><span class="glyphicon glyphicon-th-list"></span>회원목록</h3>
	
	</div>
	<%for(int i= 0; i < list.size(); i++){ 
		
		MemberDTO dto = list.get(i);
		
	
	%>
	<table class="table table-hover">
		<tr>
			<td rowspan="5" width="25%"><img src="<%=root%>/member/storage/<%= dto.getFname()%>" width="200px"/></td>
			<th width="15%">아이디</th>
			<td width="60%"><a href="javascript:read('<%=dto.getId()%>')"><%=dto.getId()%></a></td>
		</tr>
		<tr>
			<th>성명</th>
			<td><%=dto.getMname() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%= Utility.checkNull(dto.getTel()) %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=dto.getEmail() %></td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<%= Utility.checkNull(dto.getAddress1()) %>
				<%= Utility.checkNull(dto.getAddress2()) %>     <!-- null값 대비, null이면 안나오게 만든다. -->
			</td>
		</tr>
	</table>
	<%} %>
	
	<div class='bottom'>
		<%=paging %>
	</div>
	
	</div>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
