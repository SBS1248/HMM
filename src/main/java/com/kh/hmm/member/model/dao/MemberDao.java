package com.kh.hmm.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hmm.member.model.vo.Member;

@Repository("memberDao")
public class MemberDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public Member selectMember(String writerid) {
		return (Member) sqlSession.selectOne("selectMember",writerid);
	}

	public Member loginMember(Member m) {
		return sqlSession.selectOne("login", m);
	}

	public Member enrollMember(Member m) {
		int result;
		Member member = null;
		result = sqlSession.insert("enroll", m);

		if (result >= 1)
			member = sqlSession.selectOne("login", m);
		return member;
	}

	public Member updateMember(Member m) {
		int result;
		Member member = null;
		result = sqlSession.update("update", m);

		if (result >= 1)
			member = sqlSession.selectOne("login", m);
		return member;
	}

	public Member dupMember(Member m) {
		return sqlSession.selectOne("chkDup", m);
	}

	public Member emailCheck(Member m) {
		return (Member) sqlSession.selectOne("emailChk", m);
	}

	public Member updatePhoto(Member m) {
		int result;
		Member member = null;
		result = sqlSession.update("updatePhoto", m);

		if (result >= 1)
			member = sqlSession.selectOne("login", m);
		return member;
	}

	public Member googleMember(Member m) {
		int result = 0;
		Member member = null;
		member = sqlSession.selectOne("emailChk", m);

		if (member != null) {
			return member;
		} else {
			result = sqlSession.insert("google", m);
			if (result >= 1)
				member = sqlSession.selectOne("login", m);
			return member;
		}
	}

	public Member CheckEmailId(Member m) {
		return (Member) sqlSession.selectOne("emailChk", m);
	}
	
	public ArrayList<Integer> leveling(long exp)
	{		
		List<Integer> list= sqlSession.selectList("leveling", exp);
		return (ArrayList<Integer>) list;
	}

	public Integer recompoint(String id)
	{
		return sqlSession.selectOne("recompoint",id);
	}
	
	public void recomcount5(int membercode) 
	{
		sqlSession.update("recomcount5",membercode);
	}
	
	public void recomcount3(int membercode) 
	{
		sqlSession.update("recomcount3",membercode);
	}

	public Integer havmedal(int membercode)
	{
		return sqlSession.selectOne("havmedal",membercode);
	}

	public void givemedal(int membercode)
	{
		sqlSession.update("givemedal",membercode);
	} 
}
