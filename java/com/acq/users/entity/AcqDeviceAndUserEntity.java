package com.acq.users.entity;

public class AcqDeviceAndUserEntity {

	private String id;
	private String bankTid;
	private Long userId;
	private AcqUserEntity AcqUserEntity;
	
	
	public AcqUserEntity getAcqUserEntity() {
		return AcqUserEntity;
	}
	public void setAcqUserEntity(AcqUserEntity AcqUserEntity) {
		this.AcqUserEntity = AcqUserEntity;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBankTid() {
		return bankTid;
	}
	public void setBankTid(String bankTid) {
		this.bankTid = bankTid;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	
	
}
