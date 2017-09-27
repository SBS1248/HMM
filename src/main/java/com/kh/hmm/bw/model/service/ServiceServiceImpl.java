package com.kh.hmm.bw.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hmm.bw.model.dao.ServiceDao;

@Service("serviceService")
public class ServiceServiceImpl implements ServiceService{
	
	@Autowired
	private ServiceDao sDao;

	@Override
	public void insertService(com.kh.hmm.bw.model.vo.Service s) {
		sDao.insertService(s);
		
	}

	@Override
	public ArrayList<com.kh.hmm.bw.model.vo.Service> selectAll() {
		
		return sDao.selectAll();
	}
	
}
