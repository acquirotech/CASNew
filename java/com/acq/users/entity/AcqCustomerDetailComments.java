package com.acq.users.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Acq_sign_image", schema="acquiro_ver2")
public class AcqCustomerDetailComments {

	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true)
	private Long id;
	
	@Column(name="CALL_PURPOSE")
	private String callerId;
	
	@Column(name="CALLER_NAME")
	private String comment;
	private String user;
	private Date dateTime;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCallerId() {
		return callerId;
	}

	public void setCallerId(String callerId) {
		this.callerId = callerId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
	

}
