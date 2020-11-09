package org.jhcool1988.service;

import java.util.List;

import org.jhcool1988.domain.ReplyVO;




public interface ReplyService {
	
//	public List<BoardVO> allList();

	public List<ReplyVO> getList(Long idx);
	
	public int register (ReplyVO vo);
	
	public int remove(Long bno);
	
	public int update(ReplyVO vo);
	
	public int removeAll(Long idx);
	
}
