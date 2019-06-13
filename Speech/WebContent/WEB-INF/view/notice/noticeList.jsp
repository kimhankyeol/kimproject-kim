<%@page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%List<NoticeDTO> nList = (List<NoticeDTO>) request.getAttribute("nList"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>
</head>
<body>

<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="padLR">
<div style="text-align: center; font-size: 20px">닥터스피치 공지사항</div>
<div style="display:flex;justify-content: space-between;">
	<div>번호</div>
	<div>제목</div>
	<div>작성자</div>
	<div>날짜</div>
</div>
</div>
<div class="padLR" style="height: 400px">
<%for(int i = 0 ; i < nList.size();i++){ %>
	<div style="display:flex;justify-content: space-between;">
		<div><%=i+1 %></div>
		<div ><%=nList.get(i).getNoticeTitle() %></div>
		<div><%=nList.get(i).getWriter() %></div>	
		<div><%=nList.get(i).getRegdate() %></div>
	</div>
<%} %>
</div>
<div class="btnRegCss" onclick="pageMove.notice('insert')">등록하기</div>
 <%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</body>
</html>