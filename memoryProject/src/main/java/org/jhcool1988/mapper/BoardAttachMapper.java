package org.jhcool1988.mapper;

import java.util.List;

import org.jhcool1988.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByUuid(String uuid);
	
	public List<BoardAttachVO> getOldFiles();

	
}
