package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqUpdateOrgModel {
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")
	private String UpdOrgMid;
	
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Org Id")
	private String UpdOrgId;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,60}$",message="Invalid Org Name")
	private String UpdOrgName;
	
	@NotNull
	@Size(min=4,max=100, message="Invalid Org Address1")
	private String UpdOrgAddress1;
	
	@NotNull
	@Size(min=4,max=100, message="Invalid Org Address2")
	private String UpdOrgAddress2;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org City")
	private String UpdOrgCity;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org State")
	private String UpdOrgState;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org Country")
	private String UpdOrgCountry;

	public String getUpdOrgMid() {
		return UpdOrgMid;
	}

	public void setUpdOrgMid(String updOrgMid) {
		UpdOrgMid = updOrgMid;
	}

	public String getUpdOrgId() {
		return UpdOrgId;
	}

	public void setUpdOrgId(String updOrgId) {
		UpdOrgId = updOrgId;
	}

	public String getUpdOrgName() {
		return UpdOrgName;
	}

	public void setUpdOrgName(String updOrgName) {
		UpdOrgName = updOrgName;
	}

	public String getUpdOrgAddress1() {
		return UpdOrgAddress1;
	}

	public void setUpdOrgAddress1(String updOrgAddress1) {
		UpdOrgAddress1 = updOrgAddress1;
	}

	public String getUpdOrgAddress2() {
		return UpdOrgAddress2;
	}

	public void setUpdOrgAddress2(String updOrgAddress2) {
		UpdOrgAddress2 = updOrgAddress2;
	}

	public String getUpdOrgCity() {
		return UpdOrgCity;
	}

	public void setUpdOrgCity(String updOrgCity) {
		UpdOrgCity = updOrgCity;
	}

	public String getUpdOrgState() {
		return UpdOrgState;
	}

	public void setUpdOrgState(String updOrgState) {
		UpdOrgState = updOrgState;
	}

	public String getUpdOrgCountry() {
		return UpdOrgCountry;
	}

	public void setUpdOrgCountry(String updOrgCountry) {
		UpdOrgCountry = updOrgCountry;
	}
	
	
}	
