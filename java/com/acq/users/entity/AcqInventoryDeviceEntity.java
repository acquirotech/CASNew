package com.acq.users.entity;

public class AcqInventoryDeviceEntity {

	
	private Long inventoryDeviceId;
	private String modelName;
	private String inventorySerialNo;
	private String dateTime;
	private String status;
	private String Acquirer;
	
	
	
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	public String getAcquirer() {
		return Acquirer;
	}
	public void setAcquirer(String acquirer) {
		Acquirer = acquirer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getInventoryDeviceId() {
		return inventoryDeviceId;
	}
	public void setInventoryDeviceId(Long inventoryDeviceId) {
		this.inventoryDeviceId = inventoryDeviceId;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getInventorySerialNo() {
		return inventorySerialNo;
	}
	public void setInventorySerialNo(String inventorySerialNo) {
		this.inventorySerialNo = inventorySerialNo;
	}
	
	
	
	
	
}
