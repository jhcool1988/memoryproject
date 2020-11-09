package org.jhcool1988.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jhcool1988.domain.BoardVO;

public interface BoardMapper {

	// public List<BoardVO> allList();
	
	public List<BoardVO> getList(
			@Param("placename") String placename);
	
	public int insert(BoardVO vo);
	
	public int delete (Long idx);
	
	public int update(BoardVO vo);
	
	public BoardVO getOne(@Param("idx") Long idx);
	
}
