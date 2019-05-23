/**
 * 
 */
const restApiAjax ={
		rest :function(method,url){
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(){ // success : function(){}
				if(xhr.status === 200 || xhr.status === 201 ){
					console.log(xhr.responseText); // xhr.responseText
				}else{
					console.log(xhr.responseText);
				}
			}
			xhr.open(method,url), // method: asda url :dsad
			xhr.send(); // data :{}
		}
};

const jsonData = {
		read : $.getJSON('/resources/json/privateInfo.json',function(data){
		})
}

