package com.kh.hmm.newTech.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hmm.board.controller.BoardController;
import com.kh.hmm.board.model.service.BoardService;
import com.kh.hmm.board.model.vo.Board;
import com.kh.hmm.newTech.model.service.WeeksubjectService;
import com.kh.hmm.newTech.model.vo.Weeksubject;

@Controller
public class WeeksubjectController
{
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
			
	@Autowired
	private WeeksubjectService weekService;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "weeksubject.do", method = RequestMethod.GET)
	public String weeksubject(Model m) 
	{
		logger.info("weeksubject() call...");		
		
		Weeksubject ws=weekService.selectWeek();
			
		ArrayList<Date> hlist=weekService.selectDate();
		ArrayList<String> dlist=new ArrayList<String>();
		ArrayList<String> slist=new ArrayList<String>();
		
		Calendar c = Calendar.getInstance();
		for(java.util.Date d:hlist) 
		{
			c.setTime(d);
			int wks=c.get(Calendar.WEEK_OF_YEAR);
			if(wks/10==0)	dlist.add(c.get(Calendar.YEAR)+"0"+wks);
			else dlist.add(c.get(Calendar.YEAR)+""+wks);
			
			String temp=wks+"주차 : "+c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DATE);
			
			slist.add(temp);			
		}
		m.addAttribute("slist",slist);
		m.addAttribute("dlist",dlist);
		
		
		Date date=ws.getStartdate();
		c = Calendar.getInstance();
	 	c.setTime(date);
		
	 	ArrayList<Board> list=boardService.selectNewTechList(date);
	 	
	 	m.addAttribute("week",String.valueOf(c.get(Calendar.WEEK_OF_YEAR)));//전체 주차
	 	m.addAttribute("weeksubject", ws);//주제 및 날짜정보
	 	m.addAttribute("list",list);
		
		return "../../newtech";
	}
	
	
	
	@RequestMapping(value = "newTechResult.do", method = RequestMethod.GET)
	public String newTechResult(Model m,int wscode) 
	{
		logger.info("newTechResult("+wscode+") call...");		
		
		Weeksubject ws=weekService.selectWeek();
		
		int agreeNum=weekService.proCount();
		int disagreeNum=weekService.conCount();
		int sum=agreeNum+disagreeNum;		
		
		m.addAttribute("weeksubject", ws);//주제 및 날짜정보
		m.addAttribute("agreeNum",agreeNum);
		m.addAttribute("disagreeNum",disagreeNum);
		m.addAttribute("sum",sum);
		
		if(sum==0) 
		{
			m.addAttribute("agreePercent",0);
			m.addAttribute("disagreePercent",0);
		}
		
		m.addAttribute("agreePercent",((int)(agreeNum*1000.0/sum))/10.0);
		m.addAttribute("disagreePercent",((int)(disagreeNum*1000.0/sum))/10.0);

		return "../../newtechResult";
	}
	
	@ResponseBody
	@RequestMapping(value = "isVote.do", method = RequestMethod.GET)
	public int isVote(String id) 
	{
		logger.info("isVote("+id+") call...");		
				
		return weekService.pcSearch(id);
	}
	
	@ResponseBody
	@RequestMapping(value = "agree.do", method = RequestMethod.GET)
	public void agree(String id,int wscode) throws IOException 
	{
		logger.info("agree("+id+","+wscode+") call...");		
		
		weekService.proInsert(id,wscode);	
	}
		
	
	@ResponseBody
	@RequestMapping(value = "disagree.do", method = RequestMethod.GET)
	public void disagree(String id,int wscode)
	{
		logger.info("disagree("+id+","+wscode+") call...");		
		
		weekService.conInsert(id,wscode);	
	}
		
	@RequestMapping(value = "newtecHistory.do", method = RequestMethod.GET)
	public void newtecHistory(Model m) 
	{
		logger.info("newtecHistory() call...");
		
		ArrayList<Date> hlist=weekService.selectDate();
		
		m.addAttribute("hlist", hlist);
	}
		
	@RequestMapping(value = "historyResult.do", method = RequestMethod.GET)
	public String historyResult(Model m,String yweek) 
	{
		logger.info("historyResult("+yweek+") call...");
		
		int year=Integer.parseInt(yweek.substring(0, 4));
		int week=Integer.parseInt(yweek.substring(4,6));
		
	 	ArrayList<Weeksubject> wlist=weekService.getDWeekService(year);
	 	Weeksubject ws=null;
	 	
	 	for(Weeksubject wsubject:wlist) 
	 	{
	 		Date date=wsubject.getStartdate();
			Calendar c = Calendar.getInstance();
		 	c.setTime(date);
	 		
	 		if(week==c.get(Calendar.WEEK_OF_YEAR)) 
	 		{
	 			ws=wsubject;
	 			break;
	 		}
	 	}	
	 	
	 	int agreeNum=weekService.hproCount(ws.getWscode());
		int disagreeNum=weekService.hconCount(ws.getWscode());
		int sum=agreeNum+disagreeNum;		
		
		m.addAttribute("weeksubject", ws);//주제 및 날짜정보
		m.addAttribute("agreeNum",agreeNum);
		m.addAttribute("disagreeNum",disagreeNum);
		m.addAttribute("sum",sum);
		
		if(sum==0) 
		{
			m.addAttribute("agreePercent",0);
			m.addAttribute("disagreePercent",0);
		}
		
		m.addAttribute("agreePercent",((int)(agreeNum*1000.0/sum))/10.0);
		m.addAttribute("disagreePercent",((int)(disagreeNum*1000.0/sum))/10.0);
	 	
		
		return "../../newtechResult";
	}
	
	@RequestMapping(value = "newtechAdmin.do", method = RequestMethod.GET)
	public String newtechAdmin(Model m)  
	{
		logger.info("newtechAdmin() call...");
		
		ArrayList<Weeksubject> wlist=weekService.selectWeekList();
		
		m.addAttribute("wlist", wlist);
		
		return "../../newtechAdmin";
	}
	
	@ResponseBody
	@RequestMapping(value = "insertNewtech.do", method = RequestMethod.POST)
	public void insertNewtech(int wscode, String title, String agree, String disagree) 
	{
		logger.info("insertNewtech() call...");
		
		weekService.updateWeekSubject(wscode,title,agree,disagree);
	}
}
