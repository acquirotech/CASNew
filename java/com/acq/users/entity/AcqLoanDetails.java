package com.acq.users.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

public class AcqLoanDetails {
	
	private Integer id;
	
	private String bankTid;

	private Long userId;
	
	private Long merchantId;
	
	private Long orgId;
		 
	private String loanBankAccNo;
	 
	private String loanBankIfsc;
		
	private String loanBankName;
	
	private Timestamp dateTime;
	
	private Timestamp updatedOn;

	private String aquirerCode;
	
	
	public String getAquirerCode() {
		return aquirerCode;
	}

	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Timestamp getDateTime() {
		return dateTime;
	}

	public void setDateTime(Timestamp dateTime) {
		this.dateTime = dateTime;
	}

	public Timestamp getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Timestamp updatedOn) {
		this.updatedOn = updatedOn;
	}

	public String getBankTid() {
		return bankTid;
	}

	public void setBankTid(String bankTid) {
		this.bankTid = bankTid;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Long merchantId) {
		this.merchantId = merchantId;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getLoanBankAccNo() {
		return loanBankAccNo;
	}

	public void setLoanBankAccNo(String loanBankAccNo) {
		this.loanBankAccNo = loanBankAccNo;
	}

	public String getLoanBankIfsc() {
		return loanBankIfsc;
	}

	public void setLoanBankIfsc(String loanBankIfsc) {
		this.loanBankIfsc = loanBankIfsc;
	}

	public String getLoanBankName() {
		return loanBankName;
	}

	public void setLoanBankName(String loanBankName) {
		this.loanBankName = loanBankName;
	}
}
