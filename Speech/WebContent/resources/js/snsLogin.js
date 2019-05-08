const snsLogInOut = {
		//카카오 로그인
		kakaoLogin:function(){
			 Kakao.Auth.createLoginButton({
			    container: '#kakao-login-btn',
			    success: function(authObj) {
			    	//로그인 성공시 , API 호출
			    	Kakao.API.request({
			    		url:'/v2/user/me',
			    		success:function(res){
			    			kName = JSON.stringify(res.properties.nickname);
							kEmail = JSON.stringify(res.kakao_account.email);
							pageMove.loginCbHref(kName,kEmail,'kakao');
			    		}
			    	})
			    },
			    fail: function(err) {
			        alert(JSON.stringify(err));
			    }
			  });
		},
		//구글 로그인
		googleLogin:function (){
			var auth2 =gapi.auth2.getAuthInstance();
			auth2.signIn().then(function(){
				const name=auth2.currentUser.get().getBasicProfile().getName();
				const email=auth2.currentUser.get().getBasicProfile().getEmail();
				pageMove.loginCbHref(name,email,'google');
			})
		},
		//페이스북 로그인
		//FB.getLoginStatus() 의 결과를 받아오는곳
		statusChangeCallback:function(response){
			if(response.status === 'connected'){
				//snsLogInOut.loginAPI();
			} else {
				document.getElementById('status').innerHTML = 'please log into this app'
			}
		},
		//이 함수는 로그인 버튼 완료되었을떄 onlogin 실행
		checkLoginState(){
			var name="";
			var email="";
			FB.getLoginStatus(function(response){
				snsLogInOut.statusChangeCallback(response);
			});
			FB.api('/me', function(response) { 
				name=JSON.stringify(response.name);
				email=JSON.stringify(response.id);
				pageMove.loginCbHref(name,email,'facebook');
			});
			
		},
		
		/*testAPI:function(){
			FB.api('/me',function(response){
			})
		},*/
		//로그아웃
		logout:function(snsVal){
			if(snsVal=="kakao"){
				init.kakaoInit();
				Kakao.Auth.logout(function(){
					location.href="/logout.do"
				});
			}else if(snsVal=="google"){
				var auth2 = gapi.auth2.getAuthInstance();
				auth2.signOut().then(function(){
					console.log('구글 로그아웃');
				});
				auth2.disconnect();
				location.href="/logout.do";
			}else if(snsVal =="facebook"){
				FB.logout(function(response) {
					  // user is now logged out
				});
				location.href="/logout.do"
			}
		}
}

