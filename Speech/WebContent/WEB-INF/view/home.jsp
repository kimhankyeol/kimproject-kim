<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>Dr.Speech-Main</title>
</head>
<body class="mainBackground">
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
    <div class="mainPadTop">
        <div class="mainTitle1">Dr.Speech의</div>
        <div class="mainImage"><img src="resources/image/DrSpeechIcon.svg" alt="doctorImage"></div>
        <div class="mainTitle2">면접 제작소</div>
    </div>
   <% if (session.getAttribute("userName")==null){ %>
    <div class="mainSnsBtnGrp" >
        <div class="mainSnsBtn">
       		<a id="kakao-login-btn"></a>
        </div>
        <div class="mainSnsBtn">
        	<img src="resources/image/btn_google_signin_light_normal_web.png"  style="width:232px;height:49px;cursor:pointer" onclick="snsLogInOut.googleLogin()"/>
        </div>
         <div class="mainSnsBtn">
   			 <div class="fb-login-button" style="display:flex; justify-content: center;" scope="public_profile,email" data-size="large" data-button-type="continue_with" data-auto-logout-link="false" onlogin="snsLogInOut.checkLoginState()" data-use-continue-as="true"></div>
        </div> 
    </div>
    <%} else { %>
    <div onclick="pageMove.speech('list')"> 면접 메인으로 가기 </div>
    <div onclick="snsLogInOut.logout('<%=session.getAttribute("snsVal")%>')">로그아웃</div>
    <%} %> 
 <%@ include file="speechJsCss.jsp"%>
</body>

</html>