<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	MemberDTO dto = dao.read(id);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function inCheck(f){                      //얘는submit 할때 검증되는 함수임
	if(f.id.value==""){
		alert("아이디를 입력해 주세요");
		f.id.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("패스워드를 입력해 주세요");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value==""){
		alert("비밀번호 확인을 입력해 주세요");
		f.repasswd.focus();
		return false;
	}
	if(f.repasswd.value!=f.passwd.value){
		alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
		f.repasswd.focus();
		return false;
	}
	if(f.mname.value==""){
		alert("이름을 입력해 주세요");
		f.mname.focus();
		return false;
	}
	if(f.email.value==""){
		alert("이메일을 입력해 주세요");
		f.email.focus();
		return false;
	}
	if(f.job.value=="0"){
		alert("직업을 선택해 주세요");
		f.job.focus();
		return false;
	}
}
function idCheck(id){
	if(id==""){
		alert("아이디를 입력해 주세요");
		document.frm.id.focus();
	}else{
		var url = "./id_proc.jsp"
		url += "?id="+id;
		
		wr = window.open(url, "아이디 검색", "width=500,height=500"); /*  window.open : 새창  wr는 새창을 말한다.*/
		wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);              /* x좌표와 y좌표를 나타낸다 */
	}
}
function emailCheck(){
	var email=document.frm.email.value;
	if(email==""){
		alert("이메일을 입력해 주세요");
		document.frm.email.focus();
	}else if(email == '<%=dto.getEmail()%>'){
		var url = "./email_form.jsp";
			
			wr = window.open(url, "이메일 검색", "width=500,height=500"); /*  window.open : 새창  wr는 새창을 말한다.*/
			wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);              /* x좌표와 y좌표를 나타낸다 */
	}else{
		var url = "./email_proc.jsp";
		url += "?email="+email;
		
		wr = window.open(url, "이메일 검색", "width=500,height=500"); /*  window.open : 새창  wr는 새창을 말한다.*/
		wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);              /* x좌표와 y좌표를 나타낸다 */
	}
}
function emailCheck2(i){
	i.blur();                 /* 입력하면 커서가 없어짐(입력이 안됨) */
	alert("이메일을 변경하시려면 \n 중복확인버튼을 사용하세요");
}
function mlist(){
	var url = "./list.jsp";
	
	location.href=url;
}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">회원수정</DIV>
 
<FORM name='frm'
	  method='POST'
	  action='./updateProc.jsp'
	  onsubmit="return inCheck(this)"                     <%--  onsubmit="return inCheck(this)로 false값 오면 안넘기게. --%>
	  >
	<input type="hidden" name="id" value="<%=dto.getId()%>">
  <TABLE>
    <TR>
      <td colspan="3"><img src="./storage/<%=dto.getFname()%>"/></td>
    </TR>
    <TR>
      <TH>ID</TH>
      <TD>
      	<%=dto.getId() %>
      </TD>
      <td>ID 입니다.(변경불가)</td>
    </TR>
    <TR>
      <TH>*이름</TH>
      <TD><%=dto.getMname() %></TD>
      <td>고객의 실명</td>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><input type="text" name="tel" size="15" value="<%=Utility.checkNull(dto.getId()) %>"></TD>
      <td>변경할 전화번호를 적어주세요</td>
    </TR>
    <TR>
      <TH>*이메일</TH>
      <TD>
      	<input type="email" name="email" size="15" 
      	value="<%=dto.getEmail() %>" onkeydown="emailCheck2(this)">     <!--  타입이 email이면 submit 시에 @가 있는지 확인한다. -->
      	<!-- 여기서 this는 이 input태그를 말한다. -->
      	
      	<button type="button" onclick="emailCheck()">e-mail 중복 확인</button>
      </TD>
      <td>변경할 이메일을 적어주세요.(*은 필수 입력사항)</td>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD>
      	<input type="text" name="zipcode" size="7" id="sample6_postcode" placeholder="우편번호" value="<%=Utility.checkNull(dto.getZipcode()) %>">
      	<button type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">주소검색</button> 
      </TD>
      <td></td>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
      	<input type="text" name="address1" size="40" id="sample6_address" placeholder="주소" value="<%=Utility.checkNull(dto.getAddress1()) %>">
      	<input type="text" name="address2" size="40" id="sample6_address2" placeholder="상세주소" value="<%=Utility.checkNull(dto.getAddress2()) %>">
      </TD>
      <td></td>
    </TR>
     <TR>
      <TH>*직업</TH>
      <TD>
      	<select name="job">
      		<option value='0'>선택하세요</option>
      		<option value='A01'>회사원</option>
      		<option value='A02' selected>전산관련직</option>
      		<option value='A03'>연구전문직</option>
      		<option value='A04'>각종학교학생</option>
      		<option value='A05'>일반자영업</option>
      		<option value='A06'>공무원</option>
      		<option value='A07'>의료인</option>
      		<option value='A08'>법조인</option>
      		<option value='A09'>종교/언론/예술인</option>
      		<option value='A10'>기타</option>
      	</select>
      	<script type="text/javascript">
      		document.frm.job.value='<%=dto.getJob()%>';
      	</script>
      </TD>
      <td>변경할 직업을 선택하세요(*은 필수 입력사항)</td>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정완료'>
    <input type='reset' value='취소'>
    <input type='button' value='리스트로 이동' onclick="mlist()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 