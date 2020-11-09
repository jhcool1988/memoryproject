package org.jhcool1988.controller;

import java.util.List;

import org.jhcool1988.domain.ReplyVO;
import org.jhcool1988.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/reply/*")
@AllArgsConstructor
public class ReplyAddrController {

	private ReplyService service;
	
	@GetMapping(value = "/list/{idx}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("idx") Long idx) {
		
		log.info("getList==============================================");
		
		// log.info(board);
		
		// model.addAttribute("list", service.getList());
		
		return new ResponseEntity<>(service.getList(idx), HttpStatus.OK);
		
	}
	
	
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// 삼항 연산자 처리
		
	}
	
	@RequestMapping(
			method= { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{idx}",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("idx") Long idx) {
		
		vo.setIdx(idx);
		
		log.info("rno: " + idx);
		log.info("modify: " + vo);
		
		return service.update(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
		}
	
	@DeleteMapping(value= "/{bno}" ,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("bno") Long bno){
		
		log.info("remove: " + bno);
		
		return service.remove(bno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@DeleteMapping(value= "/removeall/{idx}" ,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> removeAll(@PathVariable("idx") Long idx){
		
		log.info("removeall: " + idx);
		
		return service.removeAll(idx) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
}
