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
				"x-goog-api-key":jsonData.read.responseJSON.googleApiKey,
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