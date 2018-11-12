package com.acq.users.entity;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.acq.users.model.AcqOrganization;


public class AcqAppUser {
	private Long userId;
	private String userName;
	private String password;
	private Long loginId;
	private String emailId;
	private Long rmn;
	private Date date;
	private String userStatus;

	private String loyaltyStatus;
	private String closeWalletStatus;
	private String txnSmsStatus;
	
	private String aquirerCode;

	private String switchType;
		
	
	 private String rechargeServiceEnable;
    
	
	
	public String getRechargeServiceEnable() {
		return rechargeServiceEnable;
	}
	public void setRechargeServiceEnable(String rechargeServiceEnable) {
		this.rechargeServiceEnable = rechargeServiceEnable;
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
	public Date getDate() {
		return date;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	public String getTxnSmsStatus() {
		return txnSmsStatus;
	}
	public void setTxnSmsStatus(String txnSmsStatus) {
		this.txnSmsStatus = txnSmsStatus;
	}
	public Long getRmn() {
		return rmn;
	}
	public void setRmn(Long rmn) {
		this.rmn = rmn;
	}
	private Long organizationId;
		private AcqOrganization organization;
	
	private AcqDeviceMapUser deviceMapUser;
	
	public AcqAppUser(){}
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
	
	public Long getLoginId() {
		return loginId;
	}
	public void setLoginId(Long loginId) {
		this.loginId = loginId;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public Long getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}
	public AcqOrganization getOrganization() {
		return organization;
	}
	public void setOrganization(AcqOrganization organization) {
		this.organization = organization;
	}
	public AcqDeviceMapUser getDeviceMapUser() {
		return deviceMapUser;
	}
	public void setDeviceMapUser(AcqDeviceMapUser deviceMapUser) {
		this.deviceMapUser = deviceMapUser;
	}
}
