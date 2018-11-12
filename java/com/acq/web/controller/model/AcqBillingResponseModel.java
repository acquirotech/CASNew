package com.acq.web.controller.model;

public class AcqBillingResponseModel {
	private String serialNo;
	private String dateTime;
	private String txAmount;
	private String mdrCat;
	private String mdr;
	private String tId;
	private String orgId;
	private String merchantId;
	
	
	
	public AcqBillingResponseModel(String serialNo, String dateTime,
			String txAmount, String mdrCat,String tId,String orgId,String merchantId) {
		super();
		this.serialNo = serialNo;
		this.dateTime = dateTime;
		this.txAmount = txAmount;
		this.mdrCat = mdrCat;
		this.tId = tId;
		this.orgId = orgId;
		this.merchantId = merchantId;
	}
	
	public String gettId() {
		return tId;
	}

	public void settId(String tId) {
		this.tId = tId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}

	public String getMdr() {
		return mdr;
	}

	public void setMdr(String mdr) {
		this.mdr = mdr;
	}

	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	public String getTxAmount() {
		return txAmount;
	}
	public void setTxAmount(String txAmount) {
		this.txAmount = txAmount;
	}
	public String getMdrCat() {
		return mdrCat;
	}
	public void setMdrCat(String mdrCat) {
		this.mdrCat = mdrCat;
	}
	
	
	@Override
	public String toString() {
		return "Student [id=" + serialNo + ", dateTime=" + dateTime+ ", txAmount=" + txAmount + ", mdrCat=" + mdrCat + "]";
	}

	
	
}
