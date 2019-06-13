package poly.persistance.mapper;



import java.util.List;

import config.Mapper;
import poly.dto.NoticeDTO;
import poly.dto.UserDTO;

@Mapper("NoticeMapper")
public interface NoticeMapper {

	public List<NoticeDTO> getList() throws Exception;

	public int insertProc(NoticeDTO nDTO) throws Exception;


	
}
