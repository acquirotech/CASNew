package com.acq.users.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

public class AcqSettingEntity {
	
	private Long id;
	
	private String serviceTax;
	
	private String mdrDebit0;
	
	private String mdrDebit1;
	
	private String mdrDebit2;
	
	private String mdrCr;
	
	private String mdrCrpn;
	
	private String mdrAmex;
	
	private String other;
	
	private String mdrMoiKwik;
	
	private String mdrPayUmoney;
	
	private String mdrFreecharge;
	
	private String mdrCitrus;
	
	private String mdrCashAtPos;
	
	private String mdrAirtelMoney;
	
	private String walletPayoutAc;
	
	private String cardPayoutAc;
	
	private String beneficiaryEmail;
	
	private String payoutEmail;
	
	private String cashAtPosServiceTax;
	
	private String maintenanceMode;
	
	private String maintenanceReason;
	
	private String appVersion;
	
	private String aquirerCode;
	
	private String mdrCrpnEmerging;
	
	private String neftFee;
	
	private String systemUtilityAmt;
	
	private String systemUtilityFee;
	
	
	
	
	public String getSystemUtilityAmt() {
		return systemUtilityAmt;
	}

	public void setSystemUtilityAmt(String systemUtilityAmt) {
		this.systemUtilityAmt = systemUtilityAmt;
	}

	public String getNeftFee() {
		return neftFee;
	}

	public void setNeftFee(String neftFee) {
		this.neftFee = neftFee;
	}

	

	public String getSystemUtilityFee() {
		return systemUtilityFee;
	}

	public void setSystemUtilityFee(String systemUtilityFee) {
		this.systemUtilityFee = systemUtilityFee;
	}

	public String getMdrDebit0() {
		return mdrDebit0;
	}

	public void setMdrDebit0(String mdrDebit0) {
		this.mdrDebit0 = mdrDebit0;
	}

	public String getMdrCrpnEmerging() {
		return mdrCrpnEmerging;
	}

	public void setMdrCrpnEmerging(String mdrCrpnEmerging) {
		this.mdrCrpnEmerging = mdrCrpnEmerging;
	}

	public String getAquirerCode() {
		return aquirerCode;
	}

	public void setAquirerCode(String aquirerCode) {
		this.aquirerCode = aquirerCode;
	}
	
	
	public String getMaintenanceMode() {
		return maintenanceMode;
	}


	public void setMaintenanceMode(String maintenanceMode) {
		this.maintenanceMode = maintenanceMode;
	}


	public String getMaintenanceReason() {
		return maintenanceReason;
	}


	public void setMaintenanceReason(String maintenanceReason) {
		this.maintenanceReason = maintenanceReason;
	}


	public String getAppVersion() {
		return appVersion;
	}


	public void setAppVersion(String appVersion) {
		this.appVersion = appVersion;
	}


	public String getCashAtPosServiceTax() {
		return cashAtPosServiceTax;
	}


	public void setCashAtPosServiceTax(String cashAtPosServiceTax) {
		this.cashAtPosServiceTax = cashAtPosServiceTax;
	}


	public String getBeneficiaryEmail() {
		return beneficiaryEmail;
	}


	public void setBeneficiaryEmail(String beneficiaryEmail) {
		this.beneficiaryEmail = beneficiaryEmail;
	}


	public String getPayoutEmail() {
		return payoutEmail;
	}


	public void setPayoutEmail(String payoutEmail) {
		this.payoutEmail = payoutEmail;
	}


	public AcqSettingEntity(){}
	
	
	public String getMdrCashAtPos() {
		return mdrCashAtPos;
	}


	public void setMdrCashAtPos(String mdrCashAtPos) {
		this.mdrCashAtPos = mdrCashAtPos;
	}


	public String getMdrAirtelMoney() {
		return mdrAirtelMoney;
	}


	public void setMdrAirtelMoney(String mdrAirtelMoney) {
		this.mdrAirtelMoney = mdrAirtelMoney;
	}


	public String getWalletPayoutAc() {
		return walletPayoutAc;
	}


	public void setWalletPayoutAc(String walletPayoutAc) {
		this.walletPayoutAc = walletPayoutAc;
	}


	public String getCardPayoutAc() {
		return cardPayoutAc;
	}


	public void setCardPayoutAc(String cardPayoutAc) {
		this.cardPayoutAc = cardPayoutAc;
	}


	public String getMdrCitrus() {
		return mdrCitrus;
	}

	
	public String getMdrFreecharge() {
		return mdrFreecharge;
	}


	public void setMdrFreecharge(String mdrFreecharge) {
		this.mdrFreecharge = mdrFreecharge;
	}


	public void setMdrCitrus(String mdrCitrus) {
		this.mdrCitrus = mdrCitrus;
	}


	public String getMdrPayUmoney() {
		return mdrPayUmoney;
	}
	public void setMdrPayUmoney(String mdrPayUmoney) {
		this.mdrPayUmoney = mdrPayUmoney;
	}
	public String getMdrMoiKwik() {
		return mdrMoiKwik;
	}
	public void setMdrMoiKwik(String mdrMoiKwik) {
		this.mdrMoiKwik = mdrMoiKwik;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(String serviceTax) {
		this.serviceTax = serviceTax;
	}
	public String getMdrDebit1() {
		return mdrDebit1;
	}
	public void setMdrDebit1(String mdrDebit1) {
		this.mdrDebit1 = mdrDebit1;
	}
	public String getMdrDebit2() {
		return mdrDebit2;
	}
	public void setMdrDebit2(String mdrDebit2) {
		this.mdrDebit2 = mdrDebit2;
	}
	public String getMdrCr() {
		return mdrCr;
	}
	public void setMdrCr(String mdrCr) {
		this.mdrCr = mdrCr;
	}
	public String getMdrCrpn() {
		return mdrCrpn;
	}
	public void setMdrCrpn(String mdrCrpn) {
		this.mdrCrpn = mdrCrpn;
	}
	public String getMdrAmex() {
		return mdrAmex;
	}
	public void setMdrAmex(String mdrAmex) {
		this.mdrAmex = mdrAmex;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	
}
