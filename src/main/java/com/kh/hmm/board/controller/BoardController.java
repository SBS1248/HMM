package com.kh.hmm.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	public String boardCode(Model m) 
	{//아작스 처리를 요한다.
		logger.info("boarCode() call...");
		System.out.println(boardService.boardCode());
		m.addAttribute("bcode",boardService.boardCode());
		
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
     
    @RequestMapping(value = "fileUp.do") //ajax에서 호출하는 부분
    @ResponseBody
    public String upload(MultipartHttpServletRequest multipartRequest,int bcode) 
    { //Multipart로 받는다.
    	logger.info("upload("+bcode+") call...");  
        Iterator<String> itr =  multipartRequest.getFileNames();
         
        String filePath = "C:\\hmm\\Hmm\\src\\main\\webapp\\fileUpload\\post"; //설정파일로 뺀다.
        
        while (itr.hasNext()) 
        { //받은 파일들을 모두 돌린다.            
            MultipartFile mpf = multipartRequest.getFile(itr.next());
      
            String originname = mpf.getOriginalFilename(); //파일명
            String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date(new java.util.Date().getTime()));
            String changedname=now+originname;
            String fileFullPath = filePath+"/"+changedname; //파일 전체 경로
            
            Attachfile file=new Attachfile();
            file.setOriginname(originname);
            file.setChangedname(changedname);
            file.setFilelink(fileFullPath);
            file.setBcode(bcode);
            System.out.println(file);
            
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
    @RequestMapping(value="write.do", method = RequestMethod.POST)
    public String write(Board b,Model m){
    	int write = boardService.writeService(b);
		
		
		return "redirect:/boardLists.do?dis="+b.getDistinguish();
    }

	@ResponseBody
    @RequestMapping(value = "recommendation.do", method = RequestMethod.GET)
	public Integer recommendation(String recom,int bcode,HttpSession session) 
	{
		logger.info("recommendation("+recom+","+bcode+") call...");

		boardService.recommendation(recom,bcode);
		int point=memberService.selectMember(((Member)session.getAttribute("member")).getId()).getRecompoint();
		
		return point;
	}
    
    @RequestMapping(value = "crecommendation.do", method = RequestMethod.GET)
	public String crecommendation(String recom,int ccode,int bcode) 
	{
		logger.info("crecommendation("+recom+","+ccode+","+bcode+") call...");

		boardService.crecommendation(recom,ccode);
		
		return "forward:boardOne.do?bcode="+bcode;
	}
    
    @RequestMapping(value = "bmedal.do", method = RequestMethod.GET)
	public String bmedal(int bcode) 
	{
		logger.info("bmedal("+bcode+") call...");

		boardService.bmedal(bcode);
		
		return "forward:boardOne.do?bcode="+bcode;
	}
    
    @RequestMapping(value = "cmedal.do", method = RequestMethod.GET)
	public String cmedal(int ccode,int bcode) 
	{
		logger.info("cmedal("+bcode+","+ccode+") call...");

		boardService.cmedal(ccode);
		
		return "forward:boardOne.do?bcode="+bcode;
	}
    
    @ResponseBody
    @RequestMapping(value = "isbreport.do", method = RequestMethod.POST)
	public Integer isbreport(int bcode,HttpSession session,HttpServletResponse response) 
	{
		logger.info("isbreport("+bcode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
			
		return boardService.isbreport(bcode,reporter);
	}    
    
    @RequestMapping(value = "breport.do", method = RequestMethod.GET)
	public String breport(int bcode,HttpSession session) 
	{
		logger.info("breport("+bcode+") call...");
		String reporter=((Member)session.getAttribute("member")).getId();
		
		boardService.breport(bcode,reporter);
		
		return "forward:boardOne.do?bcode="+bcode;
	}
    
}
