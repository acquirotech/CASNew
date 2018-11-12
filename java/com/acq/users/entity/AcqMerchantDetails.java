package com.acq.users.entity;

public class AcqMerchantDetails {

	private String merchantName;
	private Long merchantId;
	
	public AcqMerchantDetails(){}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public Long getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Long merchantId) {
		this.merchantId = merchantId;
	}
	
	
}
