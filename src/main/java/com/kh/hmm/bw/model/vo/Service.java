package com.kh.hmm.bw.model.vo;

public class Service {
	
	private String sername;
	private String seradd;
	private String sercontent;
	private char yncheck;
	
	public Service(){}

	public Service(String sername, String seradd, String sercontent, char yncheck) {
		super();
		this.sername = sername;
		this.seradd = seradd;
		this.sercontent = sercontent;
		this.yncheck = yncheck;
	}
	
	public String getSername() {
		return sername;
	}

	public void setSername(String sername) {
		this.sername = sername;
	}

	public String getSeradd() {
		return seradd;
	}

	public void setSeradd(String seradd) {
		this.seradd = seradd;
	}

	public String getSercontent() {
		return sercontent;
	}

	public void setSercontent(String sercontent) {
		this.sercontent = sercontent;
	}

	public char getYncheck() {
		return yncheck;
	}

	public void setYncheck(char yncheck) {
		this.yncheck = yncheck;
	}



	@Override
	public String toString() {
		return "Service [sername=" + sername + ", seradd=" + seradd + ", sercontent=" + sercontent + ", yncheck="
				+ yncheck + "]";
	}
	
	
}

