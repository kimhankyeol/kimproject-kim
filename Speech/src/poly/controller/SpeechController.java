package poly.controller;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestParam;

import poly.dto.SpeechDTO;
import poly.service.ISpeechService;
import poly.util.CmmUtil;


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
		String webType = CmmUtil.nvl(req.getParameter("webType").toString());
		log.info(webType);
		model.addAttribute("webType",webType);
		return "/speech/speechDetail";
	}
}
