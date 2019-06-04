package poly.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.AnswerDTO;
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
		String path = req.getSession().getServletContext().getRealPath("/upload/spcNo-"+spcNo+"/userNo-"+session.getAttribute("userNo").toString()+"/");
		log.info(path);
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
		List<AnswerDTO> sList=new ArrayList<>(); 
		AnswerDTO aDTO = new AnswerDTO();
		aDTO.setSpeechNo(spcNo);
		sList = speechService.getAnswerList(aDTO);
		log.info(sList.size());
		
		model.addAttribute("sList",sList);
		return "/speech/speechAnswerList";
	}
	@RequestMapping("/changeBlob")
	public @ResponseBody String getChangeBlob(HttpServletRequest req) throws Exception{
		String fileNo = req.getParameter("fileNo");
		AnswerDTO aDTO = new AnswerDTO();
		aDTO.setFileNo(fileNo);
		String filePath = speechService.getFileInfo(aDTO);
		log.info(filePath);
		String fileString = new String();

	    FileInputStream inputStream =  null;
	    ByteArrayOutputStream byteOutStream = null;
		try {
			inputStream = new FileInputStream(filePath);
			byteOutStream = new ByteArrayOutputStream();
			int len = 0;
			byte[] buf = new byte[1024];
			while ((len = inputStream.read(buf)) != -1) {
				byteOutStream.write(buf, 0, len);
			}
			byte[] fileArray = byteOutStream.toByteArray();
			fileString = new String(Base64.encodeBase64(fileArray));
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			inputStream.close();
			byteOutStream.close();
		}

		return fileString;
	}
	
}
