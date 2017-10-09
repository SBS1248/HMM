package com.kh.hmm.board.model.vo;

import java.sql.Date;

public class Board
{
	private int bcode;
	private String title;
	private String content;
	private int distinguish;
	private String writerid;
	private String postdate;
	private String isdelete;
	private String hasfile;
	
	private BoardCode code;	
	private BoardPoint point;	
	
	public Board() {}

	public Board(int bcode, String title, String content, int distinguish, String writerid, String postdate,
			String isdelete, String hasfile, BoardCode code, BoardPoint point)
	{
		super();
		this.bcode = bcode;
		this.title = title;
		this.content = content;
		this.distinguish = distinguish;
		this.writerid = writerid;
		this.postdate = postdate;
		this.isdelete = isdelete;
		this.hasfile = hasfile;
		this.code = code;
		this.point = point;
	}

	public int getBcode()
	{
		return bcode;
	}

	public void setBcode(int bcode)
	{
		this.bcode = bcode;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public int getDistinguish()
	{
		return distinguish;
	}

	public void setDistinguish(int distinguish)
	{
		this.distinguish = distinguish;
	}

	public String getWriterid()
	{
		return writerid;
	}

	public void setWriterid(String writerid)
	{
		this.writerid = writerid;
	}

	public String getPostdate()
	{
		return postdate;
	}

	public void setPostdate(String postdate)
	{
		this.postdate = postdate;
	}

	public String getIsdelete()
	{
		return isdelete;
	}

	public void setIsdelete(String isdelete)
	{
		this.isdelete = isdelete;
	}

	public String getHasfile()
	{
		return hasfile;
	}

	public void setHasfile(String hasfile)
	{
		this.hasfile = hasfile;
	}

	public BoardCode getCode()
	{
		return code;
	}

	public void setCode(BoardCode code)
	{
		this.code = code;
	}

	public BoardPoint getPoint()
	{
		return point;
	}

	public void setPoint(BoardPoint point)
	{
		this.point = point;
	}

	@Override
	public String toString()
	{
		return "Board [bcode=" + bcode + ", title=" + title + ", content=" + content + ", distinguish=" + distinguish
				+ ", writerid=" + writerid + ", postdate=" + postdate + ", isdelete=" + isdelete + ", hasfile="
				+ hasfile + ", code=" + code + ", point=" + point + "]";
	}

	
	

	
}
