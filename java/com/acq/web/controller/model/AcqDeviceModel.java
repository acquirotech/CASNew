package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqDeviceModel {
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")	
	private String MerchantId;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Org Id")
	private String OrgId;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{8,8}$",message="Invalid Bank TID")
	private String BankTid;
	
	@NotNull
	@Pattern(regexp="^[0-9]{8,17}$",message="Invalid Serial No")
	private String SerialNo;	
	
	//@Pattern(regexp="^([0-9]\\d{0,20})?(.[0-9]{1,3}$)?$|{0}$",message="invalid credientials")
	
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
	private String PhoneNo;
	

	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid EmailId")
	private String EmailId;
	
	@NotNull
	@Size(min=8,max=20, message="Invalid Password")
	private String password;
	
	
	//@Pattern(regexp="^([0-9]\\d{0,20})?(.[0-9]{1,3}$)?$|{0}$",message="invalid credientials")
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid MDR Debit1")	
	private String MdrDebit1;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid MDR Debit2")	
	private String MdrDebit2;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Credit Pre")
	private String MdrCreditPre;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Credit Npre")
	private String MdrCreditNpre;
	
	@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Mdr Amex")
	private String MdrAmex;
	
	@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Other")
	private String Other;
	
	
	@NotNull
	@Pattern(regexp="^[A-Z]{2,3}$",message="Invalid Amex Activated")
	private String amexActivated;
	
	
	@Pattern(regexp="^[a-zA-Z0-9]{0,8}$",message="Invalid Amex TID")
	private String amexTID;

	
	@Pattern(regexp="^[a-zA-Z0-9]{0,45}$",message="Invalid Amex MID")
	private String amexMID;
	
	
	
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
	public String getPhoneNo() {
		return PhoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		PhoneNo = phoneNo;
	}
	public String getEmailId() {
		return EmailId;
	}
	public void setEmailId(String emailId) {
		EmailId = emailId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	
}
