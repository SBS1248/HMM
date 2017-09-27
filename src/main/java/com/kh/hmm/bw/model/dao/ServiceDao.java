package com.kh.hmm.bw.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hmm.board.model.vo.Board;
import com.kh.hmm.bw.model.vo.Service;

@Repository("serviceDao")
public class ServiceDao 
{
	@Autowired
	private SqlSessionTemplate sqlSession;

	public void insertService(com.kh.hmm.bw.model.vo.Service s) {
		sqlSession.insert("serviceinsert", s);
		
	}
	
	
	public ArrayList<com.kh.hmm.bw.model.vo.Service> selectAll() {
		
	
		
		return new ArrayList<Service>(sqlSession.selectList("serviceselectAll"));
		
		
	}
	
	
}
