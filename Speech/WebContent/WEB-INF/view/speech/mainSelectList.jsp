<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Dr.speech - 메인 리스트</title>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
    <div class="headerMain">
        <img src="/resources/image/arrow-left.svg"> 메인
    </div>
    <div class="padLR">
        <div class="clientName">
            <div>Dr.Speech의고객</div>
            <div><b><%=session.getAttribute("userName") %></b>님</div>
        </div>
        <div class="menuList" onclick="pageMove.speech('mySpeechQuestion')">
            나의 면접 질문
        </div>
        <div class="menuList" onclick="pageMove.speech('jobCtgSpeech')">
            업계별 면접 유형
        </div>
        <div class="menuList">
            면접 분석
        </div>
        <div class="menuList">
            광고영역
        </div>
    </div>
</body>

<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
</html>