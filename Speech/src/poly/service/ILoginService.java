package poly.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;


public interface ILoginService {

	public void  login(Map<String, String> map, HttpSession session) throws Exception;

}
