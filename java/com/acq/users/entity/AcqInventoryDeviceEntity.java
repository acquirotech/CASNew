package com.acq.users.entity;

public class AcqInventoryDeviceEntity {

	
	private Long inventoryDeviceId;
	private String modelName;
	private String inventorySerialNo;
	private String dateTime;
	private String status;
	private String Acquirer;
	private String batterySerialNo;
	private String adapterSerialNo;
	private String dsaList;
	
	
	
	public String getBatterySerialNo() {
		return batterySerialNo;
	}
	public void setBatterySerialNo(String batterySerialNo) {
		this.batterySerialNo = batterySerialNo;
	}
	public String getAdapterSerialNo() {
		return adapterSerialNo;
	}
	public void setAdapterSerialNo(String adapterSerialNo) {
		this.adapterSerialNo = adapterSerialNo;
	}
	public String getDsaList() {
		return dsaList;
	}
	public void setDsaList(String dsaList) {
		this.dsaList = dsaList;
	}
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
