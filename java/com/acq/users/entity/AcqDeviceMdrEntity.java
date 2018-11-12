package com.acq.users.entity;

import java.math.BigDecimal;

import javax.persistence.Column;

public class AcqDeviceMdrEntity {

	private Long userId;
	private BigDecimal mdrDebit1;
	private BigDecimal mdrDebit2;
	private BigDecimal mdrCreditNpre;
	private BigDecimal mdrCreditPre;
	private BigDecimal mdrAmex;
	private BigDecimal other;
	private BigDecimal mdrDebit0;
	
	public BigDecimal getMdrDebit0() {
		return mdrDebit0;
	}

	public void setMdrDebit0(BigDecimal mdrDebit0) {
		this.mdrDebit0 = mdrDebit0;
	}

	public AcqDeviceMdrEntity(){}
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public BigDecimal getMdrDebit1() {
		return mdrDebit1;
	}
	public void setMdrDebit1(BigDecimal mdrDebit1) {
		this.mdrDebit1 = mdrDebit1;
	}
	public BigDecimal getMdrDebit2() {
		return mdrDebit2;
	}
	public void setMdrDebit2(BigDecimal mdrDebit2) {
		this.mdrDebit2 = mdrDebit2;
	}
	public BigDecimal getMdrCreditNpre() {
		return mdrCreditNpre;
	}
	public void setMdrCreditNpre(BigDecimal mdrCreditNpre) {
		this.mdrCreditNpre = mdrCreditNpre;
	}
	public BigDecimal getMdrCreditPre() {
		return mdrCreditPre;
	}
	public void setMdrCreditPre(BigDecimal mdrCreditPre) {
		this.mdrCreditPre = mdrCreditPre;
	}
	public BigDecimal getMdrAmex() {
		return mdrAmex;
	}
	public void setMdrAmex(BigDecimal mdrAmex) {
		this.mdrAmex = mdrAmex;
	}
	public BigDecimal getOther() {
		return other;
	}
	public void setOther(BigDecimal other) {
		this.other = other;
	}
	
}
