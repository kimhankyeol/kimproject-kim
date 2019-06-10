const uploadAudioFile={
			uploadFileSubmit:function(webType){
				console.log(webType)
					if(webType=="p"){
						if(document.getElementById("webRecorderFile").value==""){
							alert('파일이 없습니다.')
							return false;
						}else{
							$("#uploadForm").ajaxForm({
					  			url:"/speech/insertRecord.do",
					  			enctype:"multipart/form-data",
					  			method:"post",
					  			success:function(data){
					  				$('#loading').show();
					  				uploadAudioFile.uploadBuffer(data);
					  			},
					  			error:function(error){
					  				alert("첫번째 ajax 에러 발생:"+error);
					  			}
					  		}).submit();
						}
					}else{
						if(document.getElementById("mRecorder").value==""){
							alert('파일이 없습니다.')
							return false;
						}else{
							$("#uploadForm").ajaxForm({
					  			url:"/speech/insertRecord.do",
					  			enctype:"multipart/form-data",
					  			method:"post",
					  			success:function(data){
					  				$('#loading').show();
					  				uploadAudioFile.uploadBuffer(data);
					  			},
					  			error:function(error){
					  				alert("첫번째 ajax 에러 발생:"+error);
					  			}
					  		}).submit();
						}
					}
				
			},
			uploadBuffer:function(param){
				var paramInfo = param;
				$.ajax({
			 		url:param.url,
			 		method:"post",
			 		async:false,
			 		data:{
			 			fileNo:param.fileNo
			 			},
			 		success:function(data){
		 				speechToText.speechToTextAjax(data,paramInfo);
			 		},
			 		error:function(error){
		  				alert("두번째 ajax 에러 발생:"+error);
		  			}
			 	})
			}
	}
const speechAudio={
		
}
		