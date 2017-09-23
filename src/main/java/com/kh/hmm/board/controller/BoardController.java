package com.kh.hmm.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.hmm.board.model.service.AttachfileService;
import com.kh.hmm.board.model.service.BoardService;
import com.kh.hmm.board.model.service.CommentsService;
import com.kh.hmm.board.model.vo.Attachfile;
import com.kh.hmm.board.model.vo.Board;
import com.kh.hmm.board.model.vo.BoardPoint;
import com.kh.hmm.board.model.vo.Comments;
import com.kh.hmm.member.model.service.MemberService;
import com.kh.hmm.member.model.vo.Member;

@Controller
public class BoardController
{
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private CommentsService commentsService;
	@Autowired
	private AttachfileService attachfileService;
	@Autowired
	private MemberService memberService;
	
	
	
	@RequestMapping(value = "boardLists.do", method = RequestMethod.GET)
	public String selectBoardList(Model model,int dis) 
	{
		logger.info("selectBoardList("+dis+") call...");
		String rturn=null;
		ArrayList<Board> list=boardService.selectBoardList(dis);		
		
		if(list != null)
		{
			model.addAttribute("list", list);
		}		
		
		if(dis==0) rturn="index";
		else if(dis==3) rturn="newtech";
		else rturn="board";
		
		
		return "../../"+rturn;
	}
	
	@RequestMapping(value = "boardOne.do", method = RequestMethod.GET)
	public String selectBoardOne(Model model,int bcode) 
	{
		logger.info("selectBoardOne("+bcode+") call...");

		Board board=boardService.selectBoardOne(bcode);	
		Member writer=memberService.selectMember(board.getWriterid());
		
		ArrayList<Comments> comments=null;
		ArrayList<Attachfile> files=null;
		
		if(Integer.parseInt(board.getIsdelete())>0)	
		{
			comments=commentsService.selectCommentsList(bcode);
		}
		
		if(board.getHasfile()!=null) 
		{
			files=attachfileService.selectFileList(bcode);			
		}
		
		if(board != null)
		{
			model.addAttribute("board", board);
			model.addAttribute("writer", writer);
			if(comments!=null) model.addAttribute("comments", comments);
			if(files!=null) model.addAttribute("files", files);
		}		
				
		return "../../boardDetail";//보드 상세보기로 넘어가야한다.
	}		
	
	@RequestMapping(value = "boardCheck.do", method = RequestMethod.POST)
	public int checkBoard(BoardPoint point) 
	{//아작스 처리를 요한다.
		logger.info("checkBoard("+point+") call...");

		int result=boardService.checkBoard(point);

		return result;
	}	
	
	@RequestMapping(value = "boardcode.do", method = RequestMethod.GET)
	public String boardCode(Model m,Integer dis) 
	{//아작스 처리를 요한다.
		logger.info("boarCode() call...");

		m.addAttribute("bcode",boardService.boardCode());
		
		if(dis!=null) 
		{			
			m.addAttribute("dis", dis.intValue());
			m.addAttribute("dname", boardService.boardName(dis.intValue()));			
		}
		
		return "../../write";
	}
	
	@RequestMapping(value = "boardInsert.do", method = RequestMethod.POST)
	public void insertBoard(Board b, HttpServletResponse response) throws IOException 
	{//아작스 처리를 요한다.
		logger.info("insertBoard("+b+") call...");

		System.out.println("개객기야 되는거 잖아");	
		PrintWriter pw = response.getWriter();
		pw.write(boardService.insertBoard(b));
		pw.close();
	}
	
	@RequestMapping(value = "boardUpdate.do", method = RequestMethod.POST)
	public int updateBoard(Board b) 
	{//아작스 처리를 요한다.
		logger.info("updateBoard("+b+") call...");
		
		int result=boardService.updateBoard(b);

		return result;
	}
	
	@RequestMapping(value = "boardDelete.do", method = RequestMethod.POST)
	public String deleteBoard(int bcode) 
	{
		logger.info("deleteBoard("+bcode+") call...");

		boardService.deletBoard(bcode);

		return "../../Board";
	}
	
	@RequestMapping(value = "/fileUpload", method = RequestMethod.GET)
    public String dragAndDrop(Model model) {
         
        return "fileUpload";
         
    }
     
	@ResponseBody
    @RequestMapping(value = "fileUp.do") //ajax에서 호출하는 부분    
    public String upload(MultipartHttpServletRequest multipartRequest,int bcode) 
    { //Multipart로 받는다.
    	logger.info("upload("+bcode+") call...");  
        Iterator<String> itr =  multipartRequest.getFileNames();
         
        String filePath = "C:\\hmm\\Hmm\\src\\main\\webapp\\resources\\fileUpload\\post"; //설정파일로 뺀다.
        
        while (itr.hasNext()) 
        { //받은 파일들을 모두 돌린다.      
        	
            MultipartFile mpf = multipartRequest.getFile(itr.next());
      
            String originname = null;
            
			try
			{
				originname = new String(mpf.getOriginalFilename().getBytes("utf-8"),"utf-8");
			} catch (UnsupportedEncodingException e1)
			{
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

            String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date(new java.util.Date().getTime()));
            String changedname=now+originname;
            String fileFullPath = filePath+"/"+changedname; //파일 전체 경로
            
            Attachfile file=new Attachfile();
            file.setOriginname(originname);
            file.setChangedname(changedname);
            file.setFilelink(fileFullPath);
            file.setBcode(bcode);
            
            logger.info("in upload("+file+") call...");  
            
            attachfileService.insertAttachfile(file);
            boardService.updateAB(bcode);   
            
            try 
            {   //파일 저장
                mpf.transferTo(new File(fileFullPath)); //파일저장 실제로는 service에서 처리
            } catch (Exception e) {
                System.out.println("postTempFile_ERROR======>"+fileFullPath);
                e.printStackTrace();
            }
                          
       }
          
        return "success";
    }
    
    @ResponseBody
    @RequestMapping(value="write.do", method = RequestMethod.POST)
    public void write(Board b,Model m){
    	logger.info("write("+b+") call...");
    	boardService.writeService(b);			
		
    }

	@ResponseBody
    @RequestMapping(value = "recommendation.do", method = RequestMethod.GET)
	public HashMap recommendation(String recom,int bcode,HttpSession session) 
	{
		logger.info("recommendation("+recom+","+bcode+") call...");

		HashMap map=new HashMap();
		
		boardService.recommendation(recom,bcode);
		Member member=memberService.selectMember(((Member)session.getAttribute("member")).getId());
		
		int rResult=-1;

		switch(recom) 
		{
			case "best":
				rResult=boardService.selectBoardOne(bcode).getPoint().getBest();
				memberService.recomcount5(member.getMembercode());
				break;
			case "good":
				rResult=boardService.selectBoardOne(bcode).getPoint().getGood();
				memberService.recomcount3(member.getMembercode());
				break;
			case "bad":
				rResult=boardService.selectBoardOne(bcode).getPoint().getBad();
				memberService.recomcount3(member.getMembercode());
				break;
			case "worst":
				rResult=boardService.selectBoardOne(bcode).getPoint().getWorst();
				memberService.recomcount5(member.getMembercode());
				break;
			
		}
		map.put("point", memberService.selectMember(member.getId()).getRecompoint());
		map.put("recom",rResult);
		map.put("cal", boardService.selectBoardOne(bcode).getPoint().getCal());

		return map;
	}
	
	@ResponseBody
    @RequestMapping(value = "crecommendation.do", method = RequestMethod.GET)
	public HashMap crecommendation(String recom,int ccode,HttpSession session) 
	{
		logger.info("crecommendation("+recom+","+ccode+") call...");

		boardService.crecommendation(recom,ccode);
		Member member=memberService.selectMember(((Member)session.getAttribute("member")).getId());
		
		HashMap map=new HashMap();
		
		int rResult=-1;
		
		switch(recom) 
		{
			case "good":
				rResult=commentsService.selectCommentsOne(ccode).getPoint().getGood();
				memberService.recomcount3(member.getMembercode());
				break;
			case "bad":
				rResult=commentsService.selectCommentsOne(ccode).getPoint().getBad();
				memberService.recomcount3(member.getMembercode());
				break;
		}
		
		map.put("point", memberService.selectMember(member.getId()).getRecompoint());
		map.put("recom",rResult);
		map.put("cal", commentsService.selectCommentsOne(ccode).getPoint().getCal());
		
		return map;
	}
    
    @ResponseBody
    @RequestMapping(value = "bmedal.do", method = RequestMethod.GET)
	public Integer bmedal(int bcode,int membercode) 
	{
		logger.info("bmedal("+bcode+") call...");

		boardService.bmedal(bcode);
		
		memberService.givemedal(membercode);
		
		return boardService.selectBoardOne(bcode).getPoint().getMedal();
	}
    
    @ResponseBody
    @RequestMapping(value = "cmedal.do", method = RequestMethod.GET)
	public Integer cmedal(int ccode,int membercode) 
	{
		logger.info("cmedal("+ccode+") call...");

		boardService.cmedal(ccode);		
		
		memberService.givemedal(membercode);
		
		return commentsService.selectCommentsOne(ccode).getPoint().getMedal();
	}
    
    @ResponseBody
    @RequestMapping(value = "isbreport.do", method = RequestMethod.POST)
	public Integer isbreport(int bcode,HttpSession session,HttpServletResponse response) 
	{
		logger.info("isbreport("+bcode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
			
		return boardService.isbreport(bcode,reporter);
	}    
    
    @ResponseBody
    @RequestMapping(value = "breport.do", method = RequestMethod.GET)
	public void breport(int bcode,HttpSession session) 
	{
		logger.info("breport("+bcode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
		
		boardService.breport(bcode,reporter);
	}
    
    @ResponseBody
    @RequestMapping(value = "iscreport.do", method = RequestMethod.POST)
	public Integer iscreport(int ccode,HttpSession session,HttpServletResponse response) 
	{
		logger.info("iscreport("+ccode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
			
		return commentsService.iscreport(ccode,reporter);
	}    
    
    @ResponseBody
    @RequestMapping(value = "creport.do", method = RequestMethod.GET)
	public void creport(int ccode,HttpSession session) 
	{
		logger.info("creport("+ccode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
		
		commentsService.creport(ccode,reporter);
	}
    
    @ResponseBody
    @RequestMapping(value = "viewcount.do", method = RequestMethod.GET)
	public void viewcount(int bcode) 
	{
		logger.info("viewcount("+bcode+") call...");
		
		boardService.viewcount(bcode);
	}
  
    @RequestMapping("filedown.do")//URL호출
    public void filedown(int atcode,HttpServletResponse response) throws Exception
    {         
    	logger.info("filedown("+atcode+") call...");
    	
    	Attachfile file=attachfileService.selectFileOne(atcode);
    	
    	String path = file.getFilelink();
         
        String docName = URLEncoder.encode(file.getOriginname(),"UTF-8").replaceAll("\\+", "%20"); //한글파일명 깨지지 않도록
        response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
        response.setContentType("text/plain");
     
        File down_file = new File(path); //파일 생성
        FileInputStream fileIn = new FileInputStream(down_file); //파일 읽어오기
        response.getOutputStream().write(IOUtils.toByteArray(fileIn));
        response.flushBuffer();     
    }
}
