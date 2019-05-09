package poly.controller;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.SpeechDTO;
import poly.service.ISpeechService;


@Controller
@RequestMapping("/speech")
public class SpeechController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="SpeechService")
	private ISpeechService speechService;

	@RequestMapping(value="/list")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
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
	public String speechInsertProc(HttpServletRequest req) throws Exception{
		String spcJobTag = req.getParameter("spcJobTag");
		String spcJobTitle = req.getParameter("spcJobTitle");
		String spcJobQuestion = req.getParameter("spcJobQuestion");
		
		SpeechDTO sDTO = new SpeechDTO();
		sDTO.setSpcJobTag(spcJobTag);
		sDTO.setSpcJobTitle(spcJobTitle);
		sDTO.setSpcJobQuestion(spcJobQuestion);
		
		int result = speechService.insertSpeech(sDTO);
		return null;
	}
	
	
	
}
