package com.kh.hmm.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hmm.board.model.dao.CommentsDao;
import com.kh.hmm.board.model.vo.Comments;
import com.kh.hmm.board.model.vo.CommentsPoint;
import com.kh.hmm.member.model.dao.MemberDao;
import com.kh.hmm.member.model.vo.Member;

@Service("commentsService")
public class CommentsServiceImpl implements CommentsService
{

	@Autowired
	private CommentsDao cDao;

	@Override
	public ArrayList<Comments> selectCommentsList(int bcode)
	{
		return cDao.selectComments(bcode);
	}

	@Override
	public int insertComments(Comments c)
	{
		return cDao.insertComments(c);
	}

	@Override
	public int updateComments(Comments c)
	{
		return cDao.updateComments(c);
	}

	@Override
	public int deletComments(Comments c)
	{
		return cDao.deleteComments(c);
	}

	@Override
	public int checkComments(CommentsPoint point)
	{
		return cDao.chechComments(point);
	}	
}
