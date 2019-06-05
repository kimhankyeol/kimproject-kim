package poly.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.AnswerDTO;
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

	@Override
	public List<SpeechDTO> getMySpeechList(SpeechDTO sDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getMySpeechList(sDTO);
	}

	@Override
	public List<AnswerDTO> getSpeechList() throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getSpeechList();
	}

	@Override
	public SpeechDTO getSpeechDetail(SpeechDTO sDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getSpeechDetail(sDTO);
	}

	@Override
	public int insertFileSpeech(HashMap<String, Object> hMap) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.insertFileSpeech(hMap);
	}

	@Override
	public List<AnswerDTO> getAnswerList(AnswerDTO aDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getAnswerList(aDTO);
	}

	@Override
	public String getFileInfo(AnswerDTO aDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getFileInfo(aDTO);
	}

	@Override
	public AnswerDTO getAnswerDetail(AnswerDTO aDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.getAnswerDetail(aDTO);
	}

	@Override
	public int insertSpeechData(AnswerDTO aDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.insertSpeechData(aDTO);
	}
	
	
	
}
