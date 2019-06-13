package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.NoticeDTO;
import poly.service.INoticeService;
@RequestMapping("/notice")
@Controller
public class NoticeController {

	@Resource(name="NoticeService")
	INoticeService noticeService;
	
	@RequestMapping(value="/list")
	public String getList(Model model) throws Exception{
		
		List<NoticeDTO> nList = new ArrayList<>();
		
		nList = noticeService.getList();
		model.addAttribute("nList",nList);
		
		return "/notice/noticeList";
	}
	@RequestMapping(value="/insert")
	public String getInsert() throws Exception{
		
		return "/notice/noticeInsert";
	}
	@RequestMapping(value="/insertProc")
	public String insertProc(HttpServletRequest req,Model model) throws Exception{
		NoticeDTO nDTO = new NoticeDTO();
		nDTO.setRegno(req.getParameter("userNo"));
		nDTO.setWriter(req.getParameter("userName"));
		nDTO.setNoticeContent(req.getParameter("cont"));
		nDTO.setNoticeTitle("title");
		
		int result = noticeService.insertProc(nDTO);
		String msg,url;
		if(result==1) {
			msg="등록";
			url="/notice/list.do";
		}else {
			msg="삭제";
			url="/notice/list.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		return "/alert";
	}
}
