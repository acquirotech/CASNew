package com.acq.users.entity;

import java.math.BigDecimal;

public class AcqSearchEntity {

private Long id;

private String merchantId;
private String dateTime;
private BigDecimal amount;
private String cardPanNo;
private Long custPhone;
private String custEmail;

public Long getId() {
	return id;
}
public void setId(Long id) {
	this.id = id;
}
public long getCustPhone() {
	return custPhone;
}
public void setCustPhone(long custPhone) {
	this.custPhone = custPhone;
}

public String getMerchantId() {
	return merchantId;
}
public void setMerchantId(String merchantId) {
	this.merchantId = merchantId;
}
public void setCustPhone(Long custPhone) {
	this.custPhone = custPhone;
}
public String getDateTime() {
	return dateTime;
}
public void setDateTime(String dateTime) {
	this.dateTime = dateTime;
}

public BigDecimal getAmount() {
	return amount;
}
public void setAmount(BigDecimal amount) {
	this.amount = amount;
}
public String getCardPanNo() {
	return cardPanNo;
}
public void setCardPanNo(String cardPanNo) {
	this.cardPanNo = cardPanNo;
}
public String getCustEmail() {
	return custEmail;
}
public void setCustEmail(String custEmail) {
	this.custEmail = custEmail;
}



}