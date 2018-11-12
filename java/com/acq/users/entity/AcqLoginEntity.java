package com.acq.users.entity;
public class AcqLoginEntity {

private Long userId;

private String Name;
private String password;
public Long getUserId() {
	return userId;
}
public void setUserId(Long userId) {
	this.userId = userId;
}
public String getName() {
	return Name;
}
public void setName(String name) {
	Name = name;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}

}