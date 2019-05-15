<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String webType= CmmUtil.nvl((String)request.getAttribute("webType")) ; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>닥터스피치-상세보기</title>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
   <div class="headerMain">
        <img src="/resources/image/arrow-left.svg"> 상세보기
   </div>
   <div class="padLR">
   		<div class="clientName">
       		<div>Dr.Speech의고객</div>
       		<div><b><%=session.getAttribute("userName") %></b>님</div>
   		</div>
   		<div style="font-size=20px;">
   		면접 질문
   		</div>
   		
   </div>
<%if (webType.equals("m")){ %>
		<input type="file" accept="audio/*" capture="microphone" id="recorder">
        <audio id="player" controls></audio>
      	<script src=""></script>
<%}else{ %>
<%} %> 
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</body>
</html>