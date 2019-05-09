package poly.persistance.mapper;

import config.Mapper;
import poly.dto.SpeechDTO;

@Mapper("SpeechMapper")
public interface SpeechMapper {

	public int insertSpeech(SpeechDTO sDTO) throws Exception;
	
}
