package com.kh.hmm.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hmm.board.model.vo.Board;
import com.kh.hmm.board.model.vo.Comments;
import com.kh.hmm.board.model.vo.CommentsPoint;
import com.kh.hmm.member.model.vo.Member;

@Repository("commentsDao")
public class CommentsDao
{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Comments> selectComments(int bcode) 
	{
		List<Comments> list=sqlSession.selectList("selectComments",bcode);
		
		return (ArrayList<Comments>)list;
	}

	public int insertComments(Comments c) 
	{
		return sqlSession.insert("insertComments",c);
	}
	
	public int updateComments(Comments c) 
	{
		return sqlSession.update("updateComments",c);
	}
	
	public int deleteComments(Comments c) 
	{
		return sqlSession.delete("updateComments",c);
	}
	
	public int chechComments(CommentsPoint point) 
	{
		return sqlSession.update("checkComments",point);
	}
}
