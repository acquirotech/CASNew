package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AcqNewUpdateMerchantModel {

	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")	
	private String merId;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-99\\.\\&\\-\\s\\(\\)]{2,60}$",message="Invalid Name")
	private String Name;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\/]{1,45}$",message="Invalid Business Type")
	private String BusinessType;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\&\\,\\.\\/\\s]{2,100}$",message="Invalid Directors Name")
	private String DirectorsName;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,50}$",message="Invalid Auhorized Signatory")
	private String AuthorizedSignatory;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,50}$",message="Invalid Business Nature")
	private String BusinessNature;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s]{1,50}$",message="Invalid MCC Code")
	private String BusinessCode;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\&]{2,50}$",message="Invalid Marketing Name")
	private String MarketingName;
	
	//@Size(min=2,max=100, message="Invalid Business Address1")
	
	@NotNull	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\.\\-]{2,100}$",message="Invalid Business Address1")
	private String BusinessAddress1;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\-\\.]{2,100}$",message="Invalid Business Address2")
	private String BusinessAddress2;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Business State")
	private String BusinessState;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Business City")
	private String BusinessCity;
		
	@NotNull
	@Pattern(regexp="^[0-9]{6,6}$",message="Invalid Business Pin Code")
	private String BusinessPincode;
	
	//@Size(min=2,max=100, message="Invalid Users Address1")
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\-\\.]{2,100}$",message="Invalid Users Address1")
	private String PersonalUserAddress1;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_\\-\\.]{2,100}$",message="Invalid Users Address2")
	private String PersonalUserAddress2;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Users State")
	private String PersonalUserState;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Users City")
	private String PersonalUserCity;	
	
	@NotNull
	@Pattern(regexp="^[0-9]{6,6}$",message="Invalid Users Pin Code")
	private String PersonalUserPincode;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{5,5}$",message="Invalid Country")
	private String Country; 
	
	@NotNull
	@Pattern(regexp="^[0-9\\,]{10,54}$",message="Invalid Phone No")
	private String PhoneNo;
	
	@Pattern(regexp="^((http://www\\.)|(https://www\\.)|(www\\.)|(http://)|(https://))[a-zA-Z0-9\\._-]+.[.][a-zA-Z.]{2,5}$|(){0}$",message="Invalid Url")
	private String WebsiteUrl;
	
	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid Email")
	private String EmailId;
	
	@Pattern(regexp="^[0-9]{0,11}$",message="Invalid TIN No")
	private String TinNo;
	
	@Pattern(regexp="^[A-Za-z0-9]{0,45}$",message="Invalid bankMid No")
	private String bankMid;
	
	@Pattern(regexp="^[A-Za-z0-9]{0,15}$",message="Invalid Service Tax No")
	private String ServiceTaxNo;
	
	@Pattern(regexp="^[0-9\\/]{0,12}$",message="Invalid App ReceiptDate")
	private String appReceiptDate;
	
	@Pattern(regexp="^[a-zA-Z]{0,30}$",message="Invalid Type Or Sale")
	private String typeOfSale;
	
	@Size(min=0,max=100,message="Invalid AM Name")
	private String amName;
	
	@Size(min=0,max=100,message="Invalid TSO Name")
	private String tsoName;
	
	@Size(min=0,max=100,message="Invalid OnBoard Employee Name")
	private String onBoardEmpName;

	@Pattern(regexp="^[a-zA-Z\\s]{0,20}$",message="Invalid OnBoarding Status")
	private String onBoardingStatus;
	
	@Pattern(regexp="^[0-9\\/]{0,12}$",message="Invalid Verification Entry Date")
	private String verificationEntryDate;
	
	@Pattern(regexp="^[0-9\\/]{0,12}$",message="Invalid Agreement Rcvd Date")
	private String agreementRcvdDate;
	
	//@Size(min=0,max=200, message="Invalid Note")
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_]{0,100}$",message="Invalid Note")
	private String Note;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s\\-]{3,25}$",message="Invalid Verification Status")
	private String VerificatonStatus;
	
	@Pattern(regexp="^[0-9]{0,8}[\\.]{0,1}[0-9]{0,2}?$",message="Invalid Swipe Amount")	
	private String swipeAmount;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s]{0,50}$",message="Invalid Terminal")	
	private String swipeTerminal;
	
	private String SwipeDate;
	
	@Pattern(regexp="^[0-9]{0,10}$",message="Invalid Cheque No")
	private String chequeNo;
	
	@Pattern(regexp="^[0-9]{0,8}[\\.]{0,1}[0-9]{0,2}?$",message="Invalid Cheque Amount")	
	private String chequeAmount;
	
	@Pattern(regexp="^[0-9]{0,8}[\\.]{0,1}[0-9]{0,2}?$",message="Invalid Amount")	
	private String neftAmount;

	private String neftDate;

	@Pattern(regexp="^[0-9]{0,10}$",message="Invalid Cheque No")
	private String neftchequeNo;

	@Pattern(regexp="^[0-9]{0,15}$",message="Invalid NeftRefNo No")
	private String neftRefNo;
	
	private String chequeDate;
	
	private String chequeDepositDate;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s]{0,50}$",message="Invalid Bank Name")
	private String chequeBank;
	
	@Pattern(regexp="^[0-9]{0,8}[\\.]{0,1}[0-9]{0,2}?$",message="Invalid Amount")	
	private String cashAmount;
	
	private String cashDate;

	private String modeofpayment;
	
	private String merchantType;
	
	private MultipartFile file;
	
	private String executiveEmail;

	private String cubMerchant;
	
	//@Pattern(regexp="^[0-9]{5,10}$",message="Invalid Request Token")
	private String requestToken;

	private String appCheckStatus;
	
	
	private String onBoardUpdateExeName;
	
	
	
	public String getOnBoardUpdateExeName() {
		return onBoardUpdateExeName;
	}

	public void setOnBoardUpdateExeName(String onBoardUpdateExeName) {
		this.onBoardUpdateExeName = onBoardUpdateExeName;
	}

	public String getAppCheckStatus() {
		return appCheckStatus;
	}

	public void setAppCheckStatus(String appCheckStatus) {
		this.appCheckStatus = appCheckStatus;
	}

	public String getAppReceiptDate() {
		return appReceiptDate;
	}

	public void setAppReceiptDate(String appReceiptDate) {
		this.appReceiptDate = appReceiptDate;
	}

	public String getTypeOfSale() {
		return typeOfSale;
	}

	public void setTypeOfSale(String typeOfSale) {
		this.typeOfSale = typeOfSale;
	}

	public String getAmName() {
		return amName;
	}

	public void setAmName(String amName) {
		this.amName = amName;
	}

	public String getTsoName() {
		return tsoName;
	}

	public void setTsoName(String tsoName) {
		this.tsoName = tsoName;
	}

	public String getOnBoardEmpName() {
		return onBoardEmpName;
	}

	public void setOnBoardEmpName(String onBoardEmpName) {
		this.onBoardEmpName = onBoardEmpName;
	}

	public String getOnBoardingStatus() {
		return onBoardingStatus;
	}

	public void setOnBoardingStatus(String onBoardingStatus) {
		this.onBoardingStatus = onBoardingStatus;
	}

	public String getVerificationEntryDate() {
		return verificationEntryDate;
	}

	public void setVerificationEntryDate(String verificationEntryDate) {
		this.verificationEntryDate = verificationEntryDate;
	}

	public String getAgreementRcvdDate() {
		return agreementRcvdDate;
	}

	public void setAgreementRcvdDate(String agreementRcvdDate) {
		this.agreementRcvdDate = agreementRcvdDate;
	}

	public String getCubMerchant() {
		return cubMerchant;
	}

	public void setCubMerchant(String cubMerchant) {
		this.cubMerchant = cubMerchant;
	}

	public String getRequestToken() {
		return requestToken;
	}

	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken;
	}
	
	public String getExecutiveEmail() {
		return executiveEmail;
	}

	public void setExecutiveEmail(String executiveEmail) {
		this.executiveEmail = executiveEmail;
	}


	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getNeftAmount() {
		return neftAmount;
	}

	public void setNeftAmount(String neftAmount) {
		this.neftAmount = neftAmount;
	}

	public String getNeftDate() {
		return neftDate;
	}

	public void setNeftDate(String neftDate) {
		this.neftDate = neftDate;
	}

	public String getNeftchequeNo() {
		return neftchequeNo;
	}

	public void setNeftchequeNo(String neftchequeNo) {
		this.neftchequeNo = neftchequeNo;
	}

	public String getNeftRefNo() {
		return neftRefNo;
	}

	public void setNeftRefNo(String neftRefNo) {
		this.neftRefNo = neftRefNo;
	}

	public String getMerchantType() {
		return merchantType;
	}

	public void setMerchantType(String merchantType) {
		this.merchantType = merchantType;
	}

	public String getSwipeAmount() {
		return swipeAmount;
	}

	public void setSwipeAmount(String swipeAmount) {
		this.swipeAmount = swipeAmount;
	}

	public String getSwipeTerminal() {
		return swipeTerminal;
	}

	public void setSwipeTerminal(String swipeTerminal) {
		this.swipeTerminal = swipeTerminal;
	}

	public String getSwipeDate() {
		return SwipeDate;
	}

	public void setSwipeDate(String swipeDate) {
		SwipeDate = swipeDate;
	}

	public String getChequeNo() {
		return chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public String getChequeAmount() {
		return chequeAmount;
	}

	public void setChequeAmount(String chequeAmount) {
		this.chequeAmount = chequeAmount;
	}

	public String getChequeDate() {
		return chequeDate;
	}

	public void setChequeDate(String chequeDate) {
		this.chequeDate = chequeDate;
	}

	public String getChequeDepositDate() {
		return chequeDepositDate;
	}

	public void setChequeDepositDate(String chequeDepositDate) {
		this.chequeDepositDate = chequeDepositDate;
	}

	public String getChequeBank() {
		return chequeBank;
	}

	public void setChequeBank(String chequeBank) {
		this.chequeBank = chequeBank;
	}

	public String getCashAmount() {
		return cashAmount;
	}

	public void setCashAmount(String cashAmount) {
		this.cashAmount = cashAmount;
	}

	public String getCashDate() {
		return cashDate;
	}

	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}

	public String getModeofpayment() {
		return modeofpayment;
	}

	public void setModeofpayment(String modeofpayment) {
		this.modeofpayment = modeofpayment;
	}

	public String getBankMid() {
		return bankMid;
	}

	public void setBankMid(String bankMid) {
		this.bankMid = bankMid;
	}


	public String getMerId() {
		return merId;
	}

	public void setMerId(String merId) {
		this.merId = merId;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getBusinessType() {
		return BusinessType;
	}

	public void setBusinessType(String businessType) {
		BusinessType = businessType;
	}

	public String getDirectorsName() {
		return DirectorsName;
	}

	public void setDirectorsName(String directorsName) {
		DirectorsName = directorsName;
	}

	public String getAuthorizedSignatory() {
		return AuthorizedSignatory;
	}

	public void setAuthorizedSignatory(String authorizedSignatory) {
		AuthorizedSignatory = authorizedSignatory;
	}

	public String getBusinessNature() {
		return BusinessNature;
	}

	public void setBusinessNature(String businessNature) {
		BusinessNature = businessNature;
	}

	public String getBusinessCode() {
		return BusinessCode;
	}

	public void setBusinessCode(String businessCode) {
		BusinessCode = businessCode;
	}

	public String getMarketingName() {
		return MarketingName;
	}

	public void setMarketingName(String marketingName) {
		MarketingName = marketingName;
	}

	public String getBusinessAddress1() {
		return BusinessAddress1;
	}

	public void setBusinessAddress1(String businessAddress1) {
		BusinessAddress1 = businessAddress1;
	}

	public String getBusinessAddress2() {
		return BusinessAddress2;
	}

	public void setBusinessAddress2(String businessAddress2) {
		BusinessAddress2 = businessAddress2;
	}

	public String getBusinessState() {
		return BusinessState;
	}

	public void setBusinessState(String businessState) {
		BusinessState = businessState;
	}

	public String getBusinessCity() {
		return BusinessCity;
	}

	public void setBusinessCity(String businessCity) {
		BusinessCity = businessCity;
	}

	public String getBusinessPincode() {
		return BusinessPincode;
	}

	public void setBusinessPincode(String businessPincode) {
		BusinessPincode = businessPincode;
	}

	public String getPersonalUserAddress1() {
		return PersonalUserAddress1;
	}

	public void setPersonalUserAddress1(String personalUserAddress1) {
		PersonalUserAddress1 = personalUserAddress1;
	}

	public String getPersonalUserAddress2() {
		return PersonalUserAddress2;
	}

	public void setPersonalUserAddress2(String personalUserAddress2) {
		PersonalUserAddress2 = personalUserAddress2;
	}

	public String getPersonalUserState() {
		return PersonalUserState;
	}

	public void setPersonalUserState(String personalUserState) {
		PersonalUserState = personalUserState;
	}

	public String getPersonalUserCity() {
		return PersonalUserCity;
	}

	public void setPersonalUserCity(String personalUserCity) {
		PersonalUserCity = personalUserCity;
	}

	public String getPersonalUserPincode() {
		return PersonalUserPincode;
	}

	public void setPersonalUserPincode(String personalUserPincode) {
		PersonalUserPincode = personalUserPincode;
	}

	public String getCountry() {
		return Country;
	}

	public void setCountry(String country) {
		Country = country;
	}

	public String getPhoneNo() {
		return PhoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		PhoneNo = phoneNo;
	}

	public String getWebsiteUrl() {
		return WebsiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl) {
		WebsiteUrl = websiteUrl;
	}

	public String getEmailId() {
		return EmailId;
	}

	public void setEmailId(String emailId) {
		EmailId = emailId;
	}

	public String getTinNo() {
		return TinNo;
	}

	public void setTinNo(String tinNo) {
		TinNo = tinNo;
	}

	public String getServiceTaxNo() {
		return ServiceTaxNo;
	}

	public void setServiceTaxNo(String serviceTaxNo) {
		ServiceTaxNo = serviceTaxNo;
	}


	public String getNote() {
		return Note;
	}

	public void setNote(String note) {
		Note = note;
	}

	public String getVerificatonStatus() {
		return VerificatonStatus;
	}

	public void setVerificatonStatus(String verificatonStatus) {
		VerificatonStatus = verificatonStatus;
	}

	
}
