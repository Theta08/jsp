package com.bit.dto;

public class UserDTO {

	private String userID;
	private String userPW;
	private String userName="";
	private String date;
	
	
	//생성자
	public UserDTO() {
		
	}


	public UserDTO(String userID, String userPW, String userName, String date) {
		super();
		this.userID = userID;
		this.userPW = userPW;
		this.userName = userName;
		this.date = date;
	}

	//getter,setter
	public String getUserID() {
		return userID;
	}



	public void setUserID(String userID) {
		this.userID = userID;
	}



	public String getUserPW() {
		return userPW;
	}



	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getDate() {
		return date;
	}



	public void setDate(String date) {
		this.date = date;
	}
	
	
}
