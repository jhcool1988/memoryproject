package org.jhcool1988.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jhcool1988.domain.ReplyVO;
import org.jhcool1988.mapper.ReplyMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

	private ReplyMapper mapper;
	// private BoardVO board;
	
//	@Override
//	public List<BoardVO> allList(){
//		
//		return mapper.allList();
//	}
	
	@Override
	public List<ReplyVO> getList(Long idx) {
		
		log.info("getList...........");
		
		// board.setAddr("경복궁");
		
		return mapper.getList(idx);
		
	}
	
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register........." + vo);
		
		return mapper.insert(vo);
		
	}
	
	@Override
	public int remove(Long bno) {
		
		log.info("remove....." + bno);
		
		return mapper.delete(bno);
	}

	@Override
	public int update(ReplyVO vo) {
		
		log.info("update....." + vo);
		
		return mapper.update(vo);
	}

	@Override
	public int removeAll(Long idx) {
		
		log.info("removeall....." + idx);
		
		return mapper.deleteAll(idx);
	}
	
	
}
