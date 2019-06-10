<%@page import="poly.util.StringUtil"%>
<%@page import="com.sun.xml.internal.ws.api.ha.StickyFeature"%>
<%@page import="poly.dto.AnswerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%AnswerDTO aDTO = (AnswerDTO)request.getAttribute("aDTO"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>닥터스피치 - 면접 답변</title>

<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="headerMain">
	<img src="/resources/image/arrow-left.svg">면접 답변
	<marquee><%=aDTO.getSpcJobQuestion()%>에 대한 <%=aDTO.getUserName()%>님의 면접 답변 입니다.</marquee> 
</div>
<div class="padLR">
   <div class="clientName">
       <div>Dr.Speech의고객</div>
       <div><b><%=session.getAttribute("userName") %></b>님</div>
   </div>
   <div class="imgInterview" style="display:flex;justify-content:center">
  		<img src="/resources/image/interview.svg"  style="width:100%;height:250px;"/>
  	</div>
  	<div class="tabSpeech" >
  		<div class="btnRegCss3" id="spcAnsContChk">면접 내용 확인</div>
  		<div class="btnRegCss3"  id="singleAnalysis">단일 분석</div>
  		<div class="btnRegCss3"  id="otherSpcCompare">타 면접자와 비교</div>
  	</div>
  	
  	<div id="spcContentTapData" style="display: flex;justify-content:center">
	  	<img id="spcContPlay" onclick="audioFile.play()" src="/resources/image/play.png" style="display:block;height:100px;padding-top: 10px;cursor:pointer"/>
  		<img id="spcContPause" onclick="audioFile.pause()" src="/resources/image/recPause.svg" style="display:none;height:100px;padding-top: 10px;cursor:pointer" >	   
  	</div>
  		<div>변환된 텍스트 정보</div>
		<div><%=aDTO.getTranscript()%></div>
</div>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
<script>
const audioFile ={
		<%-- audio : new Audio("<%=StringUtil.reverseSlash(aDTO.getFileNewName())%>") --%>
		audio : new Audio("http://localhost:8080/upload/spcNo-7/userNo-3/20190606103214262-3.wav"),
		play : ()=>{
			var audioDuration = $(audioFile.audio).on("loadedmetadata",function(){
			})
			console.log(audioDuration[0].duration)
			audioBlockNone.spcContPlay.style.display = 'block';
			audioBlockNone.spcContPause.style.display = 'block';
			audioFile.audio.play()
		},
		pause : ()=>{
			audioBlockNone.spcContPlay.style.display = 'block';
			audioBlockNone.spcContPause.style.display = 'none';
			audioFile.audio.pause()
		}
}
const audioBlockNone={
		spcContPlay:document.getElementById('spcContPlay'),
		spcContPause:document.getElementById('spcContPause'),
}
</script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>

<div id="chartdiv">
		</div>
</body>
</html>