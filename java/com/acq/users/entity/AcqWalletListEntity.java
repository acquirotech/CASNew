package com.acq.users.entity;

import java.sql.Timestamp;

import javax.persistence.Column;

public class AcqWalletListEntity {

	private Long walletId;
	
	private String walletMobileNo;	
	private String walletAmount;
	private String walletEmail;
	private String walletStatus;
	private String walletDateTime;
	private String walletAcqMdr;
	private String walletBankMdr;
	private String serviceTax;
	private Long merchantId;
	private Long orgId;
	private Long userId;
	private String page;
	private String statusDescription;
	private String txnType;
	private String cardPanNo;
	private int payoutStatus;
	private Timestamp  payoutDateTime;
	private String acquirerCode;
	
	@Column(name = "AQUIRER_MDR")
	private String aquirerMdr;
	
	@Column(name = "ACQ_PAYOUT_STATUS") 
	private String aquirerPayoutStatus;  
	
	@Column(name = "ACQ_PAYOUT_DATETIME") 
	private Timestamp aquirerPayoutDateTime;
	
	@Column(name = "SYSTMUTLTYFEE")
	private String systmUtltyFee;
	
	
	
	public String getAcquirerCode() {
		return acquirerCode;
	}
	public void setAcquirerCode(String acquirerCode) {
		this.acquirerCode = acquirerCode;
	}
	public String getAquirerMdr() {
		return aquirerMdr;
	}
	public void setAquirerMdr(String aquirerMdr) {
		this.aquirerMdr = aquirerMdr;
	}
	public String getAquirerPayoutStatus() {
		return aquirerPayoutStatus;
	}
	public void setAquirerPayoutStatus(String aquirerPayoutStatus) {
		this.aquirerPayoutStatus = aquirerPayoutStatus;
	}
	public Timestamp getAquirerPayoutDateTime() {
		return aquirerPayoutDateTime;
	}
	public void setAquirerPayoutDateTime(Timestamp aquirerPayoutDateTime) {
		this.aquirerPayoutDateTime = aquirerPayoutDateTime;
	}
	public String getSystmUtltyFee() {
		return systmUtltyFee;
	}
	public void setSystmUtltyFee(String systmUtltyFee) {
		this.systmUtltyFee = systmUtltyFee;
	}
	public int getPayoutStatus() {
		return payoutStatus;
	}
	public void setPayoutStatus(int payoutStatus) {
		this.payoutStatus = payoutStatus;
	}
	public Timestamp getPayoutDateTime() {
		return payoutDateTime;
	}
	public void setPayoutDateTime(Timestamp payoutDateTime) {
		this.payoutDateTime = payoutDateTime;
	}
	
	
	public String getCardPanNo() {
		return cardPanNo;
	}
	public void setCardPanNo(String cardPanNo) {
		this.cardPanNo = cardPanNo;
	}
	public String getTxnType() {
		return txnType;
	}
	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}
	public String getStatusDescription() {
		return statusDescription;
	}
	public void setStatusDescription(String statusDescription) {
		this.statusDescription = statusDescription;
	}
	public String getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(String serviceTax) {
		this.serviceTax = serviceTax;
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
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getWalletAcqMdr() {
		return walletAcqMdr;
	}
	public void setWalletAcqMdr(String walletAcqMdr) {
		this.walletAcqMdr = walletAcqMdr;
	}
	public String getWalletBankMdr() {
		return walletBankMdr;
	}
	public void setWalletBankMdr(String walletBankMdr) {
		this.walletBankMdr = walletBankMdr;
	}
	public Long getWalletId() {
		return walletId;
	}
	public void setWalletId(Long walletId) {
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
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	
	
}
