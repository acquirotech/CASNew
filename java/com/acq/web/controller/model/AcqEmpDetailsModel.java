package com.acq.web.controller.model;

public class AcqEmpDetailsModel {

private String	empid;
private String	name;
private String	email;
private String	phone;
private String	enabled;
private String	createdOn;
private String	emprole;
private String  password;
private String reportManager;


public String getReportManager() {
	return reportManager;
}
public void setReportManager(String reportManager) {
	this.reportManager = reportManager;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getEmpid() {
	return empid;
}
public void setEmpid(String empid) {
	this.empid = empid;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getEnabled() {
	return enabled;
}
public void setEnabled(String enabled) {
	this.enabled = enabled;
}
public String getCreatedOn() {
	return createdOn;
}
public void setCreatedOn(String createdOn) {
	this.createdOn = createdOn;
}
public String getEmprole() {
	return emprole;
}
public void setEmprole(String emprole) {
	this.emprole = emprole;
}
}
