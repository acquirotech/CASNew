package com.acq.users.entity;

public class AcqCardListEntity {

	private Long id;
	private Long transactionId;
	private String authCode;
	private String cardType;
	private String rrNo;
	
	public String getRrNo() {
		return rrNo;
	}
	public void setRrNo(String rrNo) {
		this.rrNo = rrNo;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(Long transactionId) {
		this.transactionId = transactionId;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	
	
}
