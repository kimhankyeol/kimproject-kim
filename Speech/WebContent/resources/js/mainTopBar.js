
const menuTop = (function(){
	var opacityhalf = document.getElementById('opacityhalf');
	var menuIconClick = document.getElementById('menuIconClick');
	var menuBar = document.getElementById('menuBar');
	var menuBarClose = document.getElementById('menuBarClose');
	
	
	//메뉴바 선택
	menuIconClick.onclick = function() {
		opacityhalf.classList.add('opacityActive');
		menuBar.classList.remove('mainMenuBar');
		menuBar.classList.add('menuBarActive');
	}
	menuBarClose.onclick = function() {
		opacityhalf.classList.remove('opacityActive');
		menuBar.classList.add('mainMenuBar');
		menuBar.classList.remove('menuBarActive');
	}
	
})();
const recomDateSelect = {
		spcRecOrder : document.getElementsByClassName('spcRecOrder'),
		spcDateOrder :document.getElementsByClassName('spcDateOrder'),
		recommend : function(param){
			recomDateSelect.spcRecOrder[0].classList.add('selActive');
			recomDateSelect.spcDateOrder[0].classList.remove('selActive');
			//비동기 처리 논리 로직
		},
		date : function(param){
			recomDateSelect.spcRecOrder[0].classList.remove('selActive');
			recomDateSelect.spcDateOrder[0].classList.add('selActive');
			//비동기 처리 논리 로직
		}
}
const mySpcRegDel = {
		mySpcRegister : document.getElementsByClassName('mySpcRegister'),
		mySpcDelete : document.getElementsByClassName('mySpcDelete'),
		reg : function(){
			mySpcRegDel.mySpcRegister[0].classList.add('selActive');
			mySpcRegDel.mySpcDelete[0].classList.remove('selActive');
			pageMove.speech('insertView');
			},
		del : function(){
			mySpcRegDel.mySpcRegister[0].classList.remove('selActive');
			mySpcRegDel.mySpcDelete[0].classList.add('selActive');
		}
}

const pageMove = {
		singleParam:function(urlName){
			location.href="/"+urlName+".do";
		},
		speech:function(urlName){
			location.href="/speech/"+urlName+".do";
		},
		notice:function(urlName){
			location.href="/notice/"+urlName+".do";
		},
		loginCbHref:function(name,email,snsVal){
			location.href="loginCallback.do?name="+name+"&email="+email+"&snsVal="+snsVal;
		}
}

const frmSubmit = {
		spcInsertSubmit : function(){
			const spcInsert = document.getElementById('spcInsert');
			spcInsert.submit();
		}
}


