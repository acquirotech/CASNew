package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqNewUpdateDeviceDetailModel {	
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{6,30}$",message="Invalid Account No")
	private String bankAccountNo;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Credit Pre")
	private String mdrCashAtPos;

	
	@NotNull
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,]{1,50}$",message="Invalid Bank Name")
	 private String bankName;
	 
	//@Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,\\/]{1,60}$",message="Invalid Beneficiary Name")
	
	@NotNull
	 @Size(min=1, max=60,message="Invalid Beneficiary Name")
	 private String benefName;
	
	 @NotNull
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\,\\&\\-\\.]{1,50}$",message="Invalid Bank Branch")
	 private String branchName;
	
	 private String mdrZero;
	 @Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Balance")	
		private String rechargeBal;
		@Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Incentive")	
		private String rechargeIncentive;
		@Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Monthly Rental")	
		private String rechargeMonthlyRental;
	@NotNull
	@Size(min=2,max=50,message="Invalid Account Type")
	private String bankAccountType;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\/]{2,30}$",message="Invalid Users Type")
	private String userType;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{11,11}$",message="Invalid Bank IFSC No")
	private String bankIfsc;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{9,15}$",message="Invalid Bank MICR No")
	private String bankMicr;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Device Id")	
	private String DeviceID;
	
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,8}$",message="Invalid Bank TID")
	private String BankTid;
	
	//@NotNull
	private String settlementCharges;
	@Pattern(regexp="^[0-9a-zA-Z]{0,17}$",message="Invalid Serial No")
	private String SerialNo;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Rent")
	private String Rent;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{1,30}$",message="Invalid Payment Mode")
	private String PaymentMode;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{1,50}$",message="Invalid Name")
	private String Name;
	
	
	@NotNull
	@Pattern(regexp="^[0-9]{10,10}$",message="Invalid Phone No")
	private String loginId;

	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid EmailId")
	private String EmailId;
	
	@Size(min=8,max=20, message="Invalid Password")
	private String Password;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr Debit0")
	private String MdrDebit0;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr Debit1")
	private String MdrDebit1;
	
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr Debit2")
	private String MdrDebit2;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr MobiKwik")
	private String mdrMobiKwik;
	

	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Credit Pre")
	private String MdrCreditPre;	
	

	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Credit Npre")
	private String MdrCreditNpre;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr Amex")
	private String MdrAmex;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Other")
	private String Other;
	
	@NotNull
	@Pattern(regexp="^[0-9]{10,10}$",message="Invalid Users Phone No")
	private String rmn;
	
	@NotNull
	@Pattern(regexp="^[A-Z]{0,3}$",message="Invalid Amex Activated")
	private String updateAmexActivated;
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,8}$",message="Invalid Amex TID")
	private String updateAmexTID;
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,45}$",message="Invalid Amex MID")
	private String updateAmexMID;	
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Pending Rent")
	private String pendingRent;

	@NotNull
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid ValidTil")
	private String validTil;

	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Penalty Amount")	
	private String penaltyAmount;
	
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\.\\-]{0,100}$",message="Invalid Penalty Reason")
	private String penaltyReason;
	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Discount")	
	private String discount;
	
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\.\\-]{0,100}$",message="Invalid Discount Reason")
	private String discountReason;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid AvgTxnAmount")
	private String avgTxnAmount;
	
	//@Size(min=0,max=100,message="Invalid Integration Key")
	@Pattern(regexp="^[a-zA-Z0-9\\s\\-]{0,100}$",message="Invalid Integration Key")
	private String integrationKey;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,1}$",message="Invalid Users Status")
	private String userStatus;	
	
	private String loyaltyStatus;
	
	private String closeWalletStatus;
	private String txnSmsStatus;
	
	//@Pattern(regexp="^[0-9]{5,10}$",message="Invalid Request Token")
	private String requestToken;

	private String switchType;
	private String ppcServiceEnable;
	private String dmtServiceEnable;
	private String dthMobileServiceEnable;
	
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Tid Entry Date")
	private String midTidEntryDate;
	
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Welcom Letter Send Date")
	private String wlcmLtrSendDate;
	
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

	public String getRechargeBal() {
		return rechargeBal;
	}

	public void setRechargeBal(String rechargeBal) {
		this.rechargeBal = rechargeBal;
	}

	public String getRechargeIncentive() {
		return rechargeIncentive;
	}

	public void setRechargeIncentive(String rechargeIncentive) {
		this.rechargeIncentive = rechargeIncentive;
	}

	public String getRechargeMonthlyRental() {
		return rechargeMonthlyRental;
	}

	public void setRechargeMonthlyRental(String rechargeMonthlyRental) {
		this.rechargeMonthlyRental = rechargeMonthlyRental;
	}

	public String getSettlementCharges() {
		return settlementCharges;
	}

	public void setSettlementCharges(String settlementCharges) {
		this.settlementCharges = settlementCharges;
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

	public String getSwitchType() {
		return switchType;
	}

	public void setSwitchType(String switchType) {
		this.switchType = switchType;
	}

	public String getRequestToken() {
		return requestToken;
	}

	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken;
	}
	
	 @Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Loan Deduction Amount")	
	 private String loanDedAmount;

	 @Size(min=1,max=2,message="Invalid Loan Status")
	 private String loanStatus;
	 
	 @Size(min=0,max=50,message="Invalid Loan Type")
	 private String loanType;
	 
	 @Pattern(regexp="^[a-zA-Z0-9\\s]{0,30}$",message="Invalid Loan Account No")
	 private String loanBankAccNo;
	 
	 @Pattern(regexp="^[a-zA-Z0-9]{0,11}$",message="Invalid Loan Bank IFSC No")
	 private String loanBankIfsc;
		
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,]{0,50}$",message="Invalid Loan Bank Name")
	 private String loanBankName;
	 
     
	 @Pattern(regexp="^[a-zA-Z0-9\\(\\)\\s\\-]{2,100}$",message="Invalid Plan Name")
	 private String planName;
	 
	 //@Size(min=2,max=100,message="Invalid Fee Model")
	 @Pattern(regexp="^[a-zA-Z0-9\\(\\)]{2,100}$",message="Invalid Fee Model")
	 private String feeModel;
	 
	 //@Size(min=0,max=20,message="Invalid Fee Amount")
	 @Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Fee Amount")
	 private String feeAmount;
	 
	 @Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Fee Date")
	 private String feeDate;
	 
	 
	 @Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Activation Date")
	 private String activationDate;
	 
     
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,\\_\\(\\)]{0,150}$",message="Invalid Fee Remarks")
	 private String feeRemarks;
	
	 public String getPlanName() {
			return planName;
		}

		public void setPlanName(String planName) {
			this.planName = planName;
		}

		public String getFeeModel() {
			return feeModel;
		}

		public void setFeeModel(String feeModel) {
			this.feeModel = feeModel;
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

		public String getActivationDate() {
			return activationDate;
		}

		public void setActivationDate(String activationDate) {
			this.activationDate = activationDate;
		}

		public String getFeeRemarks() {
			return feeRemarks;
		}

		public void setFeeRemarks(String feeRemarks) {
			this.feeRemarks = feeRemarks;
		}

	public String getMdrDebit0() {
		return MdrDebit0;
	}

	public void setMdrDebit0(String mdrDebit0) {
		MdrDebit0 = mdrDebit0;
	}

	public String getMdrZero() {
		return mdrZero;
	}

	public void setMdrZero(String mdrZero) {
		this.mdrZero = mdrZero;
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

	public String getTxnSmsStatus() {
		return txnSmsStatus;
	}

	public void setTxnSmsStatus(String txnSmsStatus) {
		this.txnSmsStatus = txnSmsStatus;
	}

	public String getIntegrationKey() {
		return integrationKey;
	}

	public void setIntegrationKey(String integrationKey) {
		this.integrationKey = integrationKey;
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

	public String getUserStatus() {
		return userStatus;
	}

	public String getBenefName() {
		return benefName;
	}

	public void setBenefName(String benefName) {
		this.benefName = benefName;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getMdrCashAtPos() {
		return mdrCashAtPos;
	}

	public void setMdrCashAtPos(String mdrCashAtPos) {
		this.mdrCashAtPos = mdrCashAtPos;
	}

	public String getAvgTxnAmount() {
		return avgTxnAmount;
	}

	public void setAvgTxnAmount(String avgTxnAmount) {
		this.avgTxnAmount = avgTxnAmount;
	}

	public String getPenaltyAmount() {
		return penaltyAmount;
	}

	public void setPenaltyAmount(String penaltyAmount) {
		this.penaltyAmount = penaltyAmount;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getPendingRent() {
		return pendingRent;
	}

	public void setPendingRent(String pendingRent) {
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

	public String getMdrMobiKwik() {
		return mdrMobiKwik;
	}

	public void setMdrMobiKwik(String mdrMobiKwik) {
		this.mdrMobiKwik = mdrMobiKwik;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccountNo() {
		return bankAccountNo;
	}

	public void setBankAccountNo(String bankAccountNo) {
		this.bankAccountNo = bankAccountNo;
	}

	public String getBankAccountType() {
		return bankAccountType;
	}

	public void setBankAccountType(String bankAccountType) {
		this.bankAccountType = bankAccountType;
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

	public String getDeviceID() {
		return DeviceID;
	}

	public void setDeviceID(String deviceID) {
		DeviceID = deviceID;
	}

	public String getBankTid() {
		return BankTid;
	}

	public void setBankTid(String bankTid) {
		BankTid = bankTid;
	}

	public String getSerialNo() {
		return SerialNo;
	}

	public void setSerialNo(String serialNo) {
		SerialNo = serialNo;
	}

	public String getRent() {
		return Rent;
	}

	public void setRent(String rent) {
		Rent = rent;
	}

	public String getPaymentMode() {
		return PaymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		PaymentMode = paymentMode;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}
	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getEmailId() {
		return EmailId;
	}

	public void setEmailId(String emailId) {
		EmailId = emailId;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getMdrDebit1() {
		return MdrDebit1;
	}

	public void setMdrDebit1(String mdrDebit1) {
		MdrDebit1 = mdrDebit1;
	}

	public String getMdrDebit2() {
		return MdrDebit2;
	}

	public void setMdrDebit2(String mdrDebit2) {
		MdrDebit2 = mdrDebit2;
	}

	public String getMdrCreditPre() {
		return MdrCreditPre;
	}

	public void setMdrCreditPre(String mdrCreditPre) {
		MdrCreditPre = mdrCreditPre;
	}

	public String getMdrCreditNpre() {
		return MdrCreditNpre;
	}

	public void setMdrCreditNpre(String mdrCreditNpre) {
		MdrCreditNpre = mdrCreditNpre;
	}

	public String getMdrAmex() {
		return MdrAmex;
	}

	public void setMdrAmex(String mdrAmex) {
		MdrAmex = mdrAmex;
	}

	public String getOther() {
		return Other;
	}

	public void setOther(String other) {
		Other = other;
	}

	

	public String getRmn() {
		return rmn;
	}

	public void setRmn(String rmn) {
		this.rmn = rmn;
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
	
	
	
}
