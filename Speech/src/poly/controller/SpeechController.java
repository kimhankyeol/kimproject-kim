package poly.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/speech")
public class SpeechController {
	private Logger log = Logger.getLogger(this.getClass());
	
	
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
	
	
}
