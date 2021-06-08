package com.bit.dto;
//이름 변경시 오류났음
//오류해결: BankbookDTO의 생성자 super();를 지우면 오류 해결

public class BankbookDTO {
	
	//수정 필요
	private int bnumber;
	private String bname;
	private int bpassword;
	private String bdate;
	
	public BankbookDTO() {
		
	}
	
	public BankbookDTO(int bnumber, String bname, int bpassword, String bdate) {
		this.bnumber = bnumber;
		this.bname = bname;
		this.bpassword = bpassword;
		this.bdate = bdate;
	}
	
	public int getBnumber() {
		return bnumber;
	}
	public void setBnumber(int bnumber) {
		this.bnumber = bnumber;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getBpassword() {
		return bpassword;
	}
	public void setBpassword(int bpassword) {
		this.bpassword = bpassword;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	
	
	
}
