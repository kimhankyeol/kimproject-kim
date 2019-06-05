package poly.controller;


import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.service.ILoginService;


@Controller
public class HomeController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="LoginService")
	private ILoginService loginService;
/*	private final LoginService loginService;*/

	/*//생성자가 하나인 경우  @Autowired 지워도됨 //Field Injection 문제로 constructor Injection으로 변경
	HomeController(final LoginService loginService){
		 this.loginService = loginService;
	}*/
	@RequestMapping(value="/main")
	public String main() throws Exception{
		return "/main";
	}
	@RequestMapping(value="/home")
	public String home() throws Exception{
		log.info("home start"+this.getClass());
		return "/home";
	}

	
	@RequestMapping(value="/loginCallback")
	public String loginCallback(@RequestParam Map<String,String> map,HttpSession session,Model model) throws Exception{
		//가입 이메일이 있는지 확인 
//		/int result1 = loginService.checkLogin(map);
		 if(session.getAttribute("userName")!=null) {
			 session.invalidate();
		 }
		 loginService.login(map,session);
		 String msg="로그인 성공";
		 String url="/speech/list.do";
		 model.addAttribute("msg",msg);
		 model.addAttribute("url",url);
		
		return "/alert";
	}

	@RequestMapping(value="logout")
	public String logout(HttpSession session,Model model) throws Exception{
		session.invalidate();
		String url = "/home.do";
		String msg="로그아웃 하셨습니다.";
		model.addAttribute("url",url);
		model.addAttribute("msg",msg);
		return "/alert";
	}
	
}
