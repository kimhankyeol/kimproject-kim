package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.SpeechDTO;

@Mapper("SpeechMapper")
public interface SpeechMapper {

	public int insertSpeech(SpeechDTO sDTO) throws Exception;

	public List<SpeechDTO> getMySpeechList(SpeechDTO sDTO) throws Exception;

	public List<SpeechDTO> getSpeechList() throws Exception;

	public SpeechDTO getSpeechDetail(SpeechDTO sDTO) throws Exception;
	
}
