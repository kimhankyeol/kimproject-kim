<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/notoFont.css">
<link rel="stylesheet" href="/resources/css/main.css" />
<link rel="stylesheet" href="/resources/css/mySpeech.css" />
<link rel="stylesheet" href="/resources/css/font-awesome-4.7.0/css/font-awesome.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=googleInit" async defer></script> 
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="/resources/js/init.js"></script>
<script src="/resources/js/restApi.js"></script>
<script src="/resources/js/snsLogin.js"></script>
<script src="/resources/js/mainTopBar.js"></script>
<script>
 <%if(session.getAttribute("userName")==null){%>
init.kakaoInit();
snsLogInOut.kakaoLogin();
<%}%> 
</script>
