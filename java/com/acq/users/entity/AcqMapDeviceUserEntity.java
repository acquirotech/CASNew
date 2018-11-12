package com.acq.users.entity;

public class AcqMapDeviceUserEntity {
	
	private Long id;
	private Long userId;
	private String userPhone;
	private String mdrDebit1;
	private String mdrDebit2;
	private String mdrCreditNPRE;
	private String mdrCreditPRE;
	private String mdrAMEX;
	private String other;
	
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getMdrDebit1() {
		return mdrDebit1;
	}
	public void setMdrDebit1(String mdrDebit1) {
		this.mdrDebit1 = mdrDebit1;
	}
	public String getMdrDebit2() {
		return mdrDebit2;
	}
	public void setMdrDebit2(String mdrDebit2) {
		this.mdrDebit2 = mdrDebit2;
	}
	public String getMdrCreditNPRE() {
		return mdrCreditNPRE;
	}
	public void setMdrCreditNPRE(String mdrCreditNPRE) {
		this.mdrCreditNPRE = mdrCreditNPRE;
	}
	public String getMdrCreditPRE() {
		return mdrCreditPRE;
	}
	public void setMdrCreditPRE(String mdrCreditPRE) {
		this.mdrCreditPRE = mdrCreditPRE;
	}
	public String getMdrAMEX() {
		return mdrAMEX;
	}
	public void setMdrAMEX(String mdrAMEX) {
		this.mdrAMEX = mdrAMEX;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	
}
