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
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
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
   		<div style="font-size:20px;">
   		면접 질문
   		</div>
		<div style="display:flex">
			<div style="width: 25%; overflow-x: scroll; display: -webkit-box;">
				<%
					for (int i = 0; i < StringUtil.hashTagDel(sDTO.getSpcJobTag()).length; i++) {
				%>
				<div style="border-radius: 20px; color: #00aeef; border: 1px solid #00aeef; padding: 15px 15px; margin-right: 10px; font-size: 0.874em; text-align: left; line-height: 1.248em; letter-spacing: -0.044em;">
				<%=StringUtil.hashTagDel(sDTO.getSpcJobTag())[i]%>
				</div>
				<%} %>
			</div>
			<marquee style="width:60%; font-size:20px">
				<%=sDTO.getSpcJobTitle() %>  - 질문 : <%=sDTO.getSpcJobQuestion() %>
			</marquee>
			<div style="width:30%;text-align:center" ><img src="/resources/image/play.png" onclick="textToSpeech.settingsPush('<%=sDTO.getSpcJobQuestion()%>')" style="height: 67.56px"/></div>
		</div>
		<%if (webType.equals("m")){ %>
		<input type="file" accept="audio/*" capture="microphone" id="recorder" />
        <audio id="player" controls></audio>
      	<script src=""></script>

		<%}else{ %>

		    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/p5.min.js"></script>
		    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/addons/p5.sound.js"></script>
		    <script src="/resources/js/sketch.js"></script>
		  	
		  	<div class="imgInterview" style="display:flex;justify-content:center">
		  		<img src="/resources/image/interview.svg"  style="width:100%;height:250px;"/>
		  	</div>
		  	<div id="webRecorder" style="display:flex;justify-content:center">
		  	</div>
		  	<div id="alertText"></div>
   			<div style="display: flex;justify-content:center">
   				<img id="webRecord" onclick="webRecord()" src="/resources/image/blueRec.svg" style="height:120px;cursor:pointer">
   				<img id="webStop"  src="/resources/image/redRec.svg" style="display:none;height:120px;cursor:pointer"/>
			    <img id="webPlay" onclick="webPlay()" src="/resources/image/play.png" style="display:none;height:100px;padding-top: 10px;cursor:pointer"/>
			    <img id="webSvFile" onclick="webSvFile('<%=session.getAttribute("userName")%>-<%=sDTO.getSpcJobTitle()%>-<%=StringUtil.newDate(new Date())%>')" style="display:none;height:120px;cursor:pointer" src="/resources/image/download.png"/>
			    <img id="webSoundFileStop" src="/resources/image/recStop.svg"  onclick="webSoundFileStop()" style="display:none;height:120px;cursor:pointer">
			    <img id="webPause" onclick="webPause()" src="/resources/image/recPause.svg" style="display:none;height:100px;padding-top: 10px;cursor:pointer" >	   
   			</div>
  			<div style="display: flex;justify-content:center;border:1px solid #dfdfdf;border-radius:10px;padding-bottom:24px;"> 
			   <form id="uploadForm">
			   <input type="file" accept="audio/*" id="webRecorderFile" name="webRecorderFile" style="display:none"/>
		   		<label for="webRecorderFile"  style="cursor:point" onchange="webRecorderUpload.wRecorderFileContent()">
		  			<img src="/resources/image/filePlus.svg" style="display:table; padding-top:30px; padding-bottom:12px;margin:0px auto ;" />
		   			<p style="text-align:center;color:#6f6f6f">오디오 파일은 1개만 첨부 가능합니다.</p>
		   			<p style="color:#3990ff">녹음 된 파일은 다운로드 폴더에 저장되어있습니다.</p>
		   			<div id="fileContent"></div>
		   		</label>
		   		<input type="hidden" name="spcNo" value="<%=sDTO.getSpeechNo()%>"/>
		   		</form>
		  	</div>
		  	<button id="aj"> 등록하기 </button>
		  	<div onclick="pageMove.answerList('<%=sDTO.getSpeechNo()%>')">질문 답변 목록 보기</div>
		  	<button id="jjkk"> 변환하기 </button>
		  	<script src="/resources/js/record.js"></script>
		<%} %> 
   </div>

<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
	<script>
		  $(function(){
			  $('#aj').click(function(){
			  		$("#uploadForm").ajaxForm({
			  			url:"/speech/insertRecord.do",
			  			enctype:"multipart/form-data",
			  			method:"post",
			  			success:function(data){
			  				console.log(data)
			  			}
			  		}).submit();
			  	})
		  });
		  
		
		  $('#jjkk').click(function(){
			 	$.ajax({
			 		url:"/speech/changeBlob.do",
			 		method:"get",
			 		data:{
			 			fileNo:"5"
			 			},
			 		success:function(data){
			 			speechToText.speechToTextAjax(data)
			 		}
			 	})
		  })
		 
		  
		  	</script>
</body>

</html>