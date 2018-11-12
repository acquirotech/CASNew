package com.acq.users.model;

public class AcqMerchant {
	private Long merchantId;
	private String merchantName;
	private String businessType;
	private String merchantType;
	private String directorsName;
	private String authorizedSignatory;
	private String businessNature;
	private String businessCode;
	private String marketingName;
	private String businessAddress1;
	private String businessAddress2;
	private String businessState;
	private String businessCity;
	private String businessPincode;
	private String personalUserAddress1;
	private String personalUserAddress2;
	private String personalUserState;
	private String personalUserCity;
	private String personalUserPincode;
	private String country;
	private String phoneNo;
	private String bankMid;
	private String websiteUrl;
	private String emailId;
	private String tinNo;
	private String serviceTaxNo;
	private String note;
	private String verificationStatus;
	private String dateCreated;
	private String dateUpdated;
	
	private String executiveName;
	

	private String cubMerchant;

	private String appCheckStatus;

	private String aquirerCode;
		
	private String appReceiptDate;
	
	private String typeOfSale;
	
	private String amName;
	
	private String tsoName;
	
	private String onBoardEmpName;

	private String onBoardingStatus;
	
	private String verificationEntryDate;
	
	private String agreementRcvdDate;
	
	private String password;
	/*private Set<AcqOrganization> orgRecords = new HashSet<AcqOrganization>(0);
	
	*/
	
	
	public String getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}
	public Long getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(Long merchantId) {
		this.merchantId = merchantId;
	}
	public String getMerchantName() {
		return merchantName;
	}
	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public String getMerchantType() {
		return merchantType;
	}
	public void setMerchantType(String merchantType) {
		this.merchantType = merchantType;
	}
	public String getDirectorsName() {
		return directorsName;
	}
	public void setDirectorsName(String directorsName) {
		this.directorsName = directorsName;
	}
	public String getAuthorizedSignatory() {
		return authorizedSignatory;
	}
	public void setAuthorizedSignatory(String authorizedSignatory) {
		this.authorizedSignatory = authorizedSignatory;
	}
	public String getBusinessNature() {
		return businessNature;
	}
	public void setBusinessNature(String businessNature) {
		this.businessNature = businessNature;
	}
	public String getBusinessCode() {
		return businessCode;
	}
	public void setBusinessCode(String businessCode) {
		this.businessCode = businessCode;
	}
	public String getMarketingName() {
		return marketingName;
	}
	public void setMarketingName(String marketingName) {
		this.marketingName = marketingName;
	}
	public String getBusinessAddress1() {
		return businessAddress1;
	}
	public void setBusinessAddress1(String businessAddress1) {
		this.businessAddress1 = businessAddress1;
	}
	public String getBusinessAddress2() {
		return businessAddress2;
	}
	public void setBusinessAddress2(String businessAddress2) {
		this.businessAddress2 = businessAddress2;
	}
	public String getBusinessState() {
		return businessState;
	}
	public void setBusinessState(String businessState) {
		this.businessState = businessState;
	}
	public String getBusinessCity() {
		return businessCity;
	}
	public void setBusinessCity(String businessCity) {
		this.businessCity = businessCity;
	}
	public String getBusinessPincode() {
		return businessPincode;
	}
	public void setBusinessPincode(String businessPincode) {
		this.businessPincode = businessPincode;
	}
	public String getPersonalUserAddress1() {
		return personalUserAddress1;
	}
	public void setPersonalUserAddress1(String personalUserAddress1) {
		this.personalUserAddress1 = personalUserAddress1;
	}
	public String getPersonalUserAddress2() {
		return personalUserAddress2;
	}
	public void setPersonalUserAddress2(String personalUserAddress2) {
		this.personalUserAddress2 = personalUserAddress2;
	}
	public String getPersonalUserState() {
		return personalUserState;
	}
	public void setPersonalUserState(String personalUserState) {
		this.personalUserState = personalUserState;
	}
	public String getPersonalUserCity() {
		return personalUserCity;
	}
	public void setPersonalUserCity(String personalUserCity) {
		this.personalUserCity = personalUserCity;
	}
	public String getPersonalUserPincode() {
		return personalUserPincode;
	}
	public void setPersonalUserPincode(String personalUserPincode) {
		this.personalUserPincode = personalUserPincode;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getWebsiteUrl() {
		return websiteUrl;
	}
	public void setWebsiteUrl(String websiteUrl) {
		this.websiteUrl = websiteUrl;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getTinNo() {
		return tinNo;
	}
	public void setTinNo(String tinNo) {
		this.tinNo = tinNo;
	}
	
	public String getExecutiveName() {
		return executiveName;
	}
	public void setExecutiveName(String executiveName) {
		this.executiveName = executiveName;
	}
	public String getCubMerchant() {
		return cubMerchant;
	}
	public void setCubMerchant(String cubMerchant) {
		this.cubMerchant = cubMerchant;
	}
	public String getAppCheckStatus() {
		return appCheckStatus;
	}
	public void setAppCheckStatus(String appCheckStatus) {
		this.appCheckStatus = appCheckStatus;
	}
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getServiceTaxNo() {
		return serviceTaxNo;
	}
	public void setServiceTaxNo(String serviceTaxNo) {
		this.serviceTaxNo = serviceTaxNo;
	}
	public String getBankMid() {
		return bankMid;
	}
	public void setBankMid(String bankMid) {
		this.bankMid = bankMid;
	}
	public String getVerificationStatus() {
		return verificationStatus;
	}
	public void setVerificationStatus(String verificationStatus) {
		this.verificationStatus = verificationStatus;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	public String getDateUpdated() {
		return dateUpdated;
	}
	public void setDateUpdated(String dateUpdated) {
		this.dateUpdated = dateUpdated;
	}
	/*public Set<AcqOrganization> getOrgRecords() {
		return orgRecords;
	}
	public void setOrgRecords(Set<AcqOrganization> orgRecords) {
		this.orgRecords = orgRecords;
	}*/
	
}
