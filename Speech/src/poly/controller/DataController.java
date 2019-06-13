package poly.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import poly.dto.AnswerDTO;
import poly.service.ISpeechService;
@RequestMapping("/data")
@Controller
public class DataController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name="SpeechService")
	private ISpeechService speechService;
	@RequestMapping("/textKonlp")
	public @ResponseBody List<HashMap<String, Object>>testKonlp(HttpServletRequest req) throws Exception {
		String openApiURL = req.getParameter("openApiURL");
	    String accessKey = "14ee6f69-451b-4555-9807-a0d84683c6b5"; // 발급받은 API Key
	    String analysisCode = req.getParameter("analysisCode"); // 언어 분석 코드
	    String text = req.getParameter("text");  // 분석할 텍스트 데이터
	    
	    Gson gson = new Gson();

	    Map<String, Object> request = new HashMap<>();
	    Map<String, String> argument = new HashMap<>();

	    
	    argument.put("analysis_code", analysisCode);
	    argument.put("text", text);

	    request.put("access_key", accessKey);
	    request.put("argument", argument);

	    URL url;
	    Integer responseCode = null;
	    String responBodyJson = null;
	    Map<String, Object> responeBody = null;
	    Map<String, Object> returnObject;
	    List<Map> sentences;
	    Map<String, Morpheme> morphemesMap = new HashMap<String, Morpheme>();
	    Map<String, NameEntity> nameEntitiesMap = new HashMap<String, NameEntity>();
	    List<Morpheme> morphemes = null;
	    List<NameEntity> nameEntities = null;
	    List<HashMap<String, Object>> mList= new ArrayList<>();
	    try {
	    	 url = new URL(openApiURL);
	         HttpURLConnection con = (HttpURLConnection) url.openConnection();
	         con.setRequestMethod("POST");
	         con.setDoOutput(true);

	         DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	         wr.write(gson.toJson(request).getBytes("UTF-8"));
	         wr.flush();
	         wr.close();

	         responseCode = con.getResponseCode();
	         InputStream is = con.getInputStream();
	         BufferedReader br = new BufferedReader(new InputStreamReader(is));
	         StringBuffer sb = new StringBuffer();

	         String inputLine = "";
	         while ((inputLine = br.readLine()) != null) {
	             sb.append(inputLine);
	         }
	         responBodyJson = sb.toString();

	         // http 요청 오류 시 처리
	         if ( responseCode != 200 ) {
	             // 오류 내용 출력
	             System.out.println("[error] " + responBodyJson);
	             return null;
	         }

	         responeBody = gson.fromJson(responBodyJson, Map.class);
	         Integer result = ((Double) responeBody.get("result")).intValue();
	      

	         // 분석 요청 오류 시 처리
	         if ( result != 0 ) {

	             // 오류 내용 출력
	             System.out.println("[error] " + responeBody.get("result"));
	             return null;
	         }

	         // 분석 결과 활용
	         returnObject = (Map<String, Object>) responeBody.get("return_object");
	         sentences = (List<Map>) returnObject.get("sentence");

	         for( Map<String, Object> sentence : sentences ) {
	             // 형태소 분석기 결과 수집 및 정렬
	             List<Map<String, Object>> morphologicalAnalysisResult = (List<Map<String, Object>>) sentence.get("morp");
	             for( Map<String, Object> morphemeInfo : morphologicalAnalysisResult ) {
	                 String lemma = (String) morphemeInfo.get("lemma");
	                 Morpheme morpheme = morphemesMap.get(lemma);
	                 if ( morpheme == null ) {
	                     morpheme = new Morpheme(lemma, (String) morphemeInfo.get("type"), 1);
	                     morphemesMap.put(lemma, morpheme);
	                 } else {
	                     morpheme.count = morpheme.count + 1;
	                 }
	             }

	             // 개체명 분석 결과 수집 및 정렬
	             List<Map<String, Object>> nameEntityRecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
	             for( Map<String, Object> nameEntityInfo : nameEntityRecognitionResult ) {
	                 String name = (String) nameEntityInfo.get("text");
	                 NameEntity nameEntity = nameEntitiesMap.get(name);
	                 if ( nameEntity == null ) {
	                     nameEntity = new NameEntity(name, (String) nameEntityInfo.get("type"), 1);
	                     nameEntitiesMap.put(name, nameEntity);
	                 } else {
	                     nameEntity.count = nameEntity.count + 1;
	                 }
	             }
	         }
	         if ( 0 < morphemesMap.size() ) {
	             morphemes = new ArrayList<Morpheme>(morphemesMap.values());
	             morphemes.sort( (morpheme1, morpheme2) -> {
	                 return morpheme2.count - morpheme1.count;
	             });
	         }

	         if ( 0 < nameEntitiesMap.size() ) {
	             nameEntities = new ArrayList<NameEntity>(nameEntitiesMap.values());
	             nameEntities.sort( (nameEntity1, nameEntity2) -> {
	                 return nameEntity2.count - nameEntity1.count;
	             });
	         }

	         morphemes
	             .stream()
	             .filter(morpheme -> {
	                 return morpheme.type.equals("NNG") ||
	                         morpheme.type.equals("NNP") ||
	                         morpheme.type.equals("NNB");
	             })
	             .forEach(morpheme -> {
	            	 HashMap<String, Object> hMap = new HashMap<>();
	            	 hMap.put("tag", morpheme.text);
	            	 hMap.put("weight",morpheme.count);
	            	 mList.add(hMap);
	            	 hMap=null;
	             });
	    } catch (MalformedURLException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	   
		return mList;

	}
	@RequestMapping("/textKonlpAll")
	public @ResponseBody List<HashMap<String, Object>>testKonlpAll(HttpServletRequest req) throws Exception {
		String openApiURL = req.getParameter("openApiURL");
	    String accessKey = "14ee6f69-451b-4555-9807-a0d84683c6b5"; // 발급받은 API Key
	    String analysisCode = req.getParameter("analysisCode"); // 언어 분석 코드
	    String spcNo = req.getParameter("spcNo");  // 분석할 텍스트 데이터
	    String text="";
	    String text2="";
	    String[] text3;
	    float resultCount=0;
	    float textCount=0;
	    float term=0;
	    float resultConf=0;
	    List<AnswerDTO> aList = new ArrayList<>();
	    AnswerDTO aDTO = new AnswerDTO();
	    aDTO.setSpeechNo(spcNo);
	    aList = speechService.getAnswerList2(aDTO);
	   
	    for(int i=0;i<aList.size();i++) {
	    	text+=aList.get(i).getTranscript()+".";
	    	resultConf+=Float.parseFloat(aList.get(i).getConfidence());
	    }
	    //한 문단씩 말의 빠르기
	    for(int i=0;i<aList.size();i++) {
	    	 text2=aList.get(i).getWord().substring(1,aList.get(i).getWord().length()-1).replace("\"", "").replace(",", "");
	    	 textCount=text2.length();
	    	 text3=aList.get(i).getEndTime().substring(1,aList.get(i).getEndTime().length()-1).replace("\"", "").split(",");
	    	resultCount+=textCount/Float.parseFloat(text3[text3.length-1]);
	    }
	    
	    resultCount =(float) resultCount/(float) aList.size();
	    String str2 = String.format("%.4f", resultCount);
	    resultConf=(float)resultConf/(float)aList.size();
	    String str = String.format("%.4f", resultConf);
	    
	    
	    Gson gson = new Gson();

	    Map<String, Object> request = new HashMap<>();
	    Map<String, String> argument = new HashMap<>();
	    
	    argument.put("analysis_code", analysisCode);
	    argument.put("text", text);

	    request.put("access_key", accessKey);
	    request.put("argument", argument);

	    URL url;
	    Integer responseCode = null;
	    String responBodyJson = null;
	    Map<String, Object> responeBody = null;
	    Map<String, Object> returnObject;
	    List<Map> sentences;
	    Map<String, Morpheme> morphemesMap = new HashMap<String, Morpheme>();
	    Map<String, NameEntity> nameEntitiesMap = new HashMap<String, NameEntity>();
	    List<Morpheme> morphemes = null;
	    List<NameEntity> nameEntities = null;
	    List<HashMap<String, Object>> mList= new ArrayList<>();
	    try {
	    	 url = new URL(openApiURL);
	         HttpURLConnection con = (HttpURLConnection) url.openConnection();
	         con.setRequestMethod("POST");
	         con.setDoOutput(true);

	         DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	         wr.write(gson.toJson(request).getBytes("UTF-8"));
	         wr.flush();
	         wr.close();

	         responseCode = con.getResponseCode();
	         InputStream is = con.getInputStream();
	         BufferedReader br = new BufferedReader(new InputStreamReader(is));
	         StringBuffer sb = new StringBuffer();

	         String inputLine = "";
	         while ((inputLine = br.readLine()) != null) {
	             sb.append(inputLine);
	         }
	         responBodyJson = sb.toString();

	         // http 요청 오류 시 처리
	         if ( responseCode != 200 ) {
	             // 오류 내용 출력
	             System.out.println("[error] " + responBodyJson);
	             return null;
	         }

	         responeBody = gson.fromJson(responBodyJson, Map.class);
	         Integer result = ((Double) responeBody.get("result")).intValue();
	      

	         // 분석 요청 오류 시 처리
	         if ( result != 0 ) {

	             // 오류 내용 출력
	             System.out.println("[error] " + responeBody.get("result"));
	             return null;
	         }

	         // 분석 결과 활용
	         returnObject = (Map<String, Object>) responeBody.get("return_object");
	         sentences = (List<Map>) returnObject.get("sentence");

	         for( Map<String, Object> sentence : sentences ) {
	             // 형태소 분석기 결과 수집 및 정렬
	             List<Map<String, Object>> morphologicalAnalysisResult = (List<Map<String, Object>>) sentence.get("morp");
	             for( Map<String, Object> morphemeInfo : morphologicalAnalysisResult ) {
	                 String lemma = (String) morphemeInfo.get("lemma");
	                 Morpheme morpheme = morphemesMap.get(lemma);
	                 if ( morpheme == null ) {
	                     morpheme = new Morpheme(lemma, (String) morphemeInfo.get("type"), 1);
	                     morphemesMap.put(lemma, morpheme);
	                 } else {
	                     morpheme.count = morpheme.count + 1;
	                 }
	             }

	             // 개체명 분석 결과 수집 및 정렬
	             List<Map<String, Object>> nameEntityRecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
	             for( Map<String, Object> nameEntityInfo : nameEntityRecognitionResult ) {
	                 String name = (String) nameEntityInfo.get("text");
	                 NameEntity nameEntity = nameEntitiesMap.get(name);
	                 if ( nameEntity == null ) {
	                     nameEntity = new NameEntity(name, (String) nameEntityInfo.get("type"), 1);
	                     nameEntitiesMap.put(name, nameEntity);
	                 } else {
	                     nameEntity.count = nameEntity.count + 1;
	                 }
	             }
	         }
	         if ( 0 < morphemesMap.size() ) {
	             morphemes = new ArrayList<Morpheme>(morphemesMap.values());
	             morphemes.sort( (morpheme1, morpheme2) -> {
	                 return morpheme2.count - morpheme1.count;
	             });
	         }

	         if ( 0 < nameEntitiesMap.size() ) {
	             nameEntities = new ArrayList<NameEntity>(nameEntitiesMap.values());
	             nameEntities.sort( (nameEntity1, nameEntity2) -> {
	                 return nameEntity2.count - nameEntity1.count;
	             });
	         }

	         morphemes
	             .stream()
	             .filter(morpheme -> {
	                 return morpheme.type.equals("NNG") ||
	                         morpheme.type.equals("NNP") ||
	                         morpheme.type.equals("NNB");
	             })
	             .forEach(morpheme -> {
	            	 HashMap<String, Object> hMap = new HashMap<>();
	            	 hMap.put("tag", morpheme.text);
	            	 hMap.put("weight",morpheme.count);
	            	 hMap.put("resultConf",str);
	            	 hMap.put("resultCount",str2);
	            	 mList.add(hMap);
	            	 hMap=null;
	             });
	        
	    } catch (MalformedURLException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	   
		return mList;

	}
	 static public class Morpheme {
	    
			final String text;
	        final String type;
	        Integer count;
	        public Morpheme (String text, String type, Integer count) {
	            this.text = text;
	            this.type = type;
	            this.count = count;
	        }
	    }
	    static public class NameEntity {
	        final String text;
	        final String type;
	        Integer count;
	        public NameEntity (String text, String type, Integer count) {
	            this.text = text;
	            this.type = type;
	            this.count = count;
	        }
	    }
	
}


