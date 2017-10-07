package com.kh.hmm.newTech.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
import com.kh.hmm.member.model.vo.Member;
import com.kh.hmm.newTech.model.service.WeeksubjectService;
import com.kh.hmm.newTech.model.vo.Conlist;
import com.kh.hmm.newTech.model.vo.Prolist;
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
		
		Date date=ws.getStartdate();
		Calendar c = Calendar.getInstance();
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
		m.addAttribute("agreeNUm",agreeNum);
		m.addAttribute("disagreeNum",disagreeNum);
		m.addAttribute("sum",sum);
		m.addAttribute("agreePercent",agreeNum/sum);
		m.addAttribute("disagreePercent",disagreeNum/sum);
		
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
	public void disagree(String id,int wscode) throws IOException 
	{
		logger.info("disagree("+id+","+wscode+") call...");		
		
		weekService.conInsert(id,wscode);	
	}
		
	@RequestMapping(value = "multiCount.do", method = RequestMethod.GET)
	public void multiCount(HttpServletResponse response) throws IOException 
	{
		logger.info("multiCount() call...");
		
		int pro=weekService.proCount();
		int con=weekService.conCount();

		PrintWriter out = response.getWriter();
		out.write("[\""+pro+"\",\""+con+"\"]");
		out.flush();
		out.close();
	}
}
