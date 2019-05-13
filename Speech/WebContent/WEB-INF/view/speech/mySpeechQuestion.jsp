<%@page import="poly.util.StringUtil"%>
<%@page import="poly.dto.SpeechDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<SpeechDTO> sList =(List<SpeechDTO>)request.getAttribute("sList"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Dr.speech - 업계별 면접 유형</title>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="headerMain">
	<img src="/resources/image/arrow-left.svg"> 나의 면접 질문
</div>
 <div class="padLR">
   <div class="clientName">
       <div>Dr.Speech의고객</div>
       <div><b><%=session.getAttribute("userName") %></b>님</div>
   </div>
   <div class="padLR9">
   		<div>
	   		<select>
	   			<option>업계별</option>
	   			<option>날짜별</option>
	   		</select>
   		</div>
   		<div>
   			<input type="text"/>
   		</div>
   		<div>
   			검색
   		</div>
   </div>
   <div class="padLR82">
   		<div class="mySpcRegister" onclick="mySpcRegDel.reg()">등록</div>
   		<div class="mySpcDelete" onclick="mySpcRegDel.del()">삭제</div>   
   </div>
   <div class="padLR10">
   		<div style="width:25%;text-align: center">태그</div>
   		<div style="width:50%;">제목</div>
   		<div style="width:25%;text-align: center">체크</div>
   </div>
   <%for(int i = 0 ; i <sList.size(); i++){ %>
   <div class="padLR10">
   		<div class="spcTagScroll">
   			<%for(int j = 0; j < StringUtil.hashTagDel(sList.get(i).getSpcJobTag()).length;j++){ %>
   			<div class="borderDiv">
   			<%=StringUtil.hashTagDel(sList.get(i).getSpcJobTag())[j]%>
   			</div>
 			<%} %>
   		</div>
   		<div class="spcTitle">
   			<div><%=sList.get(i).getSpcJobTitle() %></div>
   			<div><%=sList.get(i).getRegdate() %></div>
   		</div>
   		<div style="width:25%;text-align: center">
   			<input type="checkbox" />
   		</div>
   </div>
   <%} %>
</div>
</body>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</html>