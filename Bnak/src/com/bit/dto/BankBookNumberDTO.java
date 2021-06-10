package com.bit.dto;

public class BankBookNumberDTO {

	//외래키
	private BankbookDTO bankbook;
	
	private int bn_plus=0;
	private int bn_minus=0;
	private int bn_sum=0;
	private String bn_commit="";
	private String bn_date=null;
	
	
	
	public BankBookNumberDTO() {
		super();
	}
	
	
	public BankBookNumberDTO(BankbookDTO bankbook, int bn_plus, int bn_minus, int bn_sum, String bn_commit,
			String bn_date) {
		super();
		this.bankbook = bankbook;
		this.bn_plus = bn_plus;
		this.bn_minus = bn_minus;
		this.bn_sum = bn_sum;
		this.bn_commit = bn_commit;
		this.bn_date = bn_date;
	}
	public BankbookDTO getBankbook() {
		return bankbook;
	}
	public void setBankbook(BankbookDTO bankbook) {
		this.bankbook = bankbook;
	}
	public int getBn_plus() {
		return bn_plus;
	}
	public void setBn_plus(int bn_plus) {
		this.bn_plus = bn_plus;
	}
	public int getBn_minus() {
		return bn_minus;
	}
	public void setBn_minus(int bn_minus) {
		this.bn_minus = bn_minus;
	}
	public int getBn_sum() {
		return bn_sum;
	}
	public void setBn_sum(int bn_sum) {
		this.bn_sum = bn_sum;
	}
	public String getBn_commit() {
		return bn_commit;
	}
	public void setBn_commit(String bn_commit) {
		this.bn_commit = bn_commit;
	}
	public String getBn_date() {
		return bn_date;
	}
	public void setBn_date(String bn_date) {
		this.bn_date = bn_date;
	}
	
	
}
