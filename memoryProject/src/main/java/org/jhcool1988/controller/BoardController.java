package org.jhcool1988.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jhcool1988.domain.BoardAttachVO;
import org.jhcool1988.domain.BoardVO;
import org.jhcool1988.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("/list")
	public void list() {
	}
	
	@PostMapping("/enterance")
	public String enterance2(){
	     return "redirect:/board/list?";
	}
	
	
	@GetMapping("/register")
	// @PreAuthorize("isAuthenticated()")
	public void register(@RequestParam("placename") String placename) {
	}
	
	@GetMapping("/update")
	// @PreAuthorize("isAuthenticated()")
	public void update(@RequestParam("idx") Long idx, Model model) {
		model.addAttribute("list", service.getOne(idx));
	}
	
	@PostMapping("/update")
	// @PreAuthorize("isAuthenticated()")
	public String update() {
		return "redirect:/board/list";
	}
	
	// 이미지 파일 데이터베이스에 등록
	@PostMapping("/register")
	// @PreAuthorize("isAuthenticated()")
	public String register(BoardVO vo, RedirectAttributes rttr,@RequestParam("placename") String placename) {
		
		log.info("==============================================");
		log.info("register:" +vo );
		
		if (vo.getAttachList() != null) {
			
			vo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.attachRegister(vo);
		
		return "redirect:/board/list?placename="+placename;
		
	}
	
	
	// 이미지 json데이터 반환 
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(String uuid){
		
		log.info("getAttachList " + uuid);
		
		return new ResponseEntity<>(service.getAttachList(uuid), HttpStatus.OK);
	}
	
	
}
