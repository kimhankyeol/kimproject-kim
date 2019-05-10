/**
 * 
 */
const restApiAjax ={
		rest :function(method,url){
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(){
				if(xhr.status === 200 || xhr.status === 201 ){
					console.log(xhr.responseText);
				}else{
					console.log(xhr.responseText);
				}
			}
			xhr.open(method,url),
			xhr.send();
		}
};

