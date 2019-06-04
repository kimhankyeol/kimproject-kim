<%@page import="poly.dto.AnswerDTO"%>
<%@page import="poly.dto.SpeechDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% List<AnswerDTO> sList = (List<AnswerDTO>)request.getAttribute("sList"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>닥터스피치 - 질문 답변 리스트</title>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="headerMain">
	<img src="/resources/image/arrow-left.svg"> <%=sList.get(0).getSpcJobTitle()%>
</div>
 <div class="padLR">
   <div class="clientName">
       <div>Dr.Speech의고객</div>
       <div><b><%=session.getAttribute("userName") %></b>님</div>
   </div>
   <div class="padLR10">
   		<div style="width:25%">번호</div>
   		<div style="width:50%">제목</div>
   		<div style="width:25%">면접자</div>
   </div>
</div>
<%for(int i = 0 ; i<sList.size();i++){ %>
<div class="padLR">
	 <div class="padLR10">
		<div style="width:25%"><%=i+1%></div>
		<div style="width:50%" onclick="pageMove.answerDetail('<%=sList.get(i).getFileNo()%>')"><%=sList.get(i).getSpcJobQuestion() %></div>
		<div style="width:25%"><%=sList.get(i).getUserName() %></div>
	</div>
</div>
<%} %>
</body>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</html>