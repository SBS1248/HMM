package com.kh.hmm.bw.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hmm.board.model.service.BoardService;
import com.kh.hmm.bw.model.service.ServiceService;
import com.kh.hmm.bw.model.vo.Service;

@Controller
public class Servicecontroller {
	
	@Autowired
	private ServiceService sService;
	
	@RequestMapping(value = "bwlist.do", method = RequestMethod.POST)
	public String bwlist(Service s) {

		
		sService.insertService(s);
	
		return "../../index";
	}
	
	
	@RequestMapping(value = "adminlist.do")
	public  String adminlist(Model model) {
	
		ArrayList<Service> slist = sService.selectAll();
		System.out.println("에스리스트" + slist);
		model.addAttribute("slist",slist);
		return "../../adminpage";
	
	}
}
