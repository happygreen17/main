<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="image.*"%>
<%@ page import="bbs.*"%>
<%@ page import="member.*"%>
<%@ page import="utility.*"%>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String root = request.getContextPath();
	
	//회원목록
	String tempDir = "/member/temp"; 
	String upDir = "/member/storage"; 
	
	tempDir = application.getRealPath(tempDir);
	upDir = application.getRealPath(upDir);
	
	//이미지게시판
	String tempDir2 = "/imageList/temp"; 
	String upDir2 = "/imageList/storage"; 
	
	tempDir2 = application.getRealPath(tempDir2);
	upDir2 = application.getRealPath(upDir2);
	
	//자유게시판
	String tempDir3 = "/bbs/temp"; 
	String upDir3 = "/bbs/storage"; 
	
	tempDir3 = application.getRealPath(tempDir3);
	upDir3 = application.getRealPath(upDir3);
%>