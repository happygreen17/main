<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id"); //관리자의 list 페이지에서 온 거임
	String grade = null;
	if(id != null){ 
		id = (String)session.getAttribute("id"); //일반 사용자 세션으로 메뉴를 통해서 들어온거임!!!!~!~!
		grade = (String) session.getAttribute("grade");
	}
	MemberDTO dto = dao.read(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function updateFile(){
	var url = "./updateFileForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getFname()%>";
	
	location.href=url;
}
function mlist(){
	var url = "./list.jsp";
	
	location.href=url;
}
function updatePw(){
	var url="./updatePasswdForm.jsp";
	url += "?id=<%=id%>";
	
	wr = window.open(url, "패스워드 변경", "width=500,height=600"); /*  window.open : 새창  wr는 새창을 말한다.*/
	wr.moveTo((window.screen.width-500)/2, (window.screen.height-600)/2);              /* x좌표와 y좌표를 나타낸다 */
}
function mupdate(){
	var url = "./updateForm.jsp";
	url += "?id=<%=id%>";
	location.href=url;
}
function mdelete(){
	var url = "./deleteForm.jsp";
	url += "?id=<%=id%>";
	location.href=url;
}
</script>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title"><%=dto.getMname()%>의 회원정보</DIV>

	<TABLE>
		<TR>
			<TD colspan="2">
				<img src = "./storage/<%=dto.getFname()%>">
			</TD>
		</TR>
		<TR>
			<TH>아이디</TH>
			<TD>
				<%=dto.getId() %>
			</TD>
		</TR>
		<TR>
			<TH>성명</TH>
			<TD>
				<%=dto.getMname() %>
			</TD>
		</TR>
		<TR>
			<TH>전화번호</TH>
			<TD>
				<%=Utility.checkNull(dto.getTel()) %>
			</TD>
		</TR>
		<TR>
			<TH>이메일</TH>
			<TD>
				<%=dto.getEmail() %>
			</TD>
		</TR>
		<TR>
			<TH>우편번호</TH>
			<TD>
				<%=Utility.checkNull(dto.getZipcode()) %>
			</TD>
		</TR>
		<TR>
			<TH>주소</TH>
			<TD>
				<%=Utility.checkNull(dto.getAddress1()) %>
				<%=Utility.checkNull(dto.getAddress2()) %>
			</TD>
		</TR>
		<TR>
			<TH>직업</TH>
			<TD>
				직업코드: <%=dto.getJob() %>
				(  <%=Utility.getCodeValue(dto.getJob()) %>  )         <!-- 새  getCodeValue를 생성해 줄 것이다. -->
				
			</TD>
		</TR>
		<TR>
			<TH>가입날짜</TH>
			<TD>
				<%=dto.getMdate() %>
			</TD>
		</TR>
	</TABLE>

	<DIV class='bottom'>
		<input type='button' value='회원탈퇴' onclick="mdelete()">
		<input type='button' value='정보수정' onclick="mupdate()">
		<input type='button' value='사진수정' onclick="updateFile()">
		<input type='button' value='pw변경' onclick="updatePw()">
		<%if(id!=null && grade.equals("A")){ //로그인 되어있는데 관리자라면 %>
		<input type='button' value='리스트로 이동' onclick="mlist()">
		<%} %>
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body> 
<!-- *********************************************** -->
</html>
