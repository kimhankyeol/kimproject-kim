package poly.controller;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import poly.dto.AnswerDTO;
import poly.dto.FileDTO;
import poly.dto.SpeechDTO;
import poly.service.ISpeechService;
import poly.util.CmmUtil;
import poly.util.FileUtil;
import poly.util.StringUtil;


@Controller
@RequestMapping("/speech") 
public class SpeechController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="SpeechService")
	private ISpeechService speechService;

	@RequestMapping(value="/list")
	public String main(HttpSession session) throws Exception{
		if(session.getAttribute("userName")==null) {
			return "/home";
		}
		return "/speech/mainSelectList";
	}
	@RequestMapping(value="/mySpeechQuestion")
	public String mySpcQuestion(HttpSession session,Model model) throws Exception{
		
		if(session.getAttribute("userNo")==null) {
			String msg , url ;
			msg="로그인 해주세요";
			url="/home.do";
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			return "/alert";
		}
		
		String userNo = session.getAttribute("userNo").toString();
		SpeechDTO sDTO = new SpeechDTO();
		sDTO.setRegno(userNo);
		List<SpeechDTO> sList = new ArrayList<>();
		sList =	speechService.getMySpeechList(sDTO);
		model.addAttribute("sList",sList);
		return "/speech/mySpeechQuestion";
	}
	@RequestMapping(value="/jobCtgSpeech")
	public String jobCtgSpeech(Model model) throws Exception {
		List<AnswerDTO> sList = new ArrayList<>();
		sList = speechService.getSpeechList();
		model.addAttribute("sList",sList);
		return "/speech/jobCtgSpeech";
	}
	@RequestMapping(value="/insertView")
	public String insertView() throws Exception {
		return "/speech/insertView";
	}
	@RequestMapping(value="/speechInsertProc")
	public String speechInsertProc(@RequestParam Map<String,String> map, @RequestParam(value="spcJobTag") String[] spcJobTag , Model model ,HttpServletRequest req) throws Exception{
		int result = speechService.insertSpeech(map,spcJobTag);
		String msg , url ;
		if(result == 1) {
			msg="등록되었습니다.";
			url="/speech/list.do";
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
		}
		return "/alert";
	}
	@RequestMapping(value="/detail")
	public String getSpeechDetail(HttpServletRequest req,Model model) throws Exception{
		String webType = CmmUtil.nvl(req.getParameter("webType"));
		log.info(webType);
		String spcNo=CmmUtil.nvl(req.getParameter("spcNo"));
		SpeechDTO sDTO = new SpeechDTO();
		sDTO.setSpeechNo(spcNo);
		sDTO = speechService.getSpeechDetail(sDTO);
		model.addAttribute("webType",webType);
		model.addAttribute("sDTO",sDTO);
		sDTO=null;
		return "/speech/speechDetail";
	}
	@RequestMapping(value="/insertRecord",method=RequestMethod.POST)
	public @ResponseBody HashMap<String,Object> insertRecord(HttpServletRequest req,HttpSession session,Model model) throws Exception{
		String spcNo = req.getParameter("spcNo");
		String userNo = CmmUtil.nvl(session.getAttribute("userNo").toString());
		String path = req.getSession().getServletContext().getRealPath("/upload/spcNo-"+spcNo+"/userNo-"+userNo+"/");
		SpeechDTO sDTO = new SpeechDTO();
		FileDTO fDTO = new FileDTO();
		String[] fileArray; 
		int result;
		HashMap<String,Object> hMap = new HashMap<>();
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		if(req.getParameter("webType").toString().equals("p")){
			fileArray = FileUtil.fileNewString("webRecorderFile",mhsr,path,userNo);
			sDTO.setSpeechNo(spcNo);
			sDTO.setRegno(session.getAttribute("userNo").toString());
			fDTO.setFileOriginName(mhsr.getFile("webRecorderFile").getOriginalFilename());
			fDTO.setFileNewName(fileArray[0]);
			fDTO.setFilePath(path);
			hMap.put("sDTO", sDTO);
			hMap.put("fDTO", fDTO);
			result = speechService.insertFileSpeech(hMap);
			log.info(result);
			String url;
			if(result==1) {
				File newFile =new File(fileArray[0]);
				log.info(fileArray[0]);
				if(!newFile.isDirectory()) {
					newFile.mkdirs();
				}
				mhsr.getFile("webRecorderFile").transferTo(newFile);
				url="/speech/changeBlob.do";
			}else{
				url="/speech/answerList.do?spcNo="+spcNo;
			}
			hMap.put("url",url);
			
		}else {
			fileArray = FileUtil.fileNewString("mobileRecorderFile",mhsr,path,userNo);
			sDTO.setSpeechNo(spcNo);
			sDTO.setRegno(session.getAttribute("userNo").toString());
			fDTO.setFileOriginName(mhsr.getFile("mobileRecorderFile").getOriginalFilename());
			fDTO.setFileNewName(fileArray[0]);
			fDTO.setFilePath(path);
			hMap.put("sDTO", sDTO);
			hMap.put("fDTO", fDTO);
			result = speechService.insertFileSpeech(hMap);
			String url;
			if(result==1) {
				File newFile =new File(fileArray[0]);
				log.info(fileArray[0]);
				if(!newFile.isDirectory()) {
					newFile.mkdirs();
				}
				mhsr.getFile("webRecorderFile").transferTo(newFile);
				url="/speech/changeBlob.do";
			}else{
				url="/speech/answerList.do?spcNo="+spcNo;
			}
			hMap.put("url",url);
		}
		return hMap;
	
	}
	@RequestMapping(value="/changeBlob")
	public @ResponseBody String getChangeBlob(HttpServletRequest req) throws Exception{
		String fileNo = req.getParameter("fileNo");
		AnswerDTO aDTO = new AnswerDTO();
		aDTO.setFileNo(fileNo);
		String filePath = speechService.getFileInfo(aDTO);
		log.info(filePath);
		return FileUtil.audioToBuffer(filePath);
	}
	@RequestMapping(value="/speechDataInsert")
	public @ResponseBody HashMap<String,String> insertSpeechData(HttpServletRequest req,Model model) throws Exception{
		String transcript = req.getParameter("transcript");
		String confidence = req.getParameter("confidence");
		String fileNo = req.getParameter("fileNo");
		String spcNo = req.getParameter("spcNo");
		String word = req.getParameter("word");
		String startTime = req.getParameter("startTime");
		String endTime = req.getParameter("endTime");
		String term = req.getParameter("term");
		String speechNo = req.getParameter("spcNo");
		HashMap<String,String> hMap = new HashMap<>();
		AnswerDTO aDTO = new AnswerDTO();
		aDTO.setTranscript(transcript);
		aDTO.setConfidence(confidence);
		aDTO.setFileNo(fileNo);
		aDTO.setWord(word);
		aDTO.setTerm(term);
		aDTO.setStartTime(startTime);
		aDTO.setEndTime(endTime);
		aDTO.setSpeechNo(speechNo);
		int result = speechService.insertSpeechData(aDTO);
		String msg,url;
		if(result==1) {
			msg="면접 답이 등록되었습니다.";
			url="/speech/answerList.do?spcNo="+spcNo;
		}else {
			msg="면접 답이 실패되었습니다.";
			url="/speech/answerList.do?spcNo="+spcNo;
		}
		hMap.put("msg",msg);
		hMap.put("url",url);
		return hMap;
	}
	@RequestMapping("/answerList")
	public String getAnswerList(HttpServletRequest req,Model model) throws Exception{
		String spcNo=req.getParameter("spcNo");
		List<AnswerDTO> sList=new ArrayList<>(); 
		AnswerDTO aDTO = new AnswerDTO();
		SpeechDTO sDTO = new SpeechDTO();
		aDTO.setSpeechNo(spcNo);
		sList = speechService.getAnswerList(aDTO);
		log.info(sList.size());
		if(sList.size()==0) {
			sDTO.setSpeechNo(spcNo);
			sDTO=speechService.getSpeechDetail(sDTO);
			aDTO.setFileNo("nFile");
			aDTO.setSpcJobTitle(sDTO.getSpcJobTitle());
			sList.add(aDTO);
			model.addAttribute("sList",sList);
		}else {
			model.addAttribute("sList",sList);
		}
		sList=null;
		aDTO=null;
		sDTO=null;
	
		return "/speech/speechAnswerList";
	}
	@RequestMapping("/answerDetail")
	public String getAnswerDetail(HttpServletRequest req,Model model) throws Exception{
		String fileNo = req.getParameter("fileNo");
		AnswerDTO aDTO = new AnswerDTO();
		aDTO.setFileNo(fileNo);
		aDTO = speechService.getAnswerDetail(aDTO);
		model.addAttribute("aDTO",aDTO);
		return "/speech/answerDetail";
	}
	@RequestMapping("/delete")
	public String deleteSpeech(@RequestParam(value="spcNoArr",required=true) List<String> spcNoArr,Model model) throws Exception{
		List<AnswerDTO> aList = new ArrayList<>();
		AnswerDTO aDTO = new AnswerDTO();
		int result1 = 0;
		int result2 = 0;
		int result3 = 0;
		int result4 = 0;
		for(int i = 0 ; i<spcNoArr.size();i++) {
			aDTO.setSpeechNo(spcNoArr.get(i));
			aList=speechService.getAnswerList2(aDTO);
			for(int j=0;j<aList.size();j++) {
				File file = new File(aList.get(j).getFileNewName());
				file.delete();
			}
			 result1 = speechService.deleteSpeech(aDTO);
			 result2 = speechService.deleteAnswer(aDTO);
			 result3 = speechService.deleteFile(aDTO);
			 result4 = result1+result2+result3;
			
		}
		String msg,url;
		if(result4>0){
			 msg="삭제 되었습니다.";
			 url="/speech/mySpeechQuestion.do";
		
		}else {
			 msg="삭제 되었습니다.";
			 url="/speech/mySpeechQuestion.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
	return "/alert";	
	}
	
	
}
