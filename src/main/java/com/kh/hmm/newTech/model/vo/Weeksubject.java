package com.kh.hmm.newTech.model.vo;

import java.sql.Date;

public class Weeksubject
{
	private int wscode;
	private String title;
	private Date startdate;
	
	public Weeksubject() {}
	
	public Weeksubject(int wscode, String title, Date startdate)
	{
		super();
		this.wscode = wscode;
		this.title = title;
		this.startdate = startdate;
	}
	public int getWscode()
	{
		return wscode;
	}
	public void setWscode(int wscode)
	{
		this.wscode = wscode;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public Date getStartdate()
	{
		return startdate;
	}
	public void setStartdate(Date startdate)
	{
		this.startdate = startdate;
	}
	@Override
	public String toString()
	{
		return "Weeksubject [wscode=" + wscode + ", title=" + title + ", startdate=" + startdate + "]";
	}
	
	
	
	
}
