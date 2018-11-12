package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AcqOrgModel {
	@NotNull
	@Pattern(regexp="^[0-9]{1,20}$",message="Invalid Merchant Id")
	private String AddOrgMid;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{2,60}$",message="Invalid Org Name")
	private String AddOrgName;
	
	@NotNull
	@Size(min=4,max=100, message="Invalid Org Address1")
	private String AddOrgAddress1;
	
	@NotNull
	@Size(min=4,max=100, message="Invalid Org Address2")
	private String AddOrgAddress2;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org City")
	private String AddOrgCity;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org State")
	private String AddOrgState;
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z\\s]{2,50}$",message="Invalid Org Country")
	private String AddOrgCountry;
	
	public String getAddOrgMid() {
		return AddOrgMid;
	}
	public void setAddOrgMid(String addOrgMid) {
		AddOrgMid = addOrgMid;
	}
	public String getAddOrgName() {
		return AddOrgName;
	}
	public void setAddOrgName(String addOrgName) {
		AddOrgName = addOrgName;
	}
	public String getAddOrgAddress1() {
		return AddOrgAddress1;
	}
	public void setAddOrgAddress1(String addOrgAddress1) {
		AddOrgAddress1 = addOrgAddress1;
	}
	public String getAddOrgAddress2() {
		return AddOrgAddress2;
	}
	public void setAddOrgAddress2(String addOrgAddress2) {
		AddOrgAddress2 = addOrgAddress2;
	}
	public String getAddOrgCity() {
		return AddOrgCity;
	}
	public void setAddOrgCity(String addOrgCity) {
		AddOrgCity = addOrgCity;
	}
	public String getAddOrgState() {
		return AddOrgState;
	}
	public void setAddOrgState(String addOrgState) {
		AddOrgState = addOrgState;
	}
	public String getAddOrgCountry() {
		return AddOrgCountry;
	}
	public void setAddOrgCountry(String addOrgCountry) {
		AddOrgCountry = addOrgCountry;
	}
	
}
