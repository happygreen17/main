<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<% 
	//로그인시 아이디 가져옴
	String id = (String) session.getAttribute("id");
	
	int num = Integer.parseInt(request.getParameter("num"));

	dao.upViewcnt(num); //조회수 증가

	ImageDTO dto = dao.read(num);
   
	String content = dto.getContent();
   
	content = content.replaceAll("\r\n", "<br>");
   
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}

</style> 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function readGo(num){
	var url = "./read.jsp";
	url = url +"?num="+num;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function blist(){
	var url = "./list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href= url;
}
function bupdate(num){
	<%-- if(<%=id%> == null){
		alert("로그인 후 수정 가능합니다");
		var url = "../member/loginForm.jsp";
		
		location.href= url;
		return;
	} --%>
	
	var url = "./updateForm.jsp";
	url = url +"?num="+num;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href= url;
}
function bdelete(num){
	var flag = confirm("정말로 삭제하시겠습니까?");
	
	<%-- if(<%=id%> == null){
		alert("로그인 후 수정 가능합니다");
		var url = "../member/loginForm.jsp";
		
		location.href= url;
		return;
	} --%>
	if(flag == true){
		var url = "./deleteForm.jsp";
		url = url +"?num="+num;
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";
		url += "&oldfile=<%=dto.getFname()%>";
		location.href= url;
	}
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
  <TABLE style="width: 50%">
    <TR>
      <TD colspan="2">
      <img src="./storage/<%=dto.getFname() %>" width="100%">
      </TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=content %></TD>
    </TR>
  </TABLE>
  <TABLE style="width: 50%">
  <TR>
  <%
  	List list = dao.imgRead(num);
    String[] files = (String[])list.get(0);
    int[] noArr = (int[])list.get(1);
    for(int i=4;i>=0;i--){
    	if(files[i]==null){  	//이미지가 있다면 보여주고 없다면 default이미지 표시
  %>
  <td class="td_padding"><img src="./storage/default.jpg" width="100%"><td>
  <%
    	}else{
    		if(noArr[i]==num){	 //보더 속성을 주거나 말거나(현재 read인 경우 그 이미지 둘레를 굵게 표시)
  %> 	
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="curImg" src="./storage/<%=files[i] %>" width="120px" border="0">
  </a></td>
  <%		
    		}else{
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img src="./storage/<%=files[i] %>" width="120px" border="0">
  </a></td>
  			
  <%
    		}
    	 }   		
      }
  %>
  </TR>
  </TABLE>
  
  <DIV class='bottom'>
		<%if((id != null) && id.equals(dto.getId())){ //로그인 정보(id)가 글과 일치하면 버튼이 보이게%>
		<button type="button" onclick="bdelete(<%=num%>)">삭제</button>
		<input type='button' value='수정' onclick="bupdate('<%=num%>')"> 
		<%} %>
		<input type='button' value='목록' onclick="blist()">
	</DIV>

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 

