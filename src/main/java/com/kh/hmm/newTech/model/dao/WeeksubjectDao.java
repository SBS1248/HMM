package com.kh.hmm.newTech.model.dao;

import java.sql.Date;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hmm.newTech.model.vo.Weeksubject;

@Repository("weeksubjectDao")
public class WeeksubjectDao
{
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int proInsert(String id,int wscode)
	{
		HashMap map=new HashMap();
		map.put("id", id);
		map.put("wscode", wscode);
		
		return sqlSession.insert("proInsert",map);
	}

	public int conInsert(String id,int wscode)
	{
		HashMap map=new HashMap();
		map.put("id", id);
		map.put("wscode", wscode);
		
		return sqlSession.insert("conInsert",map);
	}	

	public Weeksubject selectWeek()
	{
		return sqlSession.selectOne("selectWeek");
	}

	public int proCount()
	{
		return sqlSession.selectOne("proCount");
	}

	public int conCount()
	{
		return sqlSession.selectOne("conCount");
	}

	public int pcSearch(String id)
	{
		return sqlSession.selectOne("pcSearch",id);
	}

	public Date getDate()
	{
		Date date=new Date(((java.util.Date)(sqlSession.selectOne("getDate"))).getTime());
		
		return date;
	}
}
