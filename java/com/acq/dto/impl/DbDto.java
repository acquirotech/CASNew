package com.acq.dto.impl;

import com.acq.dto.DbDtoInf;
import com.acq.dto.Page;

public class DbDto<T> implements DbDtoInf<T>{

	
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
	
}
