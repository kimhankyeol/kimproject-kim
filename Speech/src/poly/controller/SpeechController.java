package poly.controller;
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
	public String mySpcQuestion() throws Exception{
		return "/speech/mySpeechQuestion";
	}
	@RequestMapping(value="/jobCtgSpeech")
	public String jobCtgSpeech() throws Exception {
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
	
	
	
}
