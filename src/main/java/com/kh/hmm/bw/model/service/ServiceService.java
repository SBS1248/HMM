package com.kh.hmm.bw.model.service;

import java.util.ArrayList;

import com.kh.hmm.bw.model.vo.Service;

public interface ServiceService {

	void insertService(Service s);

	ArrayList<Service> selectAll();
	
	
	
}
