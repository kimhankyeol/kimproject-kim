package poly.service.impl;

import java.util.Arrays;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.SpeechDTO;
import poly.persistance.mapper.SpeechMapper;
import poly.service.ISpeechService;

@Service("SpeechService")
public class SpeechService implements ISpeechService{
	@Resource(name="SpeechMapper")
	SpeechMapper speechMapper;

	@Override
	public int insertSpeech(Map<String, String> map,String[] spcJobTag) throws Exception {
		// TODO Auto-generated method stub
		String userNo = map.get("userNo");
		String spcJobTagArrStr=Arrays.toString(spcJobTag);
		String spcJobTitle =  map.get("spcJobTitle");
		String spcJobQuestion =  map.get("spcJobQuestion");
		SpeechDTO sDTO = new SpeechDTO();
		sDTO.setRegno(userNo);
		sDTO.setSpcJobTag(spcJobTagArrStr);
		sDTO.setSpcJobTitle(spcJobTitle);
		sDTO.setSpcJobQuestion(spcJobQuestion);
		
		int result = speechMapper.insertSpeech(sDTO);
		
		return result;
	}
	
	
	
}
