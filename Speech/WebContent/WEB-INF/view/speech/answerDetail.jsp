<%@page import="poly.util.StringUtil"%>
<%@page import="poly.dto.AnswerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%AnswerDTO aDTO = (AnswerDTO)request.getAttribute("aDTO"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>닥터스피치 - 면접 답변</title>

<style>
#chartdiv {
  margin:0 auto;
  width:  80%;
  height: 200px;
}
#chartdiv1{
  margin:0 auto;
  width:  80%;
  height: 200px;
}
#chartdiv2 {
  margin:0 auto;
  width:  80%;
  height: 300px;
}
#chartdiv3 {
  margin:0 auto;
  width:  80%;
  height: 300px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/view/mainTopBar.jsp"%>
<div class="headerMain">
	<img src="/resources/image/arrow-left.svg">면접 답변
	<marquee><%=aDTO.getSpcJobQuestion()%>에 대한 <%=aDTO.getUserName()%>님의 면접 답변 입니다.</marquee> 
</div>
<div class="padLR">
   <div class="clientName">
       <div>Dr.Speech의고객</div>
       <div><b><%=session.getAttribute("userName") %></b>님</div>
   </div>
   <div class="imgInterview" style="display:flex;justify-content:center">
  		<img src="/resources/image/interview.svg"  style="width:100%;height:250px;"/>
  	</div>
  	<div class="tabSpeech" >
  		<div class="btnRegCss3" onclick="hideShowTab.click('spcAnsContChk')" id="spcAnsContChk">면접 내용 확인</div>
  		<div class="btnRegCss3" onclick="hideShowTab.click('singleAnalysis')"  id="singleAnalysis">단일 분석</div>
  		<div class="btnRegCss3" onclick="hideShowTab.click('otherSpcCompare')"  id="otherSpcCompare">타 면접자와 비교</div>
  	</div>
  	
  	<div id="spcContentAudio">
  		<div  style="display: flex;justify-content:center;padding-top:20px;padding-bottom:20px">
	  		<img id="spcContPlay" onclick="audioFile.play()" src="/resources/image/play.png" style="display:block;height:100px;padding-top: 10px;cursor:pointer"/>
  			<img id="spcContPause" onclick="audioFile.pause()" src="/resources/image/recPause.svg" style="display:none;height:100px;padding-top: 10px;cursor:pointer" >	   
  		</div>
  		<div style="text-align:center; padding-top:20px">면접 내용 확인에서는 녹음내용을 다시 확인 하실수 있습니다.</div>
  	</div>
  	<div id="spcContentAnalysis" style="display:none">
  		<div style="font-size:20px; text-align:center"><%=aDTO.getUserName() %>님의 음성 면접의 변환된 텍스트 정보</div>
		<div>SPEECH TO TEXT => <%=aDTO.getTranscript()%></div>
		<div id="chartdiv"></div>
	
		<div class="tabSpeech" style="padding-top:20px;padding-bottom:20px;" >
  			<div class="btnRegCss3" onclick="hideShowTab.click('wordTerm')">단어별 Terms(단위 : 초)</div>
  			<div class="btnRegCss3" onclick="hideShowTab.click('minSyllable')">말의 빠르기(단어별)</div>
  			<div class="btnRegCss3" onclick="hideShowTab.click('wordCloud')">워드 클라우드</div>
  		</div>
  		<div id="chartdiv1"></div>
  		<div id="chartdiv2"></div>
  		<div id="chartdiv3"></div>
		<!-- <div id="chartdiv2">
		</div> -->
  	</div>
</div>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
<script>
var answerWords = <%=aDTO.getWord()%>;
var answerTerms = <%=aDTO.getTerm()%>;
var answerStartTime = <%=aDTO.getStartTime()%>;
var answerEndTime = <%=aDTO.getEndTime()%>;
const hideShowTab = {
		click:function(param){
			if(param=="spcAnsContChk"){
				location.href="/speech/answerDetail.do?fileNo="+<%=aDTO.getFileNo()%>;
			}else if(param=="singleAnalysis"){
				document.getElementById('spcContentAudio').style.display='none';
				document.getElementById('spcContentAnalysis').style.display='block';
			}else if(param=="wordTerm"){
				document.getElementById('chartdiv1').style.display='block';
				document.getElementById('chartdiv2').style.display='none';
				document.getElementById('chartdiv3').style.display='none';
				am4core.ready(function() {
				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end

				var chart2 = am4core.create("chartdiv1", am4charts.SankeyDiagram);
				chart2.hiddenState.properties.opacity = 0; // this creates initial fade-in
				chart2.data = [];

				for(var i=0;i<answerWords.length-1;i++){
					chart2.data.push({from : answerWords[i],to:answerWords[i+1],value:parseFloat(answerTerms[i])})
				}
				let hoverState = chart2.links.template.states.create("hover");
				hoverState.properties.fillOpacity = 0.6;

				chart2.dataFields.fromName = "from";
				chart2.dataFields.toName = "to";
				chart2.dataFields.value = "value";

				// for right-most label to fit
				chart2.paddingRight = 30;

				// make nodes draggable
				var nodeTemplate2 = chart2.nodes.template;
				nodeTemplate2.inert = true;
				nodeTemplate2.readerTitle = "Drag me!";
				nodeTemplate2.showSystemTooltip = true;
				nodeTemplate2.width = 20;

				// make nodes draggable
				var nodeTemplate2 = chart2.nodes.template;
				nodeTemplate2.readerTitle = "Click to show/hide or drag to rearrange";
				nodeTemplate2.showSystemTooltip = true;
				nodeTemplate2.cursorOverStyle = am4core.MouseCursorStyle.pointer

				}); // end am4core.ready() 
			}else if(param=="minSyllable"){
				document.getElementById('chartdiv1').style.display='none';
				document.getElementById('chartdiv2').style.display='block';
				document.getElementById('chartdiv3').style.display='none';
				am4core.ready(function() {
					// Themes begin
					am4core.useTheme(am4themes_animated);
					// Themes end
					// Create chart instance
					var chart3 = am4core.create("chartdiv2", am4charts.XYChart);
					// Add data
					chart3.data = [];
					chart3.data.push({"name":"<%=aDTO.getUserName()%>",
						"title":answerWords[0],
						"value":parseFloat(answerWords[0].length)/parseFloat(answerStartTime[0])});
					for(var i=1;i<answerWords.length;i++){
						console.table(answerWords[i].length)
							chart3.data.push({"name":"<%=aDTO.getUserName()%>",
								"title":answerWords[i], 
								"value": parseFloat(answerWords[i].length)/(parseFloat(answerEndTime[i])-parseFloat(answerStartTime[i]))});
						}

					// Create axes
					var yAxis = chart3.yAxes.push(new am4charts.CategoryAxis());
					yAxis.dataFields.category = "title";
					yAxis.renderer.grid.template.location = 0;
					yAxis.renderer.labels.template.fontSize = 10;
					yAxis.renderer.minGridDistance = 10;

					var xAxis = chart3.xAxes.push(new am4charts.ValueAxis());

					// Create series
					var series3 = chart3.series.push(new am4charts.ColumnSeries());
					series3.dataFields.valueX = "value";
					series3.dataFields.categoryY = "title";
					series3.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
					series3.columns.template.strokeWidth = 0;
					series3.columns.template.adapter.add("fill", function(fill, target) {
					  if (target.dataItem) {
					    switch(target.dataItem.dataContext.name) {
					      case "<%=aDTO.getUserName()%>":
					        return chart3.colors.getIndex(1);
					        break;
					    }
					  }
					  return fill;
					});

					// Add ranges
					function addRange(label, start, end, color) {
					  var range3 = yAxis.axisRanges.create();
					  range3.category = start;
					  range3.endCategory = end;
					  range3.label.text = label;
					  range3.label.disabled = false;
					  range3.label.fill = color;
					  range3.label.location = 0;
					  range3.label.dx = -100;
					  range3.label.dy = 12;
					  range3.label.fontWeight = "bold";
					  range3.label.fontSize = 12;
					  range3.label.horizontalCenter = "left"
					  range3.label.inside = true;
					  
					  range3.grid.stroke = am4core.color("#396478");
					  range3.grid.strokeOpacity = 1;
					  range3.tick.length = 200;
					  range3.tick.disabled = false;
					  range3.tick.strokeOpacity = 0.6;
					  range3.tick.stroke = am4core.color("#396478");
					  range3.tick.location = 0;
					  
					  range3.locations.category = 1;
					}

					addRange("", chart3.data[0], chart3.data[0], chart3.colors.getIndex(1));
					chart3.cursor = new am4charts.XYCursor();

					}); // end am4core.ready()
		}
	}
}
</script>
<script>
am4core.ready(function() {
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	// Create chart instance
	var chart = am4core.create("chartdiv", am4charts.XYChart);
	// Add data
	chart.data = [
	  {
	    "name": "<%=aDTO.getUserName()%>",
	    "title": "음성 인식 정확도",
	    "confidence": <%=aDTO.getConfidence()%>*100
	  }
	];

	// Create axes
	var yAxis = chart.yAxes.push(new am4charts.CategoryAxis());
	yAxis.dataFields.category = "title";
	yAxis.renderer.grid.template.location = 0;
	yAxis.renderer.labels.template.fontSize = 10;
	yAxis.renderer.minGridDistance = 10;

	var xAxis = chart.xAxes.push(new am4charts.ValueAxis());

	// Create series
	var series = chart.series.push(new am4charts.ColumnSeries());
	series.dataFields.valueX = "confidence";
	series.dataFields.categoryY = "title";
	series.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
	series.columns.template.strokeWidth = 0;
	series.columns.template.adapter.add("fill", function(fill, target) {
	  if (target.dataItem) {
	    switch(target.dataItem.dataContext.name) {
	      case "<%=aDTO.getUserName()%>":
	        return chart.colors.getIndex(0);
	        break;
	    }
	  }
	  return fill;
	});

	// Add ranges
	function addRange(label, start, end, color) {
	  var range = yAxis.axisRanges.create();
	  range.category = start;
	  range.endCategory = end;
	  range.label.text = label;
	  range.label.disabled = false;
	  range.label.fill = color;
	  range.label.location = 0;
	  range.label.dx = -100;
	  range.label.dy = 12;
	  range.label.fontWeight = "bold";
	  range.label.fontSize = 12;
	  range.label.horizontalCenter = "left"
	  range.label.inside = true;
	  
	  range.grid.stroke = am4core.color("#396478");
	  range.grid.strokeOpacity = 1;
	  range.tick.length = 200;
	  range.tick.disabled = false;
	  range.tick.strokeOpacity = 0.6;
	  range.tick.stroke = am4core.color("#396478");
	  range.tick.location = 0;
	  
	  range.locations.category = 1;
	}

	addRange("<%=aDTO.getUserName()%>", "음성 인식 정확도", "음성 인식 정확도", chart.colors.getIndex(0));
	chart.cursor = new am4charts.XYCursor();

	}); // end am4core.ready()
</script> 
<script>
const audioFile ={
		<%-- audio : new Audio("<%=StringUtil.reverseSlash(aDTO.getFileNewName())%>") --%>
		audio : new Audio("http://localhost:8080/upload/spcNo-7/userNo-3/20190606103214262-3.wav"),
		play : function(){
			var audioDuration = $(audioFile.audio).on("loadedmetadata",function(){
			})
			console.log(audioDuration[0].duration)
			audioBlockNone.spcContPlay.style.display = 'block';
			audioBlockNone.spcContPause.style.display = 'block';
			audioFile.audio.play()
		},
		pause : function(){
			audioBlockNone.spcContPlay.style.display = 'block';
			audioBlockNone.spcContPause.style.display = 'none';
			audioFile.audio.pause()
		}
}
const audioBlockNone={
		spcContPlay:document.getElementById('spcContPlay'),
		spcContPause:document.getElementById('spcContPause'),
}
</script>

<%-- <script>
am4core.ready(function() {
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	// Create chart instance
	var chart = am4core.create("chartdiv", am4charts.XYChart);
	// Add data
	chart.data = [
	  {
	    "name": "<%=aDTO.getUserName()%>",
	    "title": "음성 인식 정확도",
	    "confidence": <%=aDTO.getConfidence()%>*100
	  }
	];

	// Create axes
	var yAxis = chart.yAxes.push(new am4charts.CategoryAxis());
	yAxis.dataFields.category = "title";
	yAxis.renderer.grid.template.location = 0;
	yAxis.renderer.labels.template.fontSize = 10;
	yAxis.renderer.minGridDistance = 10;

	var xAxis = chart.xAxes.push(new am4charts.ValueAxis());

	// Create series
	var series = chart.series.push(new am4charts.ColumnSeries());
	series.dataFields.valueX = "confidence";
	series.dataFields.categoryY = "title";
	series.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
	series.columns.template.strokeWidth = 0;
	series.columns.template.adapter.add("fill", function(fill, target) {
	  if (target.dataItem) {
	    switch(target.dataItem.dataContext.name) {
	      case "<%=aDTO.getUserName()%>":
	        return chart.colors.getIndex(0);
	        break;
	    }
	  }
	  return fill;
	});

	// Add ranges
	function addRange(label, start, end, color) {
	  var range = yAxis.axisRanges.create();
	  range.category = start;
	  range.endCategory = end;
	  range.label.text = label;
	  range.label.disabled = false;
	  range.label.fill = color;
	  range.label.location = 0;
	  range.label.dx = -100;
	  range.label.dy = 12;
	  range.label.fontWeight = "bold";
	  range.label.fontSize = 12;
	  range.label.horizontalCenter = "left"
	  range.label.inside = true;
	  
	  range.grid.stroke = am4core.color("#396478");
	  range.grid.strokeOpacity = 1;
	  range.tick.length = 200;
	  range.tick.disabled = false;
	  range.tick.strokeOpacity = 0.6;
	  range.tick.stroke = am4core.color("#396478");
	  range.tick.location = 0;
	  
	  range.locations.category = 1;
	}

	addRange("<%=aDTO.getUserName()%>", "음성 인식 정확도", "음성 인식 정확도", chart.colors.getIndex(0));
	chart.cursor = new am4charts.XYCursor();

	}); // end am4core.ready()
</script> 
 <script>
var answerWords = <%=aDTO.getWord()%>;
var answerTerms = <%=aDTO.getTerm()%>;
var answerStartTime = <%=aDTO.getStartTime()%>;
var answerEndTime = <%=aDTO.getEndTime()%>;
am4core.ready(function() {
// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var chart2 = am4core.create("chartdiv2", am4charts.SankeyDiagram);
chart2.hiddenState.properties.opacity = 0; // this creates initial fade-in
chart2.data = [];

for(var i=0;i<answerWords.length-1;i++){
	console.table(answerWords[i]);
	chart2.data.push({from : answerWords[i],to:answerWords[i+1],value:parseFloat(answerTerms[i])})
	
}
console.table(chart2.data)
let hoverState = chart2.links.template.states.create("hover");
hoverState.properties.fillOpacity = 0.6;

chart2.dataFields.fromName = "from";
chart2.dataFields.toName = "to";
chart2.dataFields.value = "value";

// for right-most label to fit
chart2.paddingRight = 30;

// make nodes draggable
var nodeTemplate2 = chart2.nodes.template;
nodeTemplate2.inert = true;
nodeTemplate2.readerTitle = "Drag me!";
nodeTemplate2.showSystemTooltip = true;
nodeTemplate2.width = 20;

// make nodes draggable
var nodeTemplate2 = chart2.nodes.template;
nodeTemplate2.readerTitle = "Click to show/hide or drag to rearrange";
nodeTemplate2.showSystemTooltip = true;
nodeTemplate2.cursorOverStyle = am4core.MouseCursorStyle.pointer

}); // end am4core.ready()
</script>  

<!-- Chart code -->
<script>
am4core.ready(function() {
// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end
var answerWords = <%=aDTO.getWord()%>;
var answerTerms = <%=aDTO.getTerm()%>;
var answerStartTime = <%=aDTO.getStartTime()%>;
var answerEndTime = <%=aDTO.getEndTime()%>;
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);
var data3 = [];
for(var i=0;i<answerWords.length;i++){
	if(i=0){
		data3.push({date:answerWords[i], value: parseFloat(answerWords[i].length)/parseFloat(answerStartTime[0])});
	}
	data3.push({date:answerWords[i], value: parseFloat(answerWords[i].length)/(parseFloat(answerEndTime[i])-parseFloat(answerStartTime[i]))});
}
chart3.data = data3;
console.table(data3)
// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.minGridDistance = 60;

var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());

// Create series
var series3 = chart3.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "value";
series3.dataFields.dateX = "date";
series3.tooltipText = "{value}"

series3.tooltip.pointerOrientation = "vertical";

chart3.cursor = new am4charts.XYCursor();
chart3.cursor.snapToSeries = series3;
chart3.cursor.xAxis = dateAxis;

//chart.scrollbarY = new am4core.Scrollbar();
chart3.scrollbarX = new am4core.Scrollbar();

}); // end am4core.ready()
</script>  --%>

<div id="chartdiv3">
</div>
<div id="chartdiv2">
</div>
<div id="chartdiv">
</div>
</body>
</html>