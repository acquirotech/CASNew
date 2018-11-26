package com.acq.users.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="temp_commision_report", schema="acquiro_ver2")
public class AcqTempCommisionRptEntity {
	
	@Id
	@Column(name = "InvoiceNo", nullable = false)
	private Long invoiceNo;
	
	@Column(name="DateTime")
	private String dateTime;
	
	@Column(name="TxnType")
	private String txnType;
	
	@Column(name="MerchantName")
	private String merchantName;
	
	@Column(name="State")
	private String state;
	
	@Column(name="TID")
	private String tid;
	
	@Column(name="RRNO")
	private String rrNo;
	
	@Column(name="CardPanNo")
	private String cardPanNo;
	
	@Column(name="TotalDeduction")
	private String totalDeduction;
	
	@Column(name="TxnAmount")
	private String txnAmount;
	
	@Column(name="TotalIncentive")
	private String totalIncentive;
	
	@Column(name="NetAmount")
	private String netAmount;
	
	@Column(name="BankMDR")
	private String bankMDR;
	
	@Column(name="BankMDRCharged")
	private String bankMDRCharged;
	
	@Column(name="GST")
	private String gst;
	
	@Column(name="GSTCharged")
	private String gstCharged;
	
	@Column(name="BankIncentive")
	private String bankIncentive;
	
	@Column(name="TDS")
	private String tds;
	
	@Column(name="TDSCharged")
	private String tdsCharged;
	
	@Column(name="AcqMDR")
	private String AcqMDR;
	
	@Column(name="AcqMDRCharged")
	private String AcqMDRCharged;
	
	@Column(name="AcqGST")
	private String AcqGST;
	
	@Column(name="AcqGSTCharged")
	private String AcqGSTCharged;
	
	@Column(name="AcqIncentive")
	private String AcqIncentive;
	
	@Column(name="AcqTDS")
	private String AcqTDS;
	
	@Column(name="AcqTDSCharged")
	private String AcqTDSCharged;
	
	@Column(name="acquiroShare")
	private String acquiroShare;
	
	@Column(name="PayoutStatus")
	private String payoutStatus;
	
	@Column(name="PayoutDateTime")
	private String payoutDateTime;
	
	@Column(name="EMPID")
	private String empID;
	

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Long getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(Long invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public String getTxnType() {
		return txnType;
	}

	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getRrNo() {
		return rrNo;
	}

	public void setRrNo(String rrNo) {
		this.rrNo = rrNo;
	}

	public String getCardPanNo() {
		return cardPanNo;
	}

	public void setCardPanNo(String cardPanNo) {
		this.cardPanNo = cardPanNo;
	}

	public String getTotalDeduction() {
		return totalDeduction;
	}

	public void setTotalDeduction(String totalDeduction) {
		this.totalDeduction = totalDeduction;
	}

	public String getTxnAmount() {
		return txnAmount;
	}

	public void setTxnAmount(String txnAmount) {
		this.txnAmount = txnAmount;
	}

	public String getTotalIncentive() {
		return totalIncentive;
	}

	public void setTotalIncentive(String totalIncentive) {
		this.totalIncentive = totalIncentive;
	}

	public String getNetAmount() {
		return netAmount;
	}

	public void setNetAmount(String netAmount) {
		this.netAmount = netAmount;
	}

	public String getBankMDR() {
		return bankMDR;
	}

	public void setBankMDR(String bankMDR) {
		this.bankMDR = bankMDR;
	}

	public String getBankMDRCharged() {
		return bankMDRCharged;
	}

	public void setBankMDRCharged(String bankMDRCharged) {
		this.bankMDRCharged = bankMDRCharged;
	}

	public String getGst() {
		return gst;
	}

	public void setGst(String gst) {
		this.gst = gst;
	}

	public String getGstCharged() {
		return gstCharged;
	}

	public void setGstCharged(String gstCharged) {
		this.gstCharged = gstCharged;
	}

	public String getBankIncentive() {
		return bankIncentive;
	}

	public void setBankIncentive(String bankIncentive) {
		this.bankIncentive = bankIncentive;
	}

	public String getTds() {
		return tds;
	}

	public void setTds(String tds) {
		this.tds = tds;
	}

	public String getTdsCharged() {
		return tdsCharged;
	}

	public void setTdsCharged(String tdsCharged) {
		this.tdsCharged = tdsCharged;
	}

	public String getAcqMDR() {
		return AcqMDR;
	}

	public void setAcqMDR(String AcqMDR) {
		this.AcqMDR = AcqMDR;
	}

	public String getAcqMDRCharged() {
		return AcqMDRCharged;
	}

	public void setAcqMDRCharged(String AcqMDRCharged) {
		this.AcqMDRCharged = AcqMDRCharged;
	}

	public String getAcqGST() {
		return AcqGST;
	}

	public void setAcqGST(String AcqGST) {
		this.AcqGST = AcqGST;
	}

	public String getAcqGSTCharged() {
		return AcqGSTCharged;
	}

	public void setAcqGSTCharged(String AcqGSTCharged) {
		this.AcqGSTCharged = AcqGSTCharged;
	}

	public String getAcqIncentive() {
		return AcqIncentive;
	}

	public void setAcqIncentive(String AcqIncentive) {
		this.AcqIncentive = AcqIncentive;
	}

	public String getAcqTDS() {
		return AcqTDS;
	}

	public void setAcqTDS(String AcqTDS) {
		this.AcqTDS = AcqTDS;
	}

	public String getAcqTDSCharged() {
		return AcqTDSCharged;
	}

	public void setAcqTDSCharged(String AcqTDSCharged) {
		this.AcqTDSCharged = AcqTDSCharged;
	}

	public String getacquiroShare() {
		return acquiroShare;
	}

	public void setacquiroShare(String acquiroShare) {
		this.acquiroShare = acquiroShare;
	}

	public String getPayoutStatus() {
		return payoutStatus;
	}

	public void setPayoutStatus(String payoutStatus) {
		this.payoutStatus = payoutStatus;
	}

	public String getPayoutDateTime() {
		return payoutDateTime;
	}

	public void setPayoutDateTime(String payoutDateTime) {
		this.payoutDateTime = payoutDateTime;
	}

	public String getEmpID() {
		return empID;
	}

	public void setEmpID(String empID) {
		this.empID = empID;
	}

	
	
	
	
	
	
}
