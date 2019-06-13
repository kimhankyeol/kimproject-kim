package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.NoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService{
	
	@Resource(name="NoticeMapper")
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeDTO> getList() throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.getList();
	}

	@Override
	public int insertProc(NoticeDTO nDTO) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.insertProc(nDTO);
	}

	
	
	
}
