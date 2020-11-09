package org.jhcool1988.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jhcool1988.domain.ReplyVO;



public interface ReplyMapper {

	// public List<BoardVO> allList();
	
	public List<ReplyVO> getList(
			@Param("idx") Long idx);
	
	public int insert(ReplyVO vo);
	
	public int delete (Long bno);
	
	public int update(ReplyVO vo);
	
	// 게시물과 함꼐 댓글 다 지우기
	public int deleteAll (Long idx);
}
