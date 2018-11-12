package com.acq.users.model;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.validation.constraints.Pattern;

public class AcqDevice {
	private Long id;
	private String serialNo;
	private String bankTId;
	private String userType;
	private Long userId;
	private BigDecimal mdrZero;
	
	private BigDecimal mdrDebit1;
	private BigDecimal mdrDebit2;
	private BigDecimal mdrCreditNpre;
	private BigDecimal mdrCreditPre;
	private BigDecimal mdrAmex;
	private BigDecimal other;
	private BigDecimal mdrMobikwik;
	private String bankAccName;
	private String bankAccNo;
	private String bankName;
	private String bankBranch;
	private String bankIfsc;
	private String bankMicr;
	private BigDecimal rent;
	private String paymentMode;
	private String amexActivated;
	private String amexTID;
	private String amexMID;
	private BigDecimal pendingRent;
	private String validTil;
	private AcqUser appUser;
	private BigDecimal penaltyAmount;
	private BigDecimal discount;
	private BigDecimal avgTxnAmount;	
	private BigDecimal mdrCashAtPos;
	private String benefName;
	private String penaltyReason;
	private String discountReason;
	private String integrationKey;
private String loanDedAmount;
	private BigDecimal settlementCharges;
	
	private String loanStatus;
	 
	private String loanType;
	
	private String acquirerCode;
	
	private String activationDate;
	
	private String planName;
	
	private String feeMode;
	
	private String feeAmount;
	
	private String feeDate;
	
	private String feeRemarks;
	
	private String benId;
	
	private String midTidEntryDate;
	
	private String wlcmLtrSendDate;
	
	
	private BigDecimal rechargeBal;
	private BigDecimal rechargeIncentive;
	private BigDecimal rechargeMonthlyRental;
	
	
	public BigDecimal getRechargeBal() {
		return rechargeBal;
	}
	public void setRechargeBal(BigDecimal rechargeBal) {
		this.rechargeBal = rechargeBal;
	}
	public BigDecimal getRechargeIncentive() {
		return rechargeIncentive;
	}
	public void setRechargeIncentive(BigDecimal rechargeIncentive) {
		this.rechargeIncentive = rechargeIncentive;
	}
	public BigDecimal getRechargeMonthlyRental() {
		return rechargeMonthlyRental;
	}
	public void setRechargeMonthlyRental(BigDecimal rechargeMonthlyRental) {
		this.rechargeMonthlyRental = rechargeMonthlyRental;
	}
	public BigDecimal getSettlementCharges() {
		return settlementCharges;
	}
	public void setSettlementCharges(BigDecimal settlementCharges) {
		this.settlementCharges = settlementCharges;
	}
	public String getLoanDedAmount() {
		return loanDedAmount;
	}
	public void setLoanDedAmount(String loanDedAmount) {
		this.loanDedAmount = loanDedAmount;
	}
	public String getLoanStatus() {
		return loanStatus;
	}
	public void setLoanStatus(String loanStatus) {
		this.loanStatus = loanStatus;
	}
	public String getLoanType() {
		return loanType;
	}
	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}
	public String getAcquirerCode() {
		return acquirerCode;
	}
	public void setAcquirerCode(String acquirerCode) {
		this.acquirerCode = acquirerCode;
	}
	public String getActivationDate() {
		return activationDate;
	}
	public void setActivationDate(String activationDate) {
		this.activationDate = activationDate;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getFeeMode() {
		return feeMode;
	}
	public void setFeeMode(String feeMode) {
		this.feeMode = feeMode;
	}
	public String getFeeAmount() {
		return feeAmount;
	}
	public void setFeeAmount(String feeAmount) {
		this.feeAmount = feeAmount;
	}
	public String getFeeDate() {
		return feeDate;
	}
	public void setFeeDate(String feeDate) {
		this.feeDate = feeDate;
	}
	

	
	public BigDecimal getMdrZero() {
		return mdrZero;
	}
	public void setMdrZero(BigDecimal mdrZero) {
		this.mdrZero = mdrZero;
	}
	
	public String getFeeRemarks() {
		return feeRemarks;
	}
	public void setFeeRemarks(String feeRemarks) {
		this.feeRemarks = feeRemarks;
	}
	public String getBenId() {
		return benId;
	}
	public void setBenId(String benId) {
		this.benId = benId;
	}
	public String getMidTidEntryDate() {
		return midTidEntryDate;
	}
	public void setMidTidEntryDate(String midTidEntryDate) {
		this.midTidEntryDate = midTidEntryDate;
	}
	public String getWlcmLtrSendDate() {
		return wlcmLtrSendDate;
	}
	public void setWlcmLtrSendDate(String wlcmLtrSendDate) {
		this.wlcmLtrSendDate = wlcmLtrSendDate;
	}
	public String getIntegrationKey() {
		return integrationKey;
	}
	public void setIntegrationKey(String integrationKey) {
		this.integrationKey = integrationKey;
	}
	public String getPenaltyReason() {
		return penaltyReason;
	}
	public void setPenaltyReason(String penaltyReason) {
		this.penaltyReason = penaltyReason;
	}
	public String getDiscountReason() {
		return discountReason;
	}
	public void setDiscountReason(String discountReason) {
		this.discountReason = discountReason;
	}
	public String getBenefName() {
		return benefName;
	}
	public void setBenefName(String benefName) {
		this.benefName = benefName;
	}
	public BigDecimal getMdrCashAtPos() {
		return mdrCashAtPos;
	}
	public void setMdrCashAtPos(BigDecimal mdrCashAtPos) {
		this.mdrCashAtPos = mdrCashAtPos;
	}
	public BigDecimal getAvgTxnAmount() {
		return avgTxnAmount;
	}
	public void setAvgTxnAmount(BigDecimal avgTxnAmount) {
		this.avgTxnAmount = avgTxnAmount;
	}
	public BigDecimal getPenaltyAmount() {
		return penaltyAmount;
	}
	public void setPenaltyAmount(BigDecimal penaltyAmount) {
		this.penaltyAmount = penaltyAmount;
	}
	public BigDecimal getDiscount() {
		return discount;
	}
	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}
	public BigDecimal getPendingRent() {
		return pendingRent;
	}
	public void setPendingRent(BigDecimal pendingRent) {
		this.pendingRent = pendingRent;
	}
	public String getValidTil() {
		return validTil;
	}
	public void setValidTil(String validTil) {
		this.validTil = validTil;
	}
	public BigDecimal getMdrMobikwik() {
		return mdrMobikwik;
	}
	public void setMdrMobikwik(BigDecimal mdrMobikwik) {
		this.mdrMobikwik = mdrMobikwik;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}	
	public String getBankTId() {
		return bankTId;
	}
	public void setBankTId(String bankTId) {
		this.bankTId = bankTId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public BigDecimal getMdrDebit1() {
		return mdrDebit1;
	}
	public void setMdrDebit1(BigDecimal mdrDebit1) {
		this.mdrDebit1 = mdrDebit1;
	}
	public BigDecimal getMdrDebit2() {
		return mdrDebit2;
	}
	public void setMdrDebit2(BigDecimal mdrDebit2) {
		this.mdrDebit2 = mdrDebit2;
	}
	public BigDecimal getMdrCreditNpre() {
		return mdrCreditNpre;
	}
	public void setMdrCreditNpre(BigDecimal mdrCreditNpre) {
		this.mdrCreditNpre = mdrCreditNpre;
	}
	public BigDecimal getMdrCreditPre() {
		return mdrCreditPre;
	}
	public void setMdrCreditPre(BigDecimal mdrCreditPre) {
		this.mdrCreditPre = mdrCreditPre;
	}
	public BigDecimal getMdrAmex() {
		return mdrAmex;
	}
	public void setMdrAmex(BigDecimal mdrAmex) {
		this.mdrAmex = mdrAmex;
	}
	public BigDecimal getOther() {
		return other;
	}
	public void setOther(BigDecimal other) {
		this.other = other;
	}
	public String getBankAccName() {
		return bankAccName;
	}
	public void setBankAccName(String bankAccName) {
		this.bankAccName = bankAccName;
	}
	public String getBankAccNo() {
		return bankAccNo;
	}
	public void setBankAccNo(String bankAccNo) {
		this.bankAccNo = bankAccNo;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankBranch() {
		return bankBranch;
	}
	public void setBankBranch(String bankBranch) {
		this.bankBranch = bankBranch;
	}
	public String getBankIfsc() {
		return bankIfsc;
	}
	public void setBankIfsc(String bankIfsc) {
		this.bankIfsc = bankIfsc;
	}
	public String getBankMicr() {
		return bankMicr;
	}
	public void setBankMicr(String bankMicr) {
		this.bankMicr = bankMicr;
	}
	public BigDecimal getRent() {
		return rent;
	}
	public void setRent(BigDecimal rent) {
		this.rent = rent;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public AcqUser getAppUser() {
		return appUser;
	}
	public void setAppUser(AcqUser appUser) {
		this.appUser = appUser;
	}
	public String getAmexActivated() {
		return amexActivated;
	}
	public void setAmexActivated(String amexActivated) {
		this.amexActivated = amexActivated;
	}
	public String getAmexTID() {
		return amexTID;
	}
	public void setAmexTID(String amexTID) {
		this.amexTID = amexTID;
	}
	public String getAmexMID() {
		return amexMID;
	}
	public void setAmexMID(String amexMID) {
		this.amexMID = amexMID;
	}
	
	
}
