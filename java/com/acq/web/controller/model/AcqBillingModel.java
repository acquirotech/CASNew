package com.acq.web.controller.model;

public class AcqBillingModel {
	
	private String callerId;
	 private Long merchantId; 
	 private Long orgId;
	 private Long loginId;
	 private String empId;
	private String acquirerCode;
	
	
	 public String getAcquirerCode() {
		return acquirerCode;
	}
	public void setAcquirerCode(String acquirerCode) {
		this.acquirerCode = acquirerCode;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public Long getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(Long merchantId) {
		this.merchantId = merchantId;
	}
	public Long getOrgId() {
	  return orgId;
	 }
	 public void setOrgId(Long orgId) {
	  this.orgId = orgId;
	 }
	public Long getLoginId() {
		return loginId;
	}
	public void setLoginId(Long loginId) {
		this.loginId = loginId;
	}
	public String getCallerId() {
		return callerId;
	}
	public void setCallerId(String callerId) {
		this.callerId = callerId;
	}
	
	
	 
}
