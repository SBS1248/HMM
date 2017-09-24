package com.kh.hmm.item.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.hmm.board.controller.BoardController;
import com.kh.hmm.item.model.service.ItemService;
import com.kh.hmm.item.model.vo.Item;
import com.kh.hmm.item.model.vo.Purchaseditem;
import com.kh.hmm.member.model.service.MemberService;
import com.kh.hmm.member.model.vo.Member;

@Controller
public class ItemController
{
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private ItemService itemService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "itemLists.do", method = RequestMethod.GET)
	public String selectItemList(Model model) 
	{
		logger.info("selectItemList() call...");

		ArrayList<Item> list=itemService.selectItemList();		
		
		if(list != null)
		{
			model.addAttribute("list", list);
		}		
		
		//매점으로
		return "../../cashshop";
	}
	
	@RequestMapping(value = "itemOne.do", method = RequestMethod.GET)
	public String selectItemOne(Model model,int itemcode) 
	{
		logger.info("selectItemOne("+itemcode+") call...");

		Item item=itemService.selectItemOne(itemcode);		
		
		if(item != null)
		{
			model.addAttribute("item", item);
		}		
		
		//아이템 상세보기로
		return "../../index";
	}
	
	@RequestMapping(value = "itemPurchasedLists.do", method = RequestMethod.GET)
	public String selectPurchasedItemList(Model model,int membercode) 
	{
		logger.info("selectPurchasedItemList("+membercode+") call...");

		ArrayList<Item> list=itemService.selectPurchasedItemList(membercode);		
		
		if(list != null)
		{
			model.addAttribute("list", list);
		}		
		
		//인벤토리로
		return "../../index";
	}
	
	@RequestMapping(value = "itemPurchase.do", method = RequestMethod.POST)
	public String itemPurchase(HttpSession session,int itemcode) 
	{
		logger.info("itemPurchase("+itemcode+") call...");
		
		String returnGo="";
		Member member=(Member)session.getAttribute("member");
		Item item=itemService.selectItemOne(itemcode);		
		
		if(member==null) returnGo="";//로그인 페이지로 넘어가라	
		else 
		{
			if(item.getPrice()>member.getDdaru()) returnGo="";//따루 부족이니 따루 구매 페이지 또는 따루 모으는 방법 페이지
			else 
			{
				Purchaseditem pitem=new Purchaseditem();
				pitem.setMembercode(member.getMembercode());
				pitem.setItemcode(itemcode);
				
				itemService.insertOne(pitem);
				member.setDdaru(member.getDdaru()-item.getPrice());
				memberService.updateDDARU(member);
				
				returnGo="";//구매 완료 페이지, 인벤토리로 넘어가라
			}
		}		
		
		//인벤토리로
		return "../../index";
	}
	
	@RequestMapping(value = "itemDelete.do", method = RequestMethod.POST)
	public String itemDelete(HttpSession session,int itemcode) 
	{
		logger.info("itemDelete("+itemcode+") call...");
		
		String returnGo="";
		int membercode=((Member)session.getAttribute("member")).getMembercode();
				
		Purchaseditem pitem=new Purchaseditem();
		pitem.setMembercode(membercode);
		pitem.setItemcode(itemcode);
		
		itemService.deleteOne(pitem);
				
		return "../../index";//인벤토리로
	}
}
