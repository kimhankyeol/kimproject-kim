const mobileRecord={
	mRecorder:document.getElementById('mRecorder'),
	mPlayer:document.getElementById('mPlayer'),
	andRecord:mobileRecord.mRecorder.addEventListener('change',function(e){
		let file = e.target.files[0];
		mPlayer.src = URL.createObjectURL(file);
	})
} 

var recorder = document.getElementById('recorder');
 var player = document.getElementById('player');
  recorder.addEventListener('change', function(e) {
	var file = e.target.files[0];

	player.src = URL.createObjectURL(file);
});