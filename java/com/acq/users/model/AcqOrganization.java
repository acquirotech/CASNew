package com.acq.users.model;

import java.util.HashSet;
import java.util.Set;



public class AcqOrganization {
	
	private Long orgId;
	private String name;
	private String address1;
	private String address2;
	private String city;
	private String state;
	private String country;
	private Integer merchantId;
	private String pincode;
	private String aquirerCode;
	private AcqMerchant merchant;
	private Set<AcqAppUser> appUsers = new HashSet<AcqAppUser>(0);
	
	
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public Long getOrgId() {
		return orgId;
	}
	public void setOrg(Long orgId) {
		this.orgId = orgId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public Integer getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	public AcqMerchant getMerchant() {
		return merchant;
	}
	public void setMerchant(AcqMerchant merchant) {
		this.merchant = merchant;
	}
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	public Set<AcqAppUser> getAppUsers() {
		return appUsers;
	}
	public void setAppUsers(Set<AcqAppUser> appUsers) {
		this.appUsers = appUsers;
	}
	
	
}
