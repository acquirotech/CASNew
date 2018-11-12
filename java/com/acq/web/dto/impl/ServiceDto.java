package com.acq.web.dto.impl;

import com.acq.web.dto.Page;
import com.acq.web.dto.ServiceDtoInf;

public class ServiceDto<T> implements ServiceDtoInf<T> {

	int status;
	String message;
	T result;
	Page page;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public T getResult() {
		return result;
	}
	public void setResult(T result) {
		this.result = result;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
	public static ServiceDto createHandlerResponse(DbDto daoResponse){
		ServiceDto serviceResponse = new ServiceDto();
		serviceResponse.setMessage(daoResponse.getMessage());
		serviceResponse.setPage(daoResponse.getPage());
		serviceResponse.setResult(daoResponse.getResult());
		serviceResponse.setStatus(daoResponse.getStatus());
		return serviceResponse;
		
	}
	
}
