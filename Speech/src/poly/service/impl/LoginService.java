package poly.service.impl;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.UserMapper;
import poly.service.ILoginService;
import poly.util.CmmUtil;
import poly.util.StringUtil;

@Service("LoginService")
public class LoginService implements ILoginService{
	
	@Resource(name="UserMapper")
	private UserMapper userMapper;

	@Override
	public void login(Map<String, String> map,HttpSession session) throws Exception {
		
		String name = CmmUtil.nvl(map.get("name"));
		String email=CmmUtil.nvl(map.get("email"));
		String snsVal = CmmUtil.nvl(map.get("snsVal"));;
		if(snsVal.equals("kakao")) {
			name=StringUtil.spec(name, "\"");
			email=StringUtil.spec(email, "\"");
		}
		
		UserDTO uDTO = new UserDTO();
		uDTO.setUserName(name);
		uDTO.setUserEmail(email);
		uDTO.setSnsVal(snsVal);
		
		int result1 = userMapper.checkLogin(uDTO);
		
		if(result1==0) {
			userMapper.insertUserRegSns(uDTO);
			session.setAttribute("userNo",uDTO.getUserNo());
			session.setAttribute("userName",name);
			session.setAttribute("email",email);
			session.setAttribute("snsVal",snsVal);
		} else {
			String userNo=userMapper.getFindUserNo(uDTO);
			session.setAttribute("userNo",userNo);
			session.setAttribute("userName",name);
			session.setAttribute("email",email);
			session.setAttribute("snsVal",snsVal);
			
		}
		
	}
	
}
