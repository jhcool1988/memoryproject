package org.jhcool1988.service;

import java.util.List;

import org.jhcool1988.domain.BoardAttachVO;
import org.jhcool1988.domain.BoardVO;

public interface BoardService {
	
//	public List<BoardVO> allList();

	public List<BoardVO> getList(String placename);
	
	public int register (BoardVO vo);
	
	public int remove(Long idx);
	
	public void attachRegister (BoardVO vo);
	
	public List<BoardAttachVO> getAttachList(String uuid);
	
	public void removeimg(String uuid);
	
	public int update(BoardVO vo);
	
	public BoardVO getOne(Long idx);
	
}
