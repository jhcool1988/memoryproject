package org.jhcool1988.controller;

import java.util.List;
import org.jhcool1988.domain.BoardVO;
import org.jhcool1988.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardAddrController {

	private BoardService service;
	
	@GetMapping(value = "/list/{placename}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<BoardVO>> getList(@PathVariable("placename") String placename) {
		
		log.info("getList==============================================");
		
		// log.info(board);
		
		// model.addAttribute("list", service.getList());
		
		return new ResponseEntity<>(service.getList(placename), HttpStatus.OK);
		
	}
	
	
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody BoardVO vo){
		
		log.info("BoardVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Board INSERT COUNT: " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// 삼항 연산자 처리
		
	}
	
	@DeleteMapping(value= "/{idx}" ,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("idx") Long idx){
		
		log.info("remove: " + idx);
		
		return service.remove(idx) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 글 삭제시 이미지 삭제를 위한 맵핑 생성
	@DeleteMapping(value= "/delete/{uuid}" ,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public void removeimg(@PathVariable("uuid") String uuid){
		
		log.info("remove: " + uuid);
		
		service.removeimg(uuid);
		
	}
	
	// 업데이트 맵핑
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{idx}", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody BoardVO vo, @PathVariable("idx") Long idx) {

		vo.setIdx(idx);

		log.info("idx: " + idx);
		log.info("modify: " + vo);

		return service.update(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
}
