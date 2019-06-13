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
#chartdiv4 {
  margin:0 auto;
  width:  100%;
  height: 300px;
}
#chartdiv5 {
  margin:0 auto;
  width:  100%;
  height: 300px;
}
#chartdiv45 {
  margin:0 auto;
  width:  100%;
  height: 300px;
}
#chartdiv6{
  margin:0 auto;
  width:  100%;
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
  		<div style="font-size:20px; text-align:center;padding-top:20px;padding-bottom:20px"><%=aDTO.getUserName() %>님의 음성 면접의 변환된 텍스트 정보</div>
		<div>SPEECH TO TEXT => <%=aDTO.getTranscript()%></div>
		<div id="chartdiv"></div>
		<div class="tabSpeech" style="padding-top:20px;padding-bottom:20px;" >
  			<div class="btnRegCss3" onclick="hideShowTab.click('wordTerm')">단어별 Terms(단위 : 초)</div>
  			<div class="btnRegCss3" onclick="hideShowTab.click('minSyllable')">말의 빠르기(단어별)</div>
  			<div class="btnRegCss3" onclick="hideShowTab.click('wordCloud')">워드 클라우드</div>
  		</div>
  		<div id="chartdiv1" style="display:none"></div>
  		<div id="expdiv2" style="display: none; padding-bottom:20px">
	  		<div>말의 빠르기 (단어별)</div>
	  		<div> 계산법 : 단어의 음절/단어별 녹음시간</div>
  		</div>
  		<div id="chartdiv2" style="display:none"></div>
  		<div id="expdiv21" style="display: none; padding-bottom:20px;padding-top:20px">
  			<div>말의 빠르기(문단별)</div>
  			<div> 계산법 : 총 문단의 음절 / 문단 녹음시간</div>
  		</div>
  		<div id="textdiv2" style="display:none"></div>
  		
  		<div id="expdiv3" style="display:none">ETRI API 형태소 분석기에서 명사를 추출한 결과입니다.</div>
  		<div id="chartdiv3" style="display:none"></div>
  	</div>
  	<div id="textdiv45" style="display:none;text-align: center;padding-top:20px;padding-bottom:20px;font-size: 15px">음성 인식 정확도(Google Speech API 기준)</div>
	<div id="chartdiv45" style="width:100%;display:none"></div>
	<div id="textdiv6" style="display:none;text-align: center;padding-top:20px;padding-bottom:20px;font-size: 15px">
	<div>문단의 빠르기</div>
	<div>문단별 음절수 / 문단별 시간</div>
	</div>
	<div id="chartdiv6" style="width:100%;display:none"></div>
  	<div id="spcCompareOther" style="display:none; padding-top:30px;padding-bottom:30px">
  		<div style="width:100%">
  			<div id="expdiv4" style="text-align: center;"><%=aDTO.getUserName()%>님의 워드 클라우드</div>
  			<div id="chartdiv4"></div>
  		</div>
  		<div style="width:100%">
	  		<div id="expdiv5" style="text-align: center;">전체 면접자의 워드 클라우드</div>
	  		<div id="chartdiv5"></div>
	  	</div>
  	</div>
  		<div class="btnRegCss" onclick="pageMove.speech('list')" > 메인 </div>
		<div class="btnRegCss" style="margin-bottom:30px"  onclick="pageMove.answerList('<%=aDTO.getSpeechNo()%>')">질문 답변 목록 보기</div>
 </div>
 <div id="loading">
	<div id="loading-image" >
		<img src="/resources/image/ajax-loader.gif" alt="Loading..." />
		<div> 음성정보를 분석중입니다.</div>
		<div> 최대 몇분이 걸릴수 있습니다.</div>
	</div>
</div>




<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<%@ include file="/WEB-INF/view/speechJsCss.jsp"%>
 	<script>
 	const wordCloud = {
 			wordCloudData:function(){
 				var wordCloudData;
 		  		$.ajax({
 		  			url:'/data/textKonlp.do',
 		  			method:'post',
 		  			async:false,
 		  			data:{
 		  				"openApiURL":"http://aiopen.etri.re.kr:8000/WiseNLU",
 		  				"analysisCode":"ner",
 		  				"text":"<%=aDTO.getTranscript()%>"
 		  			},
 		  			success:function(data){
 		  				wordCloudData=data;
 		  			}
 		  		});
 		  		return wordCloudData;
 			},
 			wordCloudDataAll:function(){
 				var wordCloudDataAll;
 		  		$.ajax({
 		  			url:'/data/textKonlpAll.do',
 		  			method:'post',
 		  			async:false,
 		  			data:{
 		  				"openApiURL":"http://aiopen.etri.re.kr:8000/WiseNLU",
 		  				"analysisCode":"ner",
 		  				"spcNo":"<%=aDTO.getSpeechNo()%>"
 		  			},
 		  			success:function(data){
 		  				wordCloudDataAll=data;
 		  			}
 		  		});
 		  		return wordCloudDataAll;
 			}
 	}
 	
</script>
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
				document.getElementById('spcCompareOther').style.display='none';
				document.getElementById('textdiv45').style.display='none';
				document.getElementById('chartdiv45').style.display='none';
				document.getElementById('chartdiv6').style.display='none';
			}else if(param=="wordTerm"){
				document.getElementById('chartdiv1').style.display='block';
				document.getElementById('chartdiv2').style.display='none';
				document.getElementById('chartdiv3').style.display='none';
				document.getElementById('textdiv2').style.display='none';
				document.getElementById('expdiv2').style.display='none';
				document.getElementById('expdiv21').style.display='none';
				document.getElementById('expdiv3').style.display='none';
				document.getElementById('expdiv4').style.display='none';
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
				document.getElementById('textdiv2').style.display='block';
				document.getElementById('expdiv2').style.display='block';
				document.getElementById('expdiv21').style.display='block';
				document.getElementById('expdiv3').style.display='none';
				document.getElementById('expdiv4').style.display='none';
				document.getElementById('textdiv45').style.display='none';
				var cont2="";
				var wordTotalLength2=0;
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
					cont2+="<div class='padLR' style='display:flex;justify-content:space-between;text-align:center;'>";
					cont2+="<div style='border:1px solid #6794dc;width: 50%; padding-top:10px;padding-bottom:10px'>"+answerWords[0]+"</div>";
					cont2+="<div style='border:1px solid #6794dc;width: 50%;padding-top:10px;padding-bottom:10px'>"+parseFloat(answerTerms[0]).toFixed(4)+"초</div>"	;
					cont2+="</div>";
				
					wordTotalLength2+=answerWords[0].length;
					for(var i=1;i<answerWords.length;i++){
							chart3.data.push({"name":"<%=aDTO.getUserName()%>",
								"title":answerWords[i], 
								"value": parseFloat(answerWords[i].length).toFixed(4)/(parseFloat(answerEndTime[i]).toFixed(4)-parseFloat(answerStartTime[i]).toFixed(4))});
						cont2+="<div class='padLR' style='display:flex;justify-content:space-between;text-align:center;'>";
						cont2+="<div style='border:1px solid #6794dc;width: 50%;padding-top:10px;padding-bottom:10px'>"+answerWords[i]+"</div>";
						cont2+="<div style='border:1px solid #6794dc;width: 50%;padding-top:10px;padding-bottom:10px'>"+parseFloat(answerTerms[i]).toFixed(4)+"초</div>";
						cont2+="</div>";
						wordTotalLength2+=parseInt(answerWords[i].length);
					}
					
					cont2+="<div class='padLR' style='display:flex;justify-content:space-between;text-align:center;'>"
					cont2+="<div style='border:1px solid #6794dc; width:50%;padding-top:10px;padding-bottom:10px'> 말의 빠르기(문단별)</div>"
					cont2+="<div style='border:1px solid #6794dc;width:50%;padding-top:10px;padding-bottom:10px'>"+(parseFloat(wordTotalLength2)/parseFloat(answerEndTime[answerEndTime.length-1])).toFixed(4)+"</div>";
					cont2+="</div>"
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
				document.getElementById('textdiv2').innerHTML=cont2;
		}else if(param=="wordCloud"){
			document.getElementById('chartdiv1').style.display='none';
			document.getElementById('chartdiv2').style.display='none';
			document.getElementById('chartdiv3').style.display='block';
			document.getElementById('textdiv2').style.display='none';
			document.getElementById('expdiv2').style.display='none';
			document.getElementById('expdiv21').style.display='none';
			document.getElementById('expdiv3').style.display='block';
			document.getElementById('expdiv4').style.display='none';
			document.getElementById('textdiv45').style.display='none';
			am4core.ready(function() {
				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end
				
				var chart4 = am4core.create("chartdiv3", am4plugins_wordCloud.WordCloud);
				chart4.fontFamily = "Courier New";
				var series4 = chart4.series.push(new am4plugins_wordCloud.WordCloudSeries());
				series4.randomness = 0.1;
				series4.rotationThreshold = 0.5;
				
				series4.data = wordCloud.wordCloudData();
				series4.dataFields.word = "tag";
				series4.dataFields.value = "weight";
				
				series4.heatRules.push({
				 "target": series4.labels.template,
				 "property": "fill",
				 "min": am4core.color("#0000CC"),
				 "max": am4core.color("#CC00CC"),
				 "dataField": "value"
				});
				
				series4.labels.template.tooltipText = "{word}: {value}";
				
				var hoverState4 = series4.labels.template.states.create("hover");
				hoverState4.properties.fill = am4core.color("#FF0000");
				
				}); // end am4core.ready()
			}else if(param=="otherSpcCompare"){
				document.getElementById('spcContentAudio').style.display='none';
				document.getElementById('spcContentAnalysis').style.display='none';
				document.getElementById('spcCompareOther').style.display='flex';
				document.getElementById('expdiv4').style.display='block';
				document.getElementById('chartdiv45').style.display='block';
				document.getElementById('textdiv45').style.display='block';
				document.getElementById('chartdiv6').style.display='block';
				document.getElementById('textdiv6').style.display='block';
				//////////////////////
				am4core.ready(function() {

				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end
			
				var chart5 = am4core.create("chartdiv4", am4plugins_wordCloud.WordCloud);
				chart5.fontFamily = "Courier New";
				var series5 = chart5.series.push(new am4plugins_wordCloud.WordCloudSeries());
				series5.randomness = 0.1;
				series5.rotationThreshold = 0.5;
				
				series5.data = wordCloud.wordCloudData();
				series5.dataFields.word = "tag";
				series5.dataFields.value = "weight";
				
				series5.heatRules.push({
				 "target": series5.labels.template,
				 "property": "fill",
				 "min": am4core.color("#0000CC"),
				 "max": am4core.color("#CC00CC"),
				 "dataField": "value"
				});
				
				series5.labels.template.tooltipText = "{word}: {value}";
				
				var hoverState5 = series5.labels.template.states.create("hover");
				hoverState5.properties.fill = am4core.color("#FF0000");
				
				}); // end am4core.ready()
				////////////////////
				am4core.ready(function() {

				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end
			
				var chart6 = am4core.create("chartdiv5", am4plugins_wordCloud.WordCloud);
				chart6.fontFamily = "Courier New";
				var series6 = chart6.series.push(new am4plugins_wordCloud.WordCloudSeries());
				series6.randomness = 0.1;
				series6.rotationThreshold = 0.5;
				var local=wordCloud.wordCloudDataAll();
				var localdata=[]
				for(var i=0; i<local.length;i++){
					localdata.push({"tag":local[i].tag,"weight":local[i].weight})
				}
				series6.data = localdata;
				series6.dataFields.word = "tag";
				series6.dataFields.value = "weight";
				
				series6.heatRules.push({
				 "target": series6.labels.template,
				 "property": "fill",
				 "min": am4core.color("#0000CC"),
				 "max": am4core.color("#CC00CC"),
				 "dataField": "value"
				});
				
				series6.labels.template.tooltipText = "{word}: {value}";
				
				var hoverState6 = series6.labels.template.states.create("hover");
				hoverState6.properties.fill = am4core.color("#FF0000");
				
				}); // end am4core.ready()
				/////////////////////
				am4core.ready(function() {
				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end
				// Create chart instance
				var chart45 = am4core.create("chartdiv45", am4charts.XYChart);
				// Add data
				const dataWordAvg=wordCloud.wordCloudDataAll();
				chart45.data = [
				  {
				    "name": "<%=aDTO.getUserName()%>",
				    "title": "음성 인식 정확도",
				    "confidence": <%=aDTO.getConfidence()%>*100
				  },
				  {
					  "name":"전체 사용자",
					  "title":"음성 인식 정확도 평균",
					  "confidence": dataWordAvg[0].resultConf*100
				  }
				];
			
				// Create axes
				var yAxis = chart45.yAxes.push(new am4charts.CategoryAxis());
				yAxis.dataFields.category = "title";
				yAxis.renderer.grid.template.location = 0;
				yAxis.renderer.labels.template.fontSize = 10;
				yAxis.renderer.minGridDistance = 10;
			
				var xAxis = chart45.xAxes.push(new am4charts.ValueAxis());
			
				// Create series
				var series45 = chart45.series.push(new am4charts.ColumnSeries());
				series45.dataFields.valueX = "confidence";
				series45.dataFields.categoryY = "title";
				series45.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
				series45.columns.template.strokeWidth = 0;
				series45.columns.template.adapter.add("fill", function(fill, target) {
				  if (target.dataItem) {
				    switch(target.dataItem.dataContext.name) {
				      case "<%=aDTO.getUserName()%>":
				        return chart45.colors.getIndex(0);
				        break;
				      case "전체 사용자":
					    return chart45.colors.getIndex(1);
					    break;
				    }
				  }
				  return fill;
				});
			
				// Add ranges
				function addRange45(label, start, end, color) {
				  var range45 = yAxis.axisRanges.create();
				  range45.category = start;
				  range45.endCategory = end;
				  range45.label.text = label;
				  range45.label.disabled = false;
				  range45.label.fill = color;
				  range45.label.location = 0;
				  range45.label.dx = -100;
				  range45.label.dy = 12;
				  range45.label.fontWeight = "bold";
				  range45.label.fontSize = 12;
				  range45.label.horizontalCenter = "left"
				  range45.label.inside = true;
				  
				  range45.grid.stroke = am4core.color("#396478");
				  range45.grid.strokeOpacity = 1;
				  range45.tick.length = 200;
				  range45.tick.disabled = false;
				  range45.tick.strokeOpacity = 0.6;
				  range45.tick.stroke = am4core.color("#396478");
				  range45.tick.location = 0;
				  
				  range45.locations.category = 1;
				}
			
				addRange45("<%=aDTO.getUserName()%>", "음성 인식 정확도", "음성 인식 정확도", chart45.colors.getIndex(0));
				addRange45("전체 사용자", "음성 인식 정확도 평균", "음성 인식 정확도 평균", chart45.colors.getIndex(1));
				chart45.cursor = new am4charts.XYCursor();
			
				}); // end am4core.ready()
				////////////////////
			am4core.ready(function() {
				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end
				// Create chart instance
				var chart7 = am4core.create("chartdiv6", am4charts.XYChart);
				// Add data
				const dataWordAvg2=wordCloud.wordCloudDataAll();
				var wordTotalLength3=0;
				for(var i=1;i<answerWords.length;i++){
					wordTotalLength3+=parseInt(answerWords[i].length);
				}
				chart7.data = [
				  {
				    "name": "<%=aDTO.getUserName()%>",
				    "title": "문단 빠르기",
				    "confidence": wordTotalLength3/parseFloat(answerEndTime[answerEndTime.length-1]).toFixed(4)
				  },
				  {
					  "name":"전체 사용자",
					  "title":"전체 문단 빠르기 평균",
					  "confidence": dataWordAvg2[0].resultCount
				  }
				];
			
				// Create axes
				var yAxis = chart7.yAxes.push(new am4charts.CategoryAxis());
				yAxis.dataFields.category = "title";
				yAxis.renderer.grid.template.location = 0;
				yAxis.renderer.labels.template.fontSize = 10;
				yAxis.renderer.minGridDistance = 10;
			
				var xAxis = chart7.xAxes.push(new am4charts.ValueAxis());
			
				// Create series
				var series7 = chart7.series.push(new am4charts.ColumnSeries());
				series7.dataFields.valueX = "confidence";
				series7.dataFields.categoryY = "title";
				series7.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
				series7.columns.template.strokeWidth = 0;
				series7.columns.template.adapter.add("fill", function(fill, target) {
				  if (target.dataItem) {
				    switch(target.dataItem.dataContext.name) {
				      case "<%=aDTO.getUserName()%>":
				        return chart7.colors.getIndex(0);
				        break;
				      case "전체 사용자":
					    return chart7.colors.getIndex(1);
					    break;
				    }
				  }
				  return fill;
				});
			
				// Add ranges
				function addRange7(label, start, end, color) {
				  var range7 = yAxis.axisRanges.create();
				  range7.category = start;
				  range7.endCategory = end;
				  range7.label.text = label;
				  range7.label.disabled = false;
				  range7.label.fill = color;
				  range7.label.location = 0;
				  range7.label.dx = -100;
				  range7.label.dy = 12;
				  range7.label.fontWeight = "bold";
				  range7.label.fontSize = 12;
				  range7.label.horizontalCenter = "left"
				  range7.label.inside = true;
				  
				  range7.grid.stroke = am4core.color("#396478");
				  range7.grid.strokeOpacity = 1;
				  range7.tick.length = 200;
				  range7.tick.disabled = false;
				  range7.tick.strokeOpacity = 0.6;
				  range7.tick.stroke = am4core.color("#396478");
				  range7.tick.location = 0;
				  
				  range7.locations.category = 1;
				}
			
				addRange7("<%=aDTO.getUserName()%>", "문단 빠르기", "문단 빠르기", chart7.colors.getIndex(0));
				addRange7("전체 사용자", "전체 문단 빠르기 평균", "전체 문단 빠르기 평균", chart7.colors.getIndex(1));
				chart7.cursor = new am4charts.XYCursor();
			
				});
				
				////////////////////
				
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



</script>

<script>
const audioFile ={
	
		<%-- audio : new Audio("<%=StringUtil.reverseSlash(aDTO.getFileNewName())%>") --%>
		audio : new Audio("<%=aDTO.getFileNewName().replaceAll("/usr/local/apache-tomcat-8.0.36/webapps/ROOT", "http://13.125.125.20") %>"),
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

</body>
</html>