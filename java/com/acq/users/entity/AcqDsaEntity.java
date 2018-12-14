package com.acq.users.entity;

import java.math.BigDecimal;

import javax.persistence.Column;

public class AcqDsaEntity {

	private Long id;
	private BigDecimal mdrDebit1;
	private BigDecimal mdrDebit2;
	private BigDecimal mdrCreditNpre;
	private BigDecimal mdrCreditPre;
	private String address;
	private BigDecimal other;
	private BigDecimal mdrDebit0;
	private String name;
	private String deviceRental;
	private BigDecimal walletMdr;
	private String cashatposIncentive;
	private String date;
	private BigDecimal mdrCashAtPos;
	
	
	
	

	public BigDecimal getMdrCashAtPos() {
		return mdrCashAtPos;
	}

	public void setMdrCashAtPos(BigDecimal mdrCashAtPos) {
		this.mdrCashAtPos = mdrCashAtPos;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDeviceRental() {
		return deviceRental;
	}

	public void setDeviceRental(String deviceRental) {
		this.deviceRental = deviceRental;
	}

	public BigDecimal getWalletMdr() {
		return walletMdr;
	}

	public void setWalletMdr(BigDecimal walletMdr) {
		this.walletMdr = walletMdr;
	}

	public String getCashatposIncentive() {
		return cashatposIncentive;
	}

	public void setCashatposIncentive(String cashatposIncentive) {
		this.cashatposIncentive = cashatposIncentive;
	}

	public BigDecimal getMdrDebit0() {
		return mdrDebit0;
	}

	public void setMdrDebit0(BigDecimal mdrDebit0) {
		this.mdrDebit0 = mdrDebit0;
	}

	public AcqDsaEntity(){}
	
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
	
	public BigDecimal getOther() {
		return other;
	}
	public void setOther(BigDecimal other) {
		this.other = other;
	}
	
}
