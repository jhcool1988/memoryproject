package org.jhcool1988.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private String addr;
	private Long idx;
	private String writer;
	private String context;
	private Date regdate;
	private Date updateDate;
	private String placename;
	private String uuid;
	
	private List<BoardAttachVO> attachList;
	
}
