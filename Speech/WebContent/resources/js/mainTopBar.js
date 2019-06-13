
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
			if($('input[name=spcNo]:checked').length==0){
				alert('삭제할 대상이 선택되지 않았습니다.');
				return false;
			}else{
				var spcNoArr=[];
				$('input[name=spcNo]:checked').each(function(index){
					spcNoArr.push($(this).val());
				})
				console.log(spcNoArr)
				location.href="/speech/delete.do?spcNoArr="+spcNoArr;
			}
		}
}
$('#selectID').change(function(){
	$('#textChangeVal').val($('#selectID option:selected').val())
})
const pageMove = {
		singleParam:function(urlName){
			location.href="/"+urlName+".do";
		},
		speech:function(urlName){
			location.href="/speech/"+urlName+".do";
		},
		speechDelete:function(urlName,param){
			location.hred="/speech/"+urlName+".do?spcNo="+param;
		},
		notice:function(urlName){
			location.href="/notice/"+urlName+".do";
		},
		speechDetail:function(urlName,webtype,spcNo){
			location.href="/speech/detail.do?webType="+webtype+"&spcNo="+spcNo;
		},
		answerList:function(spcNo){
			location.href="/speech/answerList.do?spcNo="+spcNo;
		},
		answerDetail:function(fileNo){
			location.href="/speech/answerDetail.do?fileNo="+fileNo;
		},
		loginCbHref:function(name,email,snsVal){
			location.href="loginCallback.do?name="+name+"&email="+email+"&snsVal="+snsVal;
		},
		webCtgSpcDetail:function(spcNo){
			if (navigator.platform) {
				if (init.filter.indexOf(navigator.platform.toLowerCase()) < 0) {
					console.log("모바일")
					pageMove.speechDetail("detail","m",spcNo)
				} else {
					console.log("PC");
					pageMove.speechDetail("detail","p",spcNo)
				}
			}
		}
}
const frmSubmit = {
		spcInsert : document.getElementById('spcInsert'),
		spcJobTag : document.getElementsByName('spcJobTag'),
		spcJobTitle : document.getElementsByName('spcJobTitle'),
		spcJobQuestion : document.getElementsByName('spcJobQuestion'),
		spcInsertSubmit : function(){
			if(frmSubmit.spcJobTag.length == 0){
				alert('태그를 입력해주세요');
				return false;
			}else if(frmSubmit.spcJobTag.length==4){
				alert('태그는 최대 3개 까지 입력가능합니다.');
				return false;
			
			}else if(frmSubmit.spcJobTitle[0].value == ""){
				alert('질문 제목을 입력해주세요');
				return false;
				
			}else if(frmSubmit.spcJobQuestion[0].value == ""){
				alert('질문을 입력해주세요');
				return false;
			}
			frmSubmit.spcInsert.submit();
		}

}
const tagKeyPress={
	tagSpcKeyPress : document.getElementById('tagSpcKeyPress'),
	tagAdd : document.getElementById('tagAdd'),
	tagError : document.getElementById('tagError'),
	addTag : function(){
		if(tagSpcKeyPress.value==""){
			tagKeyPress.tagError.style.color='red';
			tagKeyPress.tagError.innerHTML='태그명이 입력되지 않았습니다.';
			return false;
		}else{
			tagKeyPress.tagError.innerHTML='';
		}
		
		if(tagSpcKeyPress.value.length>5){
			tagKeyPress.tagError.style.color='red';
			tagKeyPress.tagError.innerHTML='태그명의 길이는 최대 5글자입니다.';
			return false;
		}else{
			tagKeyPress.tagError.innerHTML='';
		}
		
		if(frmSubmit.spcJobTag.length>2){
			tagKeyPress.tagError.style.color='red';
			tagKeyPress.tagError.innerHTML='태그는 최대 3개 까지 입력가능합니다.';
			return false;
		}else{
			tagKeyPress.tagError.innerHTML='';
		}
		if(event.key === "Enter" || event.keyCode==13){
			tagAdd.innerHTML+="<input type='text' class='tagDelete' name='spcJobTag' onclick='tagClick.tagDel()' value='#"+tagKeyPress.tagSpcKeyPress.value+"'>";
		}
	}
}

const tagClick={
	tagDel:$(document).on('click','.tagDelete',function(){
		const index = $(this).index();
	 	$('.tagDelete').eq(index).remove();
	})
}

//로딩바 
const loading = {
		loadingHide:$('#loading').hide()
}
