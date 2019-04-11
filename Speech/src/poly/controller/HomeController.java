package poly.controller;


import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	private Logger log = Logger.getLogger(this.getClass());
	
	
	@RequestMapping(value="/home")
	public String main(HttpServletRequest request) throws Exception{
		
		System.out.println("home");
		return "/home";
	}
	
	
}
