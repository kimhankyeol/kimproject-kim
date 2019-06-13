package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;

public interface INoticeService {

	public List<NoticeDTO> getList() throws Exception;

	public int insertProc(NoticeDTO nDTO) throws Exception;

}
