const init = {
		kakaoInit:function(){
			Kakao.init('43345c9ebcab9cfdb9af11b8112451b4');
		},
		filter:"win16|win32|win64|mac|macintel",
		webType:""
/*,
		googleInit:function(){
			gapi.load('auth2',function(){
				auth2 = gapi.auth2.init({
					client_id: '1035513150483-b85u86ja2qpj75ertnrq5pt1qhd8r97e.apps.googleusercontent.com',
					cookiepolicy:'single_host_origin'
				});
			});
		}*/
}
//구글 
function googleInit(){
	gapi.load('auth2',function(){
		auth2 = gapi.auth2.init({
			client_id: '1035513150483-b85u86ja2qpj75ertnrq5pt1qhd8r97e.apps.googleusercontent.com',
			cookiepolicy:'single_host_origin'
		});
	});
}
//페이스북 초기 함수
window.fbAsyncInit = function() {
    FB.init({
      appId      : '361961964444617',
      cookie     : true,  // enable cookies to allow the server to access 
                          // the session
      xfbml      : true,  // parse social plugins on this page
      version    : 'v3.3' // The Graph API version to use for the call
    });

    FB.getLoginStatus(function(response) {
    	snsLogInOut.statusChangeCallback(response);
    });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
  
  