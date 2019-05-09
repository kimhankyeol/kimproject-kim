package poly.service.impl;

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
	public int insertSpeech(SpeechDTO sDTO) throws Exception {
		// TODO Auto-generated method stub
		return speechMapper.insertSpeech(sDTO);
	}
	
	
	
}
