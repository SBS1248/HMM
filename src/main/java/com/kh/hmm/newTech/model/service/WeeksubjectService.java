package com.kh.hmm.newTech.model.service;

import java.sql.Date;

import com.kh.hmm.newTech.model.vo.Weeksubject;

public interface WeeksubjectService
{
	int proInsert(String id,int wscode);

	int conInsert(String id,int wscode);
	
	int proCount();

	int conCount();
	
	int pcSearch(String id);
	
	Weeksubject selectWeek();

	Date getDate();
}
