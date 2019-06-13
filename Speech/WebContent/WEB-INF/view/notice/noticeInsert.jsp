<%@page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%List<NoticeDTO> nList = (List<NoticeDTO>) request.getAttribute("nList"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항 등록</title>
</head>
<body>

<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="padLR">
<div style="text-align: center; font-size: 20px">닥터스피치 공지사항</div>
<form id="ins" action="/notice/insertProc.do">
<div style="display:flex;justify-content: space-between;">
	<div>제목</div><div style="width:100%"><input type="text" name="title"style="width:100%; border: 1px solid rgb(232, 240, 254)"/></div>
</div>
<div style="display:flex;justify-content: space-between;">
	<div>내용</div><div style="width:100%"><textarea name="cont" style="width:100%; border: 1px solid rgb(232, 240, 254)" ></textarea></div>
</div>
<input type="hidden" name="userNo" value="<%=session.getAttribute("userNo")%>"/>
<input type="hidden" name="userName" value="<%=session.getAttribute("userName")%>"/>
</form>
</div>
<div id="btnReg" class="btnRegCss">등록하기</div>
<div class="btnRegCss" onclick="location.href='/notice/list.do'">공지사항</div>
 <%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
<script>
$('#btnReg').click(function(){
	$('#ins').submit();
})
</script>
</body>
</html>