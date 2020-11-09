package org.jhcool1988.mapper;

import org.jhcool1988.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
//	
//	@Test
//	public void testInsert() {
//		
//		BoardVO board = new BoardVO();
//		board.setWriter("비오나");
//		board.setContext("새로 작성하는 내용");
//		board.setAddr("남산");
//		
//		mapper.insert(board);
//		
//		log.info(board);
//	}
//
	
//	@Test
//	public void testDelete() {
//		
//		Long targetIdx = 1L;
//		
//		mapper.delete(targetIdx);
//	}
	
	
}
