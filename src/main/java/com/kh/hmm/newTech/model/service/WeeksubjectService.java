package com.kh.hmm.newTech.model.service;

import com.kh.hmm.newTech.model.vo.Weeksubject;

public interface WeeksubjectService
{
	int proInsert(String string);

	int conInsert(String string);
	
	int proCount();

	int conCount();
	
	int pcSearch(String id);
	
	Weeksubject selectWeek();
}
