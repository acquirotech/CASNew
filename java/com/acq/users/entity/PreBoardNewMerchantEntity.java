package com.acq.users.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="preboard_merchant", schema="acquiro_ver2")
public class PreBoardNewMerchantEntity {
   
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	private Integer id;
	
	@Column(name="name")
	private String merchantName;
	
	@Column(name="MARKETING_NAME")
	private String marketingName;
	
	@Column(name="EXECUTIVE_NAME")
	private String executiveName;
	
	@Column(name="PHONE_NO")
	private String phoneNo;
	
	@Column(name="KYC_NOTE")
	private String note;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="CUB_BRANCH")
	private String cubBranch;

	
	@Column(name="AMOUNT")
	private String amount;
	
	@Column(name="LOCATION")
	private String location;
	
	@Column(name="CHEQUE_NO")
	private String chequeNo;
	
	@Column(name="KYC_CHECK")
	private String kycCheck;

	@Column(name="CREATE_ON")
	private String created_on;
	
	@Column(name = "AQUIRER_CODE")
	private String aquirerCode;
	
	
	
	public String getCubBranch() {
		return cubBranch;
	}
	public void setCubBranch(String cubBranch) {
		this.cubBranch = cubBranch;
	}
	public String getAquirerCode() {
		return aquirerCode;
	}
	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	
	public String getCreated_on() {
		return created_on;
	}

	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getMarketingName() {
		return marketingName;
	}

	public void setMarketingName(String marketingName) {
		this.marketingName = marketingName;
	}

	public String getExecutiveName() {
		return executiveName;
	}

	public void setExecutiveName(String executiveName) {
		this.executiveName = executiveName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getChequeNo() {
		return chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public String getKycCheck() {
		return kycCheck;
	}

	public void setKycCheck(String kycCheck) {
		this.kycCheck = kycCheck;
	}
}
