package com.acq.users.entity;



import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Acq_sign_image", schema="acquiro_ver2")
public class AcqCustomerDetails {

	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true)
	private Long id;
	
	@Column(name="CALL_PURPOSE")
	private String callPurpose;
	
	@Column(name="CALLER_NAME")
	private String callerName;
	
	@Column(name="MERCHANT_NAME")
	private String merchantName;
	
	@Column(name="DATETIME")
	private Date dateTime;

	@Column(name="DATETIME")
	private Date updatedDateTime;
	
	@Column(name="USERNAME")
	private String userName;
	
	private String updatedBy;
	
	private String callType;
	
	private String callbackNo;
	
	
	
	
	public String getCallbackNo() {
		return callbackNo;
	}

	public void setCallbackNo(String callbackNo) {
		this.callbackNo = callbackNo;
	}

	public String getCallType() {
		return callType;
	}

	public void setCallType(String callType) {
		this.callType = callType;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCallPurpose() {
		return callPurpose;
	}

	public void setCallPurpose(String callPurpose) {
		this.callPurpose = callPurpose;
	}

	public String getCallerName() {
		return callerName;
	}

	public void setCallerName(String callerName) {
		this.callerName = callerName;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getUpdatedDateTime() {
		return updatedDateTime;
	}

	public void setUpdatedDateTime(Date updatedDateTime) {
		this.updatedDateTime = updatedDateTime;
	}


	
	
}
