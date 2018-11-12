package com.acq.users.entity;

import java.math.BigDecimal;

import javax.persistence.Column;

public class AcqMdrEntity {

	
	private Integer txnId;
	private Integer userId;
	private String cardPanNo;
	
	private BigDecimal bankMdr;
	private BigDecimal AcqMdr;
	private String txnType;
	
	@Column(name = "PAYOUTSTATUS")
	private String payoutStatus;
	
	@Column(name="AGSPAYOUTSTS")
	private int  agsPayoutSts;

	@Column(name="AQUIRER_MDR")
	private BigDecimal acquirerMdr;
	
	@Column(name="AQUIRER_CODE")
	private String acquirerCode;
	
	
	public String getPayoutStatus() {
		return payoutStatus;
	}
	public void setPayoutStatus(String payoutStatus) {
		this.payoutStatus = payoutStatus;
	}
	public int getAgsPayoutSts() {
		return agsPayoutSts;
	}
	public void setAgsPayoutSts(int agsPayoutSts) {
		this.agsPayoutSts = agsPayoutSts;
	}
	public BigDecimal getAcquirerMdr() {
		return acquirerMdr;
	}
	public void setAcquirerMdr(BigDecimal acquirerMdr) {
		this.acquirerMdr = acquirerMdr;
	}
	public String getAcquirerCode() {
		return acquirerCode;
	}
	public void setAcquirerCode(String acquirerCode) {
		this.acquirerCode = acquirerCode;
	}
	public Integer getTxnId() {
		return txnId;
	}
	public String getTxnType() {
		return txnType;
	}
	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public BigDecimal getAcqMdr() {
		return AcqMdr;
	}
	public void setAcqMdr(BigDecimal AcqMdr) {
		this.AcqMdr = AcqMdr;
	}
	public void setTxnId(Integer txnId) {
		this.txnId = txnId;
	}
	public String getCardPanNo() {
		return cardPanNo;
	}
	public void setCardPanNo(String cardPanNo) {
		this.cardPanNo = cardPanNo;
	}
	
	public BigDecimal getBankMdr() {
		return bankMdr;
	}
	public void setBankMdr(BigDecimal bankMdr) {
		this.bankMdr = bankMdr;
	}	
}
