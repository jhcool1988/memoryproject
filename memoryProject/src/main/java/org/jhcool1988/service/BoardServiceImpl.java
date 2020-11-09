package org.jhcool1988.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jhcool1988.domain.BoardAttachVO;
import org.jhcool1988.domain.BoardVO;
import org.jhcool1988.mapper.BoardAttachMapper;
import org.jhcool1988.mapper.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

	
	private BoardMapper mapper;
	// private BoardVO board;
	
	private BoardAttachMapper attachMapper;
	
//	@Override
//	public List<BoardVO> allList(){
//		
//		return mapper.allList();
//	}
	
	@Override
	public List<BoardVO> getList(String placename) {
		
		log.info("getList...........");
		
		// board.setAddr("경복궁");
		
		return mapper.getList(placename);
		
	}
	
	
	@Override
	public int register(BoardVO vo) {
		
		log.info("register........." + vo);
		
		return mapper.insert(vo);
		
	}
	
	@Override
	public int remove(Long idx) {
		
		log.info("remove....." + idx);
		
		return mapper.delete(idx);
	}
	
	@Override
	public void attachRegister(BoardVO vo) {
	
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		vo.getAttachList().forEach(attach ->{
			
			attachMapper.insert(attach);
		});
		
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(String uuid){
		
		log.info("get Attach list by uuid: " + uuid);
		
		return attachMapper.findByUuid(uuid);
		
	}


	@Override
	public void removeimg(String uuid) {
		
		log.info("img delete: " + uuid);
		
		attachMapper.delete(uuid);
	}


	@Override
	public int update(BoardVO vo) {
		
		return mapper.update(vo);
	}


	@Override
	public BoardVO getOne(Long idx) {
		
		return mapper.getOne(idx);
	}
	
}
