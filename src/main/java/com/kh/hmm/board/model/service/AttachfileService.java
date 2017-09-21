package com.kh.hmm.board.model.service;

import java.util.ArrayList;

import com.kh.hmm.board.model.vo.Attachfile;
import com.kh.hmm.member.model.vo.Member;

public interface AttachfileService
{
	ArrayList<Attachfile> selectFileList(int bcode);
	
	int insertAttachfile(Attachfile file);
	
	int deleteAttachfile(int atcode);
	
	int updateAttachfile(Attachfile file);
}
