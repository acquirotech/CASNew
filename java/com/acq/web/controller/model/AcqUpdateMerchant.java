package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


public class AcqUpdateMerchant {
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")
	private String merchantId;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,60}$",message="Invalid Merchant Name")
	private String Name;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,45}$",message="Invalid Business Type")
	private String BusinessType;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,100}$",message="Invalid Directors Name")
	private String DirectorsName;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,50}$",message="Invalid Authorized Signatory")
	private String AuthorizedSignatory;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,50}$",message="Invalid Business Nature")
	private String BusinessNature;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,50}$",message="Invalid Marketing Name")
	private String MarketingName;
		
	@NotNull
	@Size(min=4,max=100, message="Invalid Address1")
	private String Address1;
	
	@NotNull
	@Size(min=4,max=100, message="Invalid Address2")
	private String Address2;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{1,50}$",message="Invalid City")
	private String City;

	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{1,50}$",message="Invalid State")
	private String State;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{1,50}$",message="Invalid Country")
	private String Country;
	
	
	@Pattern(regexp="^((http://www\\.)|(https://www\\.)|(www\\.)|(http://)|(https://))[a-zA-Z0-9\\._-]+.[.][a-zA-Z.]{2,5}$|(){0}$",message="Invalid Web Site URL")
	private String Websiteurl;
	
	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid Email")
	private String EmailId;
	
		
	@Pattern(regexp="^[0-9]{0,11}$",message="Invalid TIN No")
	private String TinNo;
	
	
	@Pattern(regexp="^[A-Za-z0-9]{0,15}$",message="Invalid Service Tax No")
	private String ServiceTaxNo;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]{15,45}$",message="Invalid Bank MID")
	private String BankMid;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{3,12}$",message="Invalid Varification Status")
	private String VerificationStatus;
	
	//@Pattern(regexp="^[a-zA-Z0-9\\@#$%()-_+=.!^&*()]{4,100}$",message="invalid credentials")
	

	@Size(min=0,max=200, message="Invalid Note")	
	private String Note;
	
	
	
	
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
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
	public String getMarketingName() {
		return MarketingName;
	}
	public void setMarketingName(String marketingName) {
		MarketingName = marketingName;
	}
	public String getAddress1() {
		return Address1;
	}
	public void setAddress1(String address1) {
		Address1 = address1;
	}
	public String getAddress2() {
		return Address2;
	}
	public void setAddress2(String address2) {
		Address2 = address2;
	}
	public String getCity() {
		return City;
	}
	public void setCity(String city) {
		City = city;
	}
	public String getState() {
		return State;
	}
	public void setState(String state) {
		State = state;
	}
	public String getCountry() {
		return Country;
	}
	public void setCountry(String country) {
		Country = country;
	}
	public String getWebsiteurl() {
		return Websiteurl;
	}
	public void setWebsiteurl(String websiteurl) {
		Websiteurl = websiteurl;
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
	public String getBankMid() {
		return BankMid;
	}
	public void setBankMid(String bankMid) {
		BankMid = bankMid;
	}
	public String getVerificationStatus() {
		return VerificationStatus;
	}
	public void setVerificationStatus(String verificationStatus) {
		VerificationStatus = verificationStatus;
	}
	public String getNote() {
		return Note;
	}
	public void setNote(String note) {
		Note = note;
	}	
}
