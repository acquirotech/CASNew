package com.acq.users.entity;

import java.sql.Timestamp;

import javax.persistence.Column;

public class AcqTransactionListEntity {

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
	private String aquirerCode;	
	
	private String acquirerMdr;
	
	private String agsPayoutStatus;	
	private AcqCardListEntity AcqCardListEntity;
	
	
	
	
	
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	public String getAcquirerMdr() {
		return acquirerMdr;
	}
	public void setAcquirerMdr(String acquirerMdr) {
		this.acquirerMdr = acquirerMdr;
	}
	public String getAgsPayoutStatus() {
		return agsPayoutStatus;
	}
	public void setAgsPayoutStatus(String agsPayoutStatus) {
		this.agsPayoutStatus = agsPayoutStatus;
	}
	public AcqCardListEntity getAcqCardListEntity() {
		return AcqCardListEntity;
	}
	public void setAcqCardListEntity(AcqCardListEntity AcqCardListEntity) {
		this.AcqCardListEntity = AcqCardListEntity;
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
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getStatusDescription() {
		return statusDescription;
	}
	public void setStatusDescription(String statusDescription) {
		this.statusDescription = statusDescription;
	}
	public String getTxnType() {
		return txnType;
	}
	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}
	public String getCardPanNo() {
		return cardPanNo;
	}
	public void setCardPanNo(String cardPanNo) {
		this.cardPanNo = cardPanNo;
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
}
