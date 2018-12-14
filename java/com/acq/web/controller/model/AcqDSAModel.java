package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqDSAModel {
	
	
	private String updateId;
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,20}$",message="Invalid Rent")	*/
	private String deviceRent;
	private String address;
	
	/*@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{1,50}$",message="Invalid Name")*/
	private String Name;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid MDR Debit0")	*/
	private String MdrDebit0;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid MDR Debit1")*/	
	private String MdrDebit1;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid MDR Debit2")*/	
	private String MdrDebit2;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Credit Pre")*/
	private String MdrCreditPre;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Credit Npre")*/
	private String MdrCreditNpre;
	
	/*@NotNull
	@Pattern(regexp="^[0-9\\.]{1,6}$",message="Invalid Mdr Amex")*/
	private String walletMdr;
	
	/*@Pattern(regexp="^[0-9\\.]{0,6}$",message="Invalid Other")*/
	private String Other;
	
	private String cashAtPosIncentive;
	
	private String mdrCashAtpos;

	
	
	public String getUpdateId() {
		return updateId;
	}

	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}

	public String getMdrCashAtpos() {
		return mdrCashAtpos;
	}

	public void setMdrCashAtpos(String mdrCashAtpos) {
		this.mdrCashAtpos = mdrCashAtpos;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDeviceRent() {
		return deviceRent;
	}

	public void setDeviceRent(String deviceRent) {
		this.deviceRent = deviceRent;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	

	public String getMdrDebit1() {
		return MdrDebit1;
	}

	public void setMdrDebit1(String mdrDebit1) {
		MdrDebit1 = mdrDebit1;
	}

	public String getMdrDebit2() {
		return MdrDebit2;
	}

	public void setMdrDebit2(String mdrDebit2) {
		MdrDebit2 = mdrDebit2;
	}

	public String getMdrCreditPre() {
		return MdrCreditPre;
	}

	public void setMdrCreditPre(String mdrCreditPre) {
		MdrCreditPre = mdrCreditPre;
	}

	public String getMdrCreditNpre() {
		return MdrCreditNpre;
	}

	public void setMdrCreditNpre(String mdrCreditNpre) {
		MdrCreditNpre = mdrCreditNpre;
	}

	

	public String getWalletMdr() {
		return walletMdr;
	}

	public void setWalletMdr(String walletMdr) {
		this.walletMdr = walletMdr;
	}

	public String getOther() {
		return Other;
	}

	public void setOther(String other) {
		Other = other;
	}

	public String getCashAtPosIncentive() {
		return cashAtPosIncentive;
	}

	public void setCashAtPosIncentive(String cashAtPosIncentive) {
		this.cashAtPosIncentive = cashAtPosIncentive;
	}

	public String getMdrDebit0() {
		return MdrDebit0;
	}

	public void setMdrDebit0(String mdrDebit0) {
		MdrDebit0 = mdrDebit0;
	}

	
	
	
}
