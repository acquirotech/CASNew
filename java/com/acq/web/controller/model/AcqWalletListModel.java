package com.acq.web.controller.model;
public class AcqWalletListModel {

	private String walletId;
	
	private String walletMobileNo;	
	private String walletAmount;
	private String walletEmail;
	private String walletStatus;
	private String walletDateTime;
	private String page;
	
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getWalletId() {
		return walletId;
	}
	public void setWalletId(String walletId) {
		this.walletId = walletId;
	}
	public String getWalletMobileNo() {
		return walletMobileNo;
	}
	public void setWalletMobileNo(String walletMobileNo) {
		this.walletMobileNo = walletMobileNo;
	}
	public String getWalletAmount() {
		return walletAmount;
	}
	public void setWalletAmount(String walletAmount) {
		this.walletAmount = walletAmount;
	}
	public String getWalletEmail() {
		return walletEmail;
	}
	public void setWalletEmail(String walletEmail) {
		this.walletEmail = walletEmail;
	}
	public String getWalletStatus() {
		return walletStatus;
	}
	public void setWalletStatus(String walletStatus) {
		this.walletStatus = walletStatus;
	}
	public String getWalletDateTime() {
		return walletDateTime;
	}
	public void setWalletDateTime(String walletDateTime) {
		this.walletDateTime = walletDateTime;
	}
	
}