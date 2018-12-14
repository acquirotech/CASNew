package com.acq.users.entity;

public class AcqPrepaidInventoryDeviceEntity {

	
	private Long id;
	private String kitNo;
	private String cardNo;	
	private String cardType;
	private String dateTime;
	private String status;
	
	
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getKitNo() {
		return kitNo;
	}
	public void setKitNo(String kitNo) {
		this.kitNo = kitNo;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}	
	
	
}
