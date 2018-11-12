package com.acq.web.controller.model;

import java.math.BigDecimal;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqNewDeviceDetailModel {
	
	@NotNull
	private String rechargeServiceEnable;
	
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")	
	private String MerchantId;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Org Id")
	private String OrgId;
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,8}$",message="Invalid Bank TID")
	private String BankTid;
	
	@NotNull
	private String userType;
	
	@Pattern(regexp="^[0-9a-zA-Z]{0,17}$",message="Invalid Serial No")
	private String SerialNo;	
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{6,30}$",message="Invalid Account No")
	private String accountNo;
	
	@NotNull
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,]{1,50}$",message="Invalid Bank Name")
	 private String bankName;
	 
	 @NotNull
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\,\\&\\-\\.]{1,50}$",message="Invalid Bank Branch")
	 private String branchName;
	
	@NotNull
	@Size(min=1,max=50,message="Invalid Account Type")
	private String accountType;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{11,11}$",message="Invalid Bank IFSC No")
	private String bankIfsc;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{9,15}$",message="Invalid Bank MICR No")
	private String bankMicr;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Rent")	
	private String rent;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{1,30}$",message="Invalid PaymentMode")
	private String PaymentMode;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{1,50}$",message="Invalid Name")
	private String Name;
	
	@NotNull
	@Pattern(regexp="^[0-9]{10,10}$",message="Invalid Phone No")
	private String loginId;
	
	@NotNull
	@Pattern(regexp="^[0-9]{10,10}$",message="Invalid Users Phone No")
	private String rmn;

	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid EmailId")
	private String EmailId;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\-]{0,100}$",message="Invalid Integration Key")
	private String integrationKey;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid MDR Mobikwik")	
	private String mdrMobiKwik;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid MDR Debit0")	
	private String MdrDebit0;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid MDR Debit1")	
	private String MdrDebit1;
	

	@Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Balance")	
	private String rechargeBal;
	@Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Incentive")	
	private String rechargeIncentive;
	@Pattern(regexp="^[0-9\\.]{0,13}$",message="Invalid Recharge Monthly Rental")	
	private String rechargeMonthlyRental;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid MDR Debit2")	
	private String MdrDebit2;
	

	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Credit Pre")
	private String MdrCreditPre;
	

	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Credit Npre")
	private String MdrCreditNpre;
		
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Mdr Amex")
	private String MdrAmex;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Other")
	private String Other;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid CASHATPOS MDR")
	private String mdrCashAtPos;
	
	@Pattern(regexp="^[A-Z]{0,3}$",message="Invalid Amex Activated")
	private String amexActivated;
	
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,8}$",message="Invalid Amex TID")
	private String amexTID;

	
	@Pattern(regexp="^[a-zA-Z0-9]{0,45}$",message="Invalid Amex MID")
	private String amexMID;	
	
	@NotNull
	private String validTil;
	
	@NotNull
	 @Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Pending Rent") 
	 private String pendingRent;

	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Penalty Amount")	
	private String penaltyAmount;
	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid Discount")	
	private String discount;
	
	@Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Average Transaction Amount")	
	private String avgTxnAmount;
	
	@NotNull
	@Size(min=1, max=60,message="Invalid Beneficiary Name")
	private String benefName;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\.\\-]{0,100}$",message="Invalid Penalty Reason")
	private String penaltyReason;	
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\.\\-]{0,100}$",message="Invalid Discount Reason")
	private String discountReason;	
	
	@Pattern(regexp="^[a-zA-Z0-9\\(\\)\\s\\-]{2,100}$",message="Invalid Plan Name")
	private String planName;
	
	@Pattern(regexp="^[a-zA-Z0-9\\(\\)]{2,100}$",message="Invalid Fee Model")
	private String feeModel;
	
	//@Size(min=0,max=20,message="Invalid Fee Amount")
	@Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Fee Amount")
	private String feeAmount;
	
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Fee Date")
	private String feeDate;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,\\_\\(\\)]{0,150}$",message="Invalid Fee Remarks")
	private String feeRemarks;

	//@Pattern(regexp="^[a-zA-Z)]{2,20}$",message="Invalid Clone Check")
	private String cloneCheck;
	
	//@Pattern(regexp="^[0-9]{5,10}$",message="Invalid Request Token") 
	private String requestToken;   
	
	private String switchType;
	
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Tid Entry Date")
	private String midTidEntryDate;
	
	@Pattern(regexp="^[0-9\\-\\/)]{10,10}$",message="Invalid Welcom Letter Send Date")
	private String wlcmLtrSendDate;
	
	private String settlementCharges;
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
	public String getRechargeServiceEnable() {
		return rechargeServiceEnable;
	}
	public void setRechargeServiceEnable(String rechargeServiceEnable) {
		this.rechargeServiceEnable = rechargeServiceEnable;
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
	} public void setRequestToken(String requestToken) {  
			this.requestToken = requestToken;
	}
	
	public String getCloneCheck() {
		return cloneCheck; 
	} public void setCloneCheck(String cloneCheck) {  
		this.cloneCheck = cloneCheck; 
	}
	
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



	public String getIntegrationKey() {
		return integrationKey;
	}

	

	public void setIntegrationKey(String integrationKey) {
		this.integrationKey = integrationKey;
	}

	public String getBenefName() {
		return benefName;
	}

	public void setBenefName(String benefName) {
		this.benefName = benefName;
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

	public String getValidTil() {
		return validTil;
	}

	public void setValidTil(String validTil) {
		this.validTil = validTil;
	}

	public String getPendingRent() {
		return pendingRent;
	}

	public void setPendingRent(String pendingRent) {
		this.pendingRent = pendingRent;
	}

	public String getMdrMobiKwik() {
		return mdrMobiKwik;
	}

	public void setMdrMobiKwik(String mdrMobiKwik) {
		this.mdrMobiKwik = mdrMobiKwik;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getMerchantId() {
		return MerchantId;
	}

	public void setMerchantId(String merchantId) {
		MerchantId = merchantId;
	}
	
	public String getOrgId() {
		return OrgId;
	}


	public void setOrgId(String orgId) {
		OrgId = orgId;
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


	public String getAccountNo() {
		return accountNo;
	}


	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
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


	public String getAccountType() {
		return accountType;
	}


	public void setAccountType(String accountType) {
		this.accountType = accountType;
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


	public String getRent() {
		return rent;
	}


	public void setRent(String rent) {
		this.rent = rent;
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


	public String getRmn() {
		return rmn;
	}


	public void setRmn(String rmn) {
		this.rmn = rmn;
	}


	public String getEmailId() {
		return EmailId;
	}


	public void setEmailId(String emailId) {
		EmailId = emailId;
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
	
	
}
