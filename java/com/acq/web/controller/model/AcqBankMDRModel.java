package com.acq.web.controller.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

public class AcqBankMDRModel {
	
	@NotNull
	@Pattern(regexp="^[a-zA-Z]{6,10}$",message="Invalid Account No")
	private String accessAddress;
	
	private MultipartFile mdrFile;
	
	public String getAccessAddress() {
		return accessAddress;
	}
	public void setAccessAddress(String accessAddress) {
		this.accessAddress = accessAddress;
	}
	public MultipartFile getMdrFile() {
		return mdrFile;
	}
	public void setMdrFile(MultipartFile mdrFile) {
		this.mdrFile = mdrFile;
	}
	
	
	
}
