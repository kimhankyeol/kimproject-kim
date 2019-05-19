/*const mobileRecord={
	mRecorder:document.getElementById('mRecorder'),
	mPlayer:document.getElementById('mPlayer'),
	andRecord:mobileRecord.mRecorder.addEventListener('change',function(e){
		let file = e.target.files[0];
		mPlayer.src = URL.createObjectURL(file);
	})
} */


//webRecorder
var mic,recorder,soundFile,amp;
var volhistory = [];
var audioCtx = new AudioContext();
//display block 
const webRecBlockNone = {
		webRecord:document.getElementById('webRecord'),
		webStop:document.getElementById('webStop'),
		webPause:document.getElementById('webPause'),
		webPlay:document.getElementById('webPlay'),
		webSvFile:document.getElementById('webSvFile'),
		webSoundFileStop:document.getElementById('webSoundFileStop')
}
function webRecord() {
   webRecBlockNone.webRecord.style.display = 'none';
   webRecBlockNone.webStop.style.display = 'block';
   webRecBlockNone.webPause.style.display = 'none';
   webRecBlockNone.webPlay.style.display = 'none';
   webRecBlockNone.webSvFile.style.display = 'none';
   webRecBlockNone.webSoundFileStop.style.display = "none";
  
   var canvas= createCanvas(screen.width/3,screen.height/3 );
   canvas.parent('webRecorder');
   recorder.record(soundFile);
	
}
function webStop() {
	webRecBlockNone.webRecord.style.display = 'none';
	webRecBlockNone.webStop.style.display = 'none';
	webRecBlockNone.webPause.style.display = 'none';
	webRecBlockNone.webPlay.style.display = 'block';
	webRecBlockNone.webSvFile.style.display = 'block';
	webRecBlockNone.webSoundFileStop.style.display = "none";
    audioCtx.resume();
    recorder.stop();
    
}
function webPlay() {
	webRecBlockNone.webRecord.style.display = 'none';
	webRecBlockNone.webStop.style.display = 'none';
	webRecBlockNone.webPause.style.display = 'block';
	webRecBlockNone.webPlay.style.display = 'none';
	webRecBlockNone.webSvFile.style.display = 'block';
	webRecBlockNone.webSoundFileStop.style.display = "block";
	console.table(soundFile.buffer);
	soundFile.stop();
    soundFile.play();
    
    setTimeout(function(){
    	webRecBlockNone.webRecord.style.display = 'block';
    	webRecBlockNone.webStop.style.display = 'none';
    	webRecBlockNone.webPause.style.display = 'none';
    	webRecBlockNone.webPlay.style.display = 'block';
    	webRecBlockNone.webSvFile.style.display = 'block';
    	webRecBlockNone.webSoundFileStop.style.display = "none";
    },soundFile.buffer.duration*1000);
}
function webSoundFileStop(){
	webRecBlockNone.webRecord.style.display = 'block';
	webRecBlockNone.webStop.style.display = 'none';
	webRecBlockNone.webPause.style.display = 'none';
	webRecBlockNone.webPlay.style.display = 'block';
	webRecBlockNone.webSvFile.style.display = 'block';
	webRecBlockNone.webSoundFileStop.style.display = "none";
	soundFile.stop();
}
function webPause(){
	webRecBlockNone.webRecord.style.display = 'block';
	webRecBlockNone.webStop.style.display = 'none';
	webRecBlockNone.webPause.style.display = 'none';
	webRecBlockNone.webPlay.style.display = 'block';
	webRecBlockNone.webSvFile.style.display = 'block';
	soundFile.pause();
}
function webSvFile(fileName) {
    saveSound(soundFile, fileName);

}

function setup(){
	  createCanvas(0,0);
	  mic = new p5.AudioIn();
	  mic.start();
	  recorder = new p5.SoundRecorder();
	  recorder.setInput(mic);
	  soundFile = new p5.SoundFile();
}
function draw(){
	   background(0);
	   micLevel = mic.getLevel();
	   stroke(255);
	   noFill();
	  // translate(0,-height /2 )
	   beginShape();
	   volhistory.push(micLevel)
	   for(var i =0;i<volhistory.length;i++){
	       var y = map(volhistory[i]*5,0,1,height,0);
	       vertex(i,y);
	   }
	   endShape();

	    if(volhistory.length>width-50){
	        volhistory.splice(0,1);
	    }
	    stroke(255,0,0)
	    line(volhistory.length,0,volhistory.length,height)
	//   console.log(micLevel)
	   //ellipse(100,100,micLevel*1000,micLevel*1000);
}

