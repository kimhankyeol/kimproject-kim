package poly.controller;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.FileDTO;
import poly.dto.SpeechDTO;
import poly.service.ISpeechService;
import poly.util.CmmUtil;
import poly.util.FileUtil;


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
		List<SpeechDTO> sList = new ArrayList<>();
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
	public @ResponseBody String insertRecord(HttpServletRequest req,HttpSession session,Model model) throws Exception{
		String spcNo = req.getParameter("spcNo");
		String path = req.getSession().getServletContext().getRealPath("/upload/spcNo"+spcNo+"/userNo"+session.getAttribute("userNo").toString()+"/");
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		String[] fileArray = FileUtil.fileNewString("webRecorderFile",mhsr,path);
		SpeechDTO sDTO = new SpeechDTO();
		FileDTO fDTO = new FileDTO();
		HashMap<String,Object> hMap = new HashMap<>();
		sDTO.setSpeechNo(spcNo);
		sDTO.setRegno(session.getAttribute("userNo").toString());
		fDTO.setFileOriginName(mhsr.getFile("webRecorderFile").getOriginalFilename());
		fDTO.setFileNewName(fileArray[0]);
		fDTO.setFilePath(path);
		hMap.put("sDTO", sDTO);
		hMap.put("fDTO", fDTO);
		int result = speechService.insertFileSpeech(hMap);
		String msg,url;
		if(result==1) {
			File newFile =new File(fileArray[1]);
			if(!newFile.isDirectory()) {
				newFile.mkdirs();
			}
			mhsr.getFile("webRecorderFile").transferTo(newFile);
			msg="등록하였습니다.";
			url="/speech/mySpeechQuestion.do";
		}else{
			msg="실패하였습니다.";
			url="/speech/mySpeechQuestion.do";
		}
		
		hMap=null;
		sDTO=null;
		fDTO=null;
		
		return "/alert";
	}
	@RequestMapping("/answerList")
	public String getAnswerList(HttpServletRequest req,Model model) throws Exception{
		String spcNo=req.getParameter("spcNo");
		List<SpeechDTO> sList=new ArrayList<>(); 
		SpeechDTO sDTO = new SpeechDTO();
		sDTO.setSpeechNo(spcNo);
		sList = speechService.getAnswerList(sDTO);
		log.info(sList.size());
		for(int i=0 ;i<sList.size();i++) {
			log.info(sList.get(i).getSpcJobQuestion());
		}
		model.addAttribute("sList",sList);
		return "/speech/speechAnswerList";
	}
	
}
