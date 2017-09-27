package com.kh.hmm.bw.controller;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hmm.board.model.service.BoardService;
import com.kh.hmm.bw.model.service.ServiceService;
import com.kh.hmm.bw.model.vo.Service;
import com.kh.hmm.member.model.vo.Member;

@Controller
public class Servicecontroller {
	
	@Autowired
	private ServiceService sService;
	
	@Autowired
	private JavaMailSender mailSender; // xml에 등록한 bean autowired
	
	// 메일 발송도 같이 함
	@RequestMapping(value = "bwlist.do", method = RequestMethod.POST)
	public String bwlist(Service s) throws FileNotFoundException, URISyntaxException {

		System.out.println(s);
		sService.insertService(s);
		try{
			  SimpleMailMessage message = new SimpleMailMessage();
			 
			  message.setFrom(s.getSername());
			  message.setTo("wkdgma91@gmail.com");
			  message.setSubject("["+s.getSername()+"] : "+s.getSercontent().substring(0, 7));
			  message.setText(s.getSercontent());
			   
			  mailSender.send(message);
			 
			 }catch(Exception e){
			  e.printStackTrace();
			 }  
		return "../../index";
	} 
	
	@RequestMapping(value = "adminlist.do")
	public  String adminlist(Model model) {
	
		ArrayList<Service> slist = sService.selectAll();
		model.addAttribute("slist",slist);
		return "../../adminpage";
	
	}
}