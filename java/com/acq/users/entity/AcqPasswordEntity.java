package com.acq.users.entity;

public class AcqPasswordEntity {
	private Long userId;
	private String passwd1;
	private String passwd2;
	private String passwd3;
	private String lastUpdatedOn;
	
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getPasswd1() {
		return passwd1;
	}
	public void setPasswd1(String passwd1) {
		this.passwd1 = passwd1;
	}
	public String getPasswd2() {
		return passwd2;
	}
	public void setPasswd2(String passwd2) {
		this.passwd2 = passwd2;
	}
	public String getPasswd3() {
		return passwd3;
	}
	public void setPasswd3(String passwd3) {
		this.passwd3 = passwd3;
	}
	public String getLastUpdatedOn() {
		return lastUpdatedOn;
	}
	public void setLastUpdatedOn(String lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
}
