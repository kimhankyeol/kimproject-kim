/*const mobileRecord={
	mRecorder:document.getElementById('mRecorder'),
	mPlayer:document.getElementById('mPlayer'),
	andRecord:mobileRecord.mRecorder.addEventListener('change',function(e){
		let file = e.target.files[0];
		mPlayer.src = URL.createObjectURL(file);
	})
} */



var mic,recorder,soundFile,amp;
var volhistory = [];

function webRecord() {
   var canvas= createCanvas(200, 300);
   canvas.parent('webRecorder');
    recorder.record(soundFile);
	
}
function webStop() {
    getAudioContext().resume()
    recorder.stop();
}
function webPlay() {
    soundFile.play();
}
function webPause(){
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