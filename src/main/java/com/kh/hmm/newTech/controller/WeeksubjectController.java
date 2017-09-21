package com.kh.hmm.newTech.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

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

import com.kh.hmm.board.controller.BoardController;
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
	
	@RequestMapping(value = "weeksubject.do", method = RequestMethod.GET)
	public String weeksubject(Model m) 
	{
		logger.info("weeksubject() call...");		
		
		Weeksubject ws=weekService.selectWeek();
		
		if(ws!=null) m.addAttribute("weeksub", ws);
		
		return "../../newtech";
	}
	
	@RequestMapping(value = "proInsert.do", method = RequestMethod.POST)
	public void proInsert(HttpServletResponse response,HttpSession session) throws IOException 
	{
		logger.info("proInsert() call...");		
		
		PrintWriter pw = response.getWriter();
		String id=((Member)session.getAttribute("member")).getId();
		
		if(weekService.pcSearch(id)%2==0) 
		{
			pw.print("p");		
		}
		else if(weekService.pcSearch(id)%3==0)
		{
			pw.print("c");
		}
		else 
		{
			weekService.proInsert(id);
			pw.print(weekService.proCount());		
		}
		
		pw.close();		
	}
		
	
	@RequestMapping(value = "conInsert.do", method = RequestMethod.POST)
	public void conInsert(HttpServletResponse response,HttpSession session) throws IOException 
	{
		logger.info("conInsert() call...");		
		PrintWriter pw = response.getWriter();
		String id=((Member)session.getAttribute("member")).getId();
		
		if(weekService.pcSearch(id)%2==0) 
		{
			pw.print("p");		
		}
		else if(weekService.pcSearch(id)%3==0)
		{
			pw.print("c");
		}
		else 
		{
			weekService.conInsert(id);
			pw.print(weekService.proCount());		
		}		
		
		pw.close();		
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
