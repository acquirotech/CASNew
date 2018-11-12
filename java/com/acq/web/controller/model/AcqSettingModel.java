package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqSettingModel {
	
	private String id;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid Service Tax")	
	private String serviceTax;
	

	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRDebit0")	
	private String mdrDebit0;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRDebit1")	
	private String mdrDebit1;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRDebit2")
	private String mdrDebit2;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRCr")
	private String mdrCr;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRCrpn")
	private String mdrCrpn;
	
	
	private String mdrCrpnEmerging;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRAmex")
	private String mdrAmex;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid Other")
	private String other;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid MDRCashAtPos")	
	private String mdrCashAtPos;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s]{6,20}$",message="Invalid Card Payout A/C")
	private String cardPayoutAc;
	
	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid Payout Email")
	private String payoutEmail;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,2}[\\.]{1}[0-9]{1,3}?$",message="Invalid CashAtPos Service Tax") 
	private String cashAtPosServiceTax;
	
	@NotNull
	@Pattern(regexp="^(ON)$|(OFF)$",message="Invalid Maintenance Mode")
	private String maintenanceMode;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\-\\:]{2,50}$",message="Invalid Maintenance Reason")
	private String maintenanceReason;
	
	@NotNull
	@Pattern(regexp="(?!\\.)(\\d+(\\.\\d+)+)(?![\\d\\.])",message="Invalid App Version")
	private String appVersion;	
	
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\&\\.\\-\\,]{0,50}$",message="Invalid Bank Name")
	 private String bankName;
	 
	 @Size(min=0, max=60,message="Invalid Beneficiary Name")
	 private String benefName;
	
	 @Pattern(regexp="^[a-zA-Z0-9\\s\\,\\&\\-\\.]{0,50}$",message="Invalid Bank Branch")
	 private String bankBranch;
	
	@Size(min=0,max=50,message="Invalid Account Type")
	private String bankAccType;
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,11}$",message="Invalid Bank IFSC No")
	private String bankIfsc;
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,15}$",message="Invalid Bank MICR No")
	private String bankMicr;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s]{0,30}$",message="Invalid Account No")
	private String bankAccNumber;	
	
	private String aquirerCode;
	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid NEFT Fees")	
	private String neftFees;
	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid System Utility Fees")	
	private String systemUtilityFees;
	
	@Pattern(regexp="^[0-9\\.]{0,20}$",message="Invalid System Utility Amount")	
	private String systemUtilityAmount;
	
	@Pattern(regexp="^[0-9]{5,10}$",message="Invalid Request Token")
	private String requestToken;
	
	
	public String getRequestToken() {
		return requestToken;
	}

	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken;
	}

	public String getNeftFees() {
		return neftFees;
	}

	public void setNeftFees(String neftFees) {
		this.neftFees = neftFees;
	}

	public String getSystemUtilityFees() {
		return systemUtilityFees;
	}

	public void setSystemUtilityFees(String systemUtilityFees) {
		this.systemUtilityFees = systemUtilityFees;
	}

	public String getSystemUtilityAmount() {
		return systemUtilityAmount;
	}

	public void setSystemUtilityAmount(String systemUtilityAmount) {
		this.systemUtilityAmount = systemUtilityAmount;
	}
	public String getMdrDebit0() {
		return mdrDebit0;
	}
	public void setMdrDebit0(String mdrDebit0) {
		this.mdrDebit0 = mdrDebit0;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBenefName() {
		return benefName;
	}
	public void setBenefName(String benefName) {
		this.benefName = benefName;
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
	public String getBankBranch() {
		return bankBranch;
	}

	public void setBankBranch(String bankBranch) {
		this.bankBranch = bankBranch;
	}

	public String getBankAccType() {
		return bankAccType;
	}

	public void setBankAccType(String bankAccType) {
		this.bankAccType = bankAccType;
	}

	public String getBankAccNumber() {
		return bankAccNumber;
	}

	public void setBankAccNumber(String bankAccNumber) {
		this.bankAccNumber = bankAccNumber;
	}

	public String getMdrCrpnEmerging() {
		return mdrCrpnEmerging;
	}

	public void setMdrCrpnEmerging(String mdrCrpnEmerging) {
		this.mdrCrpnEmerging = mdrCrpnEmerging;
	}

	public String getAquirerCode() {
		return aquirerCode;
	}

	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMaintenanceMode() {
		return maintenanceMode;
	}
	public void setMaintenanceMode(String maintenanceMode) {
		this.maintenanceMode = maintenanceMode;
	}
	public String getMaintenanceReason() {
		return maintenanceReason;
	}
	public void setMaintenanceReason(String maintenanceReason) {
		this.maintenanceReason = maintenanceReason;
	}
	public String getAppVersion() {
		return appVersion;
	}
	public void setAppVersion(String appVersion) {
		this.appVersion = appVersion;
	}
	public String getCashAtPosServiceTax() {
		return cashAtPosServiceTax;
	}
	public void setCashAtPosServiceTax(String cashAtPosServiceTax) {
		this.cashAtPosServiceTax = cashAtPosServiceTax;
	}
	public String getPayoutEmail() {
		return payoutEmail;
	}
	public void setPayoutEmail(String payoutEmail) {
		this.payoutEmail = payoutEmail;
	}
	public String getMdrCashAtPos() {
		return mdrCashAtPos;
	}
	public void setMdrCashAtPos(String mdrCashAtPos) {
		this.mdrCashAtPos = mdrCashAtPos;
	}
	
	public String getCardPayoutAc() {
		return cardPayoutAc;
	}
	public void setCardPayoutAc(String cardPayoutAc) {
		this.cardPayoutAc = cardPayoutAc;
	}
	
	
	public String getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(String serviceTax) {
		this.serviceTax = serviceTax;
	}
	public String getMdrDebit1() {
		return mdrDebit1;
	}
	public void setMdrDebit1(String mdrDebit1) {
		this.mdrDebit1 = mdrDebit1;
	}
	public String getMdrDebit2() {
		return mdrDebit2;
	}
	public void setMdrDebit2(String mdrDebit2) {
		this.mdrDebit2 = mdrDebit2;
	}
	public String getMdrCr() {
		return mdrCr;
	}
	public void setMdrCr(String mdrCr) {
		this.mdrCr = mdrCr;
	}
	public String getMdrCrpn() {
		return mdrCrpn;
	}
	public void setMdrCrpn(String mdrCrpn) {
		this.mdrCrpn = mdrCrpn;
	}
	public String getMdrAmex() {
		return mdrAmex;
	}
	public void setMdrAmex(String mdrAmex) {
		this.mdrAmex = mdrAmex;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	
	
}
