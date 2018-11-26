package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

public class PreBoardNewMerchant {
 
	@Pattern(regexp="^[0-9]{2,20}$",message="Invalid Preboard Merchant Id") 
	private String id;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\&]{0,50}$",message="Invalid CUB Branch")
	private String cubBranch;

	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\.\\&\\-\\s\\(\\)]{2,60}$",message="Invalid Name")
	private String name;
	
	@NotNull
	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid ExecutiveName")
	private String executiveName;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s\\&]{2,50}$",message="Invalid Marketing Name")
	private String marketingName;
	
	@NotNull
	@Pattern(regexp="^[0-9]{10,10}$",message="Invalid Phone No")
	private String phoneNo;
	
	@Pattern(regexp="^[a-zA-Z0-9\\s\\,\\/\\(\\)\\!\\#\\:\\_]{0,100}$",message="Invalid Note")
	private String note;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,20}$",message="Invalid Verification Status")
	private String status;
	
	@NotNull
	@Pattern(regexp="^[0-9]{0,8}[\\.]{0,1}[0-9]{0,2}?$",message="Invalid Amount")
	private String amount;
	
	@NotNull
	@Pattern(regexp="^[0-9]{2,10}$",message="Invalid Cheque No")
	private String chequeNo;
	
	@Pattern(regexp="^[0-9]{1,2}$",message="Invalid KycCheck")
	private String kycCheck;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\.\\&\\-\\s\\(\\)\\,]{2,45}$",message="Invalid Location")
	private String location;
	
	private MultipartFile file;
	
	@Pattern(regexp="^[0-9]{5,10}$",message="Invalid Request Token")
	private String requestToken;
	
	public String getRequestToken() {
		return requestToken;
	} 
	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken; 
	}
	
	public String getCubBranch() {
		return cubBranch;
	}
	public void setCubBranch(String cubBranch) {
		this.cubBranch = cubBranch;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getExecutiveName() {
		return executiveName;
	}
	public void setExecutiveName(String executiveName) {
		this.executiveName = executiveName;
	}
	public String getMarketingName() {
		return marketingName;
	}
	public void setMarketingName(String marketingName) {
		this.marketingName = marketingName;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getChequeNo() {
		return chequeNo;
	}
	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}
	public String getKycCheck() {
		return kycCheck;
	}
	public void setKycCheck(String kycCheck) {
		this.kycCheck = kycCheck;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	
	
}
