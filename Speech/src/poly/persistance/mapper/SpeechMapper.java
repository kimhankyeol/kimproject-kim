package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.AnswerDTO;
import poly.dto.SpeechDTO;

@Mapper("SpeechMapper")
public interface SpeechMapper {

	public int insertSpeech(SpeechDTO sDTO) throws Exception;

	public List<SpeechDTO> getMySpeechList(SpeechDTO sDTO) throws Exception;

	public List<AnswerDTO> getSpeechList() throws Exception;

	public SpeechDTO getSpeechDetail(SpeechDTO sDTO) throws Exception;

	public int insertFileSpeech(HashMap<String, Object> hMap) throws Exception;

	public List<AnswerDTO> getAnswerList(AnswerDTO aDTO) throws Exception;

	public String getFileInfo(AnswerDTO aDTO) throws Exception;

	public AnswerDTO getAnswerDetail(AnswerDTO aDTO) throws Exception;

	public int insertSpeechData(AnswerDTO aDTO) throws Exception;

	public List<AnswerDTO> getAnswerList2(AnswerDTO aDTO) throws Exception;

	public int deleteSpeech(AnswerDTO aDTO) throws Exception;
	
	public int deleteFile(AnswerDTO aDTO) throws Exception;
	
	public int deleteAnswer(AnswerDTO aDTO) throws Exception;

	/*public List<SpeechDTO> getAjaxList(SpeechDTO sDTO) throws Exception;*/
	
	
}
