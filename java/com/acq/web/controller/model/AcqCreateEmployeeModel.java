package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class AcqCreateEmployeeModel {
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9\\s]{3,30}$",message="Invalid Name")
	private String employeeName;
	
	@NotNull
	@Pattern(regexp="^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9_\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$|{0}$",message="Invalid Email")
	private String empEmailId;
	
	@NotNull
	@Pattern(regexp="^[0-9\\,]{10,10}$",message="Invalid Phone No")
	private String empPhone;
	
	@NotNull
	@Pattern(regexp="^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\\s).{8,20}$",message="Invalid Password")
	private String empPassword;
	
	private String empEnabled;
	
	private String reportManager;
	
	@NotNull
	private String empRole;

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmpEmailId() {
		return empEmailId;
	}

	public void setEmpEmailId(String empEmailId) {
		this.empEmailId = empEmailId;
	}

	public String getEmpPhone() {
		return empPhone;
	}

	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}

	public String getEmpPassword() {
		return empPassword;
	}

	public void setEmpPassword(String empPassword) {
		this.empPassword = empPassword;
	}

	public String getEmpEnabled() {
		return empEnabled;
	}

	public void setEmpEnabled(String empEnabled) {
		this.empEnabled = empEnabled;
	}

	public String getEmpRole() {
		return empRole;
	}

	public void setEmpRole(String empRole) {
		this.empRole = empRole;
	}

	public String getReportManager() {
		return reportManager;
	}

	public void setReportManager(String reportManager) {
		this.reportManager = reportManager;
	}
	
	
}
