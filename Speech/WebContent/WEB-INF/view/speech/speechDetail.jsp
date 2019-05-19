<%@page import="java.util.Date"%>
<%@page import="poly.util.StringUtil"%>
<%@page import="poly.dto.SpeechDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String webType= CmmUtil.nvl((String)request.getAttribute("webType")) ; 
  SpeechDTO sDTO = (SpeechDTO) request.getAttribute("sDTO");%>
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
   		<%if (webType.equals("m")){ %>
		<input type="file" accept="audio/*" capture="microphone" id="recorder" />
        <audio id="player" controls></audio>
      	<script src=""></script>

     
		<%}else{ %>

		    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/p5.min.js"></script>
		    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/addons/p5.sound.js"></script>
		    <script src="/resources/js/sketch.js"></script>
		  	<div id="webRecorder" style="display:flex;justify-content:center">
		  	</div>
		  	 <div style="display: flex">
		    	<div id="webRecord" onclick="webRecord()" style="">녹음</div>
			    <div id="webStop" onclick="webStop()" style="display:none">녹음 정지</div>
			    <div id="webSoundFileStop" onclick="webSoundFileStop()" style="display:none">정지</div>
			    <div id="webPlay" onclick="webPlay()" style="display:none" >재생</div>
			    <div id="webPause" onclick="webPause()" style="display:none" >일시정지</div>
			   
			  	<div id="webSvFile" style="display:none" onclick="webSvFile('<%=session.getAttribute("userName")%>-<%=sDTO.getSpcJobTitle()%>-<%=StringUtil.newDate(new Date())%>')">save</div>
		  	</div>
		  	<script src="/resources/js/record.js"></script>
		<%} %> 
   </div>

<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</body>

</html>