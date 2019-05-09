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
	<div style="font-size:20px; line-height: 30px">
   	면접 질문 등록
	</div>
	<form id="spcInsert" action="/speech/speechInsertProc.do">
		<div class="spcJobIns">
		업계
		</div>
	    <input type="text" class="spcJobInsText" name="spcJobTag" placeholder="최대 3글자, 태그 최대 2개까지 " style=""/>
		<div class="spcJobIns">
		제목
		</div>
		<input type="text" class="spcJobInsText" name="spcJobTitle" placeholder="최대 30자 이내로 작성해주세요." />
		<div class="spcJobIns" >
		질문
		</div>
		<input type="text" class="spcJobInsText" name="spcJobQuestion" placeholder="질문은 최대 100자이내로 작성해주세요." />	
	</form>
	<div style="display:flex;justify-content: center">
		<div class="spcJobIns"  onclick="frmSubmit.spcInsertSubmit()" style="margin-right:10px;">
		등록
		</div>
		<div class="spcJobIns" style="margin-left:10px;">
		취소
		</div>
	</div>
</div>
</body>
<style>

</style>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</html>