package poly.service;

import java.util.List;
import java.util.Map;

import poly.dto.SpeechDTO;


public interface ISpeechService {

	public int insertSpeech(Map<String, String> map, String[] spcJobTag) throws Exception;

	public List<SpeechDTO> getMySpeechList(SpeechDTO sDTO) throws Exception;

	public List<SpeechDTO> getSpeechList() throws Exception;


}
