package com.acq.dto;
import javax.validation.constraints.NotNull;
public class PageRequest {

	Integer pageIndex;
	Integer pageSize;
	String colName;
	Boolean isAsc;
	@NotNull
	String searchName;
	@NotNull
	Object searchValue;
	
	
	public Integer getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public Boolean getIsAsc() {
		return isAsc;
	}
	public void setIsAsc(Boolean isAsc) {
		this.isAsc = isAsc;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public Object getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(Object searchValue) {
		this.searchValue = searchValue;
	}
	
	
	
}
