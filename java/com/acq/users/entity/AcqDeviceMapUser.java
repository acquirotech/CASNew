package com.acq.users.entity;

import java.math.BigDecimal;

import javax.persistence.Column;

import com.acq.users.model.AcqUser;

public class AcqDeviceMapUser {
	//private Long id;
	private String serialNo;
	private String macNo;
	private String bankTId;
	private Long userId;
	private String userType;
	private BigDecimal mdrDebit0;
	private BigDecimal mdrDebit1;
	private BigDecimal mdrDebit2;
	private BigDecimal mdrCreditNpre;
	private BigDecimal mdrCreditPre;
	private BigDecimal mdrAmex;
	private BigDecimal other;
	private BigDecimal mdrCashAtPos;
	private BigDecimal mdrMobiKwik;
	private String bankAccName;
	private String bankAccNo;
	private String bankName;
	private String bankBranch;
	private String bankIfsc;
	private String bankMicr;
	private BigDecimal rent;
	private String paymentMode;
	private String updateAmexActivated;
	private String updateAmexTID;
	private String updateAmexMID;	
	private BigDecimal pendingRent;	
	private String validTil;
	private BigDecimal penaltyAmount;
	private String penaltyReason;
	private BigDecimal discount;
	private String discountReason;
	private BigDecimal avgTxnAmount;
	private String benefName;	
	private String integrationKey;
	private String loanDedAmount;
	private BigDecimal settlementCharges;
	private String loanStatus;
	private BigDecimal rechargeBal;
	private BigDecimal rechargeIncentive;
	private BigDecimal rechargeMonthlyRental;
	private String loanType;
	
	private String acquirerCode;
	
	private String activationDate;
	
	private String planName;
	
	private String feeMode;
	
	private String feeAmount;
	
	private String feeDate;
	
	private String feeRemark;
	
	private String benId;
	
	private String midTidEntryDate;
	
	private String wlcmLtrSendDate;
	
	
	
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
	public BigDecimal getMdrDebit0() {
		return mdrDebit0;
	}
	public void setMdrDebit0(BigDecimal mdrDebit0) {
		this.mdrDebit0 = mdrDebit0;
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
	public String getFeeRemark() {
		return feeRemark;
	}
	public void setFeeRemark(String feeRemark) {
		this.feeRemark = feeRemark;
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
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public BigDecimal getMdrMobiKwik() {
		return mdrMobiKwik;
	}
	public void setMdrMobiKwik(BigDecimal mdrMobiKwik) {
		this.mdrMobiKwik = mdrMobiKwik;
	}
	public String getUpdateAmexActivated() {
		return updateAmexActivated;
	}
	public void setUpdateAmexActivated(String updateAmexActivated) {
		this.updateAmexActivated = updateAmexActivated;
	}
	public String getUpdateAmexTID() {
		return updateAmexTID;
	}
	public void setUpdateAmexTID(String updateAmexTID) {
		this.updateAmexTID = updateAmexTID;
	}
	public String getUpdateAmexMID() {
		return updateAmexMID;
	}
	public void setUpdateAmexMID(String updateAmexMID) {
		this.updateAmexMID = updateAmexMID;
	}
	private AcqUser appUser;
	private AcqAppUser appUser1;
	
	public AcqAppUser getAppUser1() {
		return appUser1;
	}
	public void setAppUser1(AcqAppUser appUser1) {
		this.appUser1 = appUser1;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getMacNo() {
		return macNo;
	}
	public void setMacNo(String macNo) {
		this.macNo = macNo;
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
}
