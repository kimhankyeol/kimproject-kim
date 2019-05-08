<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<img src="/resources/image/arrow-left.svg"> 업계별 면접 유형
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
   		<div class="spcRecOrder" onclick="recomDateSelect.recommend('id')">추천순</div>
   		<div class="spcDateOrder" onclick="recomDateSelect.date('id')">날짜순</div>   
   </div>
   <div class="padLR10">
   		<div style="width:25%">태그</div>
   		<div style="width:50%">제목</div>
   		<div style="width:25%">추천</div>
   </div>
   <div class="padLR10">
   		<div class="spcTagScroll">
   			<div class="borderDiv">
   			#IT
   			</div>
 			<div class="borderDiv">
 			#경제
 			</div>  			
   		</div>
   		<div class="spcTitle">
   			<div>IT-Dispatcher에 대해 설명해주세요 제일 긴글입니다.</div>
   			<div>2019-12-12</div>
   		</div>
   		<div style="width:25%">3</div>
   </div>
</div>
</body>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</html>