package com.acq.users.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

public class AcqMobikwikEntity {	
	
	private int id;
	
	private Integer merchantId;
	
	private Integer orgId;
	
	private Integer userid;
	
	private String mobile;
	
	private String amount;
	
	private String email;
	
	private int status;
	
	private String AcqMdr;
	
	private String bankMdr;
	
	private String serviceTax;
	
	
	private Timestamp dateTime;
	
	private Timestamp otpDateTime;
	
	private String description;
	
	private String txnType;
	private String carPanNo;
	private String customerId;
	private int payoutStatus;
	private Timestamp payoutDateTime;
	private String switchLab;
	
	private String acquirer;
	
	private String acquirerMdr;
	
	private String cashBackAmt;
	
	private int acqPayoutStatus;
	
	private Timestamp acqPayoutDateTime;
	
	private String appCertificate;
	
	private String aid;
	
	public AcqMobikwikEntity(){}
	public AcqMobikwikEntity(String mobile, String amount,int status,Timestamp dateTime) {
		super();
		this.mobile = mobile;
		this.amount = amount;
		this.status = status;
		this.dateTime = dateTime;
	}
	
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getSwitchLab() {
		return switchLab;
	}
	public void setSwitchLab(String switchLab) {
		this.switchLab = switchLab;
	}
	public String getAcquirer() {
		return acquirer;
	}
	public void setAcquirer(String acquirer) {
		this.acquirer = acquirer;
	}
	public String getAcquirerMdr() {
		return acquirerMdr;
	}
	public void setAcquirerMdr(String acquirerMdr) {
		this.acquirerMdr = acquirerMdr;
	}
	public String getCashBackAmt() {
		return cashBackAmt;
	}
	public void setCashBackAmt(String cashBackAmt) {
		this.cashBackAmt = cashBackAmt;
	}
	public int getAcqPayoutStatus() {
		return acqPayoutStatus;
	}
	public void setAcqPayoutStatus(int acqPayoutStatus) {
		this.acqPayoutStatus = acqPayoutStatus;
	}
	public Timestamp getAcqPayoutDateTime() {
		return acqPayoutDateTime;
	}
	public void setAcqPayoutDateTime(Timestamp acqPayoutDateTime) {
		this.acqPayoutDateTime = acqPayoutDateTime;
	}
	public String getAppCertificate() {
		return appCertificate;
	}
	public void setAppCertificate(String appCertificate) {
		this.appCertificate = appCertificate;
	}
	public String getCarPanNo() {
		return carPanNo;
	}
	public void setCarPanNo(String carPanNo) {
		this.carPanNo = carPanNo;
	}
	public String getTxnType() {
		return txnType;
	}
	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}
	public String getAcqMdr() {
		return AcqMdr;
	}
	public void setAcqMdr(String AcqMdr) {
		this.AcqMdr = AcqMdr;
	}
	public String getBankMdr() {
		return bankMdr;
	}
	public void setBankMdr(String bankMdr) {
		this.bankMdr = bankMdr;
	}
	public String getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(String serviceTax) {
		this.serviceTax = serviceTax;
	}
	
	public Integer getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	public Integer getOrgId() {
		return orgId;
	}
	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Timestamp getOtpDateTime() {
		return otpDateTime;
	}
	public void setOtpDateTime(Timestamp otpDateTime) {
		this.otpDateTime = otpDateTime;
	}
	public Timestamp getDateTime() {
		return dateTime;
	}
	public void setDateTime(Timestamp dateTime) {
		this.dateTime = dateTime;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	public Timestamp getPayoutDateTime() {
		return payoutDateTime;
	}
	public void setPayoutDateTime(Timestamp payoutDateTime) {
		this.payoutDateTime = payoutDateTime;
	}
	public int getPayoutStatus() {
		return payoutStatus;
	}
	public void setPayoutStatus(int payoutStatus) {
		this.payoutStatus = payoutStatus;
	}
	
	
}
