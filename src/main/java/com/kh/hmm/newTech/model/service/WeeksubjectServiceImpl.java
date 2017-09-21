package com.kh.hmm.newTech.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hmm.newTech.model.dao.WeeksubjectDao;
import com.kh.hmm.newTech.model.vo.Conlist;
import com.kh.hmm.newTech.model.vo.Prolist;
import com.kh.hmm.newTech.model.vo.Weeksubject;

@Service("weeksubjectService")
public class WeeksubjectServiceImpl implements WeeksubjectService
{
	@Autowired
	private WeeksubjectDao wDao;

	@Override
	public int proInsert(String id)
	{		
		return wDao.proInsert(id);
	}

	@Override
	public int conInsert(String id)
	{
		return wDao.conInsert(id);
	}	

	@Override
	public Weeksubject selectWeek()
	{
		return wDao.selectWeek();
	}

	@Override
	public int proCount()
	{
		return wDao.proCount();
	}

	@Override
	public int conCount()
	{
		return wDao.conCount();
	}

	@Override
	public int pcSearch(String id)
	{
		return wDao.pcSearch(id);
	}
}
