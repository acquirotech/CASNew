package com.acq.users.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

public class AcqUser {
	private Long userId;
	private String userName;
	private String password;
	private String emailId;
	private Long loginId;
	private Long orgId;
	private Long rmn;
	private Date date;
	private String userStatus;

	private String loyaltyStatus;
	private String closeWalletStatus;
	private String txnSmsStatus;
	
	private String aquirerCode;

	private String switchType;
	
	private String rechargeServiceEnable;
	
	private String ppcServiceEnable;
	private String dmtServiceEnable;
	private String dthMobileServiceEnable;
	
	
	public String getPpcServiceEnable() {
		return ppcServiceEnable;
	}
	public void setPpcServiceEnable(String ppcServiceEnable) {
		this.ppcServiceEnable = ppcServiceEnable;
	}
	public String getDmtServiceEnable() {
		return dmtServiceEnable;
	}
	public void setDmtServiceEnable(String dmtServiceEnable) {
		this.dmtServiceEnable = dmtServiceEnable;
	}
	public String getDthMobileServiceEnable() {
		return dthMobileServiceEnable;
	}
	public void setDthMobileServiceEnable(String dthMobileServiceEnable) {
		this.dthMobileServiceEnable = dthMobileServiceEnable;
	}
	public String getRechargeServiceEnable() {
		return rechargeServiceEnable;
	}
	public void setRechargeServiceEnable(String rechargeServiceEnable) {
		this.rechargeServiceEnable = rechargeServiceEnable;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	public String getLoyaltyStatus() {
		return loyaltyStatus;
	}
	public void setLoyaltyStatus(String loyaltyStatus) {
		this.loyaltyStatus = loyaltyStatus;
	}
	public String getCloseWalletStatus() {
		return closeWalletStatus;
	}
	public void setCloseWalletStatus(String closeWalletStatus) {
		this.closeWalletStatus = closeWalletStatus;
	}
	public String getTxnSmsStatus() {
		return txnSmsStatus;
	}
	public void setTxnSmsStatus(String txnSmsStatus) {
		this.txnSmsStatus = txnSmsStatus;
	}
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	public String getSwitchType() {
		return switchType;
	}
	public void setSwitchType(String switchType) {
		this.switchType = switchType;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Long getRmn() {
		return rmn;
	}
	public void setRmn(Long rmn) {
		this.rmn = rmn;
	}
	private AcqDevice AcqDevice;
	public AcqUser(){}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public Long getOrgId() {
		return orgId;
	}
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	public Long getLoginId() {
		return loginId;
	}
	public void setLoginId(Long loginId) {
		this.loginId = loginId;
	}
	public AcqDevice getAcqDevice() {
		return AcqDevice;
	}
	public void setAcqDevice(AcqDevice AcqDevice) {
		this.AcqDevice = AcqDevice;
	}
	
}
