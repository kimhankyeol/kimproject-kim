<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="mainTopBar" style="position: sticky">
	<div class="mainTopBarIcon">
		<img id="menuIconClick" style="cursor: pointer;"
			src="/resources/image/menu_icon.jpg">
	</div>
</div>
<div id="opacityhalf" class=""></div>
<div id="menuBar" class="mainMenuBar">
	<div class="mainMenuBarList" onclick="pageMove.singleParam('home')">
		<i class="fa fa-home" style="margin-right: 5px"></i>홈
	</div>
	<% if (session.getAttribute("userName")==null){ %>
	<div class="mainMenuBarList" onclick="pageMove.singleParam('home')">
		<i class="fa fa-sign-in" style="margin-right: 5px"></i>로그인
	</div>
	<%} else { %>
    <div class="mainMenuBarList" onclick="snsLogInOut.logout('<%=session.getAttribute("snsVal")%>')"><i class="fa fa-sign-in" style="margin-right: 5px"></i>로그아웃</div>
    <%} %> 
	
	<div class="mainMenuBarList">
		<i class="fa fa-book" style="margin-right: 5px" onclick="pageMove.notice('')"></i>공지사항
	</div>
	<div id="menuBarClose" class="mainMenuBarList">
		<i class="fa fa-times" style="margin-right: 5px"></i>닫기
	</div>
</div>
