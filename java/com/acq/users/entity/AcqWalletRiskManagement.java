package com.acq.users.entity;

public class AcqWalletRiskManagement {
	private int id;
	private int txnId;
	private String description;
	private String status;
	private String dateTime;
	private String aquirerCode;
	
	
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTxnId() {
		return txnId;
	}
	public void setTxnId(int txnId) {
		this.txnId = txnId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;	
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
