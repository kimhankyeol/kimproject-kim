const textToSpeech ={
		settingsPush:(textQuestion)=>{
			textToSpeech.settings.data="{'audioConfig': {'audioEncoding': 'LINEAR16','pitch': 0,'speakingRate': 1},'input': {'text': '"+textQuestion+"'},'voice': {'languageCode': 'ko-KR','name': 'ko-KR-Wavenet-B'}}"
			console.table(textToSpeech.settings)
			$.ajax(textToSpeech.settings).done(function(response) {
			      //console.log(response.audioContent);
			      var snd = Sound("data:audio/wav;base64," + response.audioContent);
			})
		},
		settings:{
			"async":true,
			"crossDomain":true,
			"url":"https://texttospeech.googleapis.com/v1/text:synthesize",
			"method":"POST",
			"headers":{
				"x-goog-api-key":jsonData.read,
				"content-type":"application/json",
				"cache-control":"no-cache"
			},
			"processData":false,
	}
}	

//An element to play the speech from Google Cloud 
const Sound = (function () {
    var df = document.createDocumentFragment();
    return function Sound(src) {
        var snd = new Audio(src);
        df.appendChild(snd); // keep in fragment until finished playing
        snd.addEventListener('ended', function () {df.removeChild(snd);});
        snd.play();
        return snd;
    }
}());
const speechToText = {
		settings:{
			"async":false,
			"crossDomain":true,
			"url":"https://speech.googleapis.com/v1/speech:recognize",
			"method":"POST",
			"headers":{
				"x-goog-api-key":jsonData.read,
				"content-type":"application/json",
				"cache-control":"no-cache"
			},
			"processData":false,
	},
	speechToTextAjax:(speechBlob,param)=>{
		//돈 나가니까 시연할떄 풀어
		
		speechToText.settings.data="{'config': {'encoding':'LINEAR16','sampleRateHertz': 48000, 'languageCode': 'ko-KR','enableWordTimeOffsets': true,'audioChannelCount':2}, 'audio': { 'content':'"+speechBlob+"'}}"
		$.ajax(speechToText.settings).done(function(response){
			console.log(response)
			console.log(response.results[0].alternatives[0].words)
			const words=response.results[0].alternatives[0].words;
			const word = new Array();
			const startTime = new Array();
			const endTime = new Array();
			const term = new Array();
			$.each(words,function(i,item){
				word.push(item.word);
				startTime.push(item.startTime.slice(0,-1));
				endTime.push(item.endTime.slice(0,-1));
				term.push(parseFloat(item.endTime.slice(0,-1)).toFixed(4)-parseFloat(item.startTime.slice(0,-1)).toFixed(4))
			})
			const jsonParam = {
					"fileNo" : param.fileNo,
					"transcript" : response.results[0].alternatives[0].transcript,
					"confidence" : response.results[0].alternatives[0].confidence,
					"spcNo": param.sDTO.speechNo,
					"word" : JSON.stringify(word),
					"term" : JSON.stringify(term),
					"startTime" : JSON.stringify(startTime),
					"endTime" : JSON.stringify(endTime)
			}
			$.ajax({
				url:"/speech/speechDataInsert.do",
				method:"post",
				data:jsonParam,
				success:function(data){
					alert(data.msg);
					location.href=data.url;
				},
				error:function(error){
					console.error('마지막 ajax 에러')
				}
			})
			//location.href="/speech/speechDataInsert.do?transcript="+transcript+"&confidence="+confidence+"&fileNo="+param.fileNo+"&words="+words+"&spcNo="+param.sDTO.speechNo
			
		});
	}
}

