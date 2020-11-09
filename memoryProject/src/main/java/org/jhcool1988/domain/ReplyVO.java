package org.jhcool1988.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long bno;
	private Long idx;
	private String reply;
	private String replyer;
	private Date relpyDate;
	
	
}
