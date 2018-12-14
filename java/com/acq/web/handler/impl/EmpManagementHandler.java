package com.acq.web.handler.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.acq.mail.AcqEmailServiceHandler;
import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqDSAModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqTeleCallerModel;
import com.acq.web.dao.EmpManagementDaoInf;
import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.EmpManagementHandlerInf;

@Component
public class EmpManagementHandler implements EmpManagementHandlerInf {

final static Logger logger = Logger.getLogger(EmpManagementHandler.class); 
	
	@Autowired
	EmpManagementDaoInf empManagementDao;
	
	@Autowired
	AcqEmailServiceHandler AcqEmailServiceHandler;
	@Override
	 public ServiceDto<String> updateTeleCustomer(AcqTeleCallerModel modell) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = empManagementDao.updateTeleCustomer(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in create Tele Customer handler "+e);
		}
		return response;
	 }
	
	@Override
	public ServiceDto<HashMap<String, String>> callerDetails(String callerId) {
		logger.info("request landing in emp profile handler");
			ServiceDto<HashMap<String,String>> response = new ServiceDto<HashMap<String,String>>();
			try{
				DbDto<HashMap<String,String>> daoResponse =empManagementDao.callerDetails(callerId);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.info("error in emp lock handler "+e);
			}
			return response;
		}
	
	@Override
	 public ServiceDto<String> createTeleCustomer(AcqTeleCallerModel modell) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = empManagementDao.createTeleCustomer(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in create Tele Customer handler "+e);
		}
		return response;
	 }
	
	public ServiceDto<List<HashMap<String, String>>> teleCustomerList(AcqSearchModel model){
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			System.out.println("Request landing in employee list handler");
			DbDto<List<HashMap<String, String>>>  daoResponse = empManagementDao.teleCustomerList(model);
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
			response.setStatus(daoResponse.getStatus());	  
		}catch(Exception e){
			logger.error("Error in employee list handler "+e);			
		}return response;
	}
	
	@Override
	 public ServiceDto<String> deleteTeleCaller(String empId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = empManagementDao.deleteTeleCaller(empId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Employee handler "+e);
		}
		return response;
	 }
	
	@Override
	 public ServiceDto<List<HashMap<String,String>>> dsaManagement() {
		ServiceDto<List<HashMap<String,String>>>  response = new ServiceDto<List<HashMap<String,String>>> ();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse = empManagementDao.dsaManagement();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in dsa list handler "+e);
		}
		return response;
	 }
	
	@Override
	 public ServiceDto<AcqDSAModel> addDsa(AcqDSAModel model) {
		ServiceDto<AcqDSAModel>  response = new ServiceDto<AcqDSAModel> ();
		try{
			DbDto<AcqDSAModel> daoResponse = empManagementDao.addDsa(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in DSA add handler "+e);
		}
		return response;
	 }
	
	@Override
	 public ServiceDto<AcqDSAModel> updateDSA(AcqDSAModel model) {
		ServiceDto<AcqDSAModel>  response = new ServiceDto<AcqDSAModel> ();
		try{
			DbDto<AcqDSAModel> daoResponse = empManagementDao.updateDSA(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in updated dsa handler "+e);
		}
		return response;
	 }
	
	@Override
	 public ServiceDto<String> deleteEmployee(String empId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = empManagementDao.deleteEmployee(empId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Employee handler "+e);
		}
		return response;
	 }
	
	@Override
	public ServiceDto<AcqEmpDetailsModel> empChangePassword(
			AcqEmpDetailsModel modell) {
			ServiceDto<AcqEmpDetailsModel>  response = new ServiceDto<AcqEmpDetailsModel> ();
			try{
				DbDto<AcqEmpDetailsModel> daoResponse = empManagementDao.empChangePassword(modell);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
				if(daoResponse.getMessage().equals("OK")){
					if(modell.getEmail()!=null|| modell.getEmail()!=""|| modell.getEmail().length()>=4){
					     try{
					    	 HashMap<String,Object> pageData= new HashMap<String,Object>();
					    	 pageData.put("email", modell.getEmail());
					    	 pageData.put("fname", modell.getName());    
					    	 AcqEmailServiceHandler.sendEmail(pageData,"/emailtemplate/empchangepass.html" , "parul@Acqswipe.us");
					     }catch(Exception e){
					      logger.error("error to send email in emp change password "+e);
					     }
					}
				}
			}catch(Exception e){
				logger.info("error in employee change password handler "+e);
			}
			return response;	
		}

	@Override
	public ServiceDto<HashMap<String, String>> empChangePassword1(String empEmailId) {
			logger.info("request landing in emp profile handler");
				ServiceDto<HashMap<String,String>> response = new ServiceDto<HashMap<String,String>>();
				try{
					DbDto<HashMap<String,String>> daoResponse =empManagementDao.empChangePassword(empEmailId);
					response.setStatus(daoResponse.getStatus());
					response.setMessage(daoResponse.getMessage());
					response.setResult(daoResponse.getResult());
				}catch(Exception e){
					logger.info("error in emp lock handler "+e);
				}
				return response;
	}
	public ServiceDto<List<HashMap<String, String>>> empList() {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			logger.info("request in sale executive list handler");
			DbDto<List<HashMap<String, String>>> daoResponse = empManagementDao.empList();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in sale executive list handler "+e);
		}
		return response;
	}
	public ServiceDto<List<HashMap<String, String>>> empReportList() {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			logger.info("request in sale executive list handler");
			DbDto<List<HashMap<String, String>>> daoResponse = empManagementDao.empReportList();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in sale executive list handler "+e);
		}
		return response;
	}
	@Override
	public ServiceDto<Object> addEmployee(AcqCreateEmployeeModel model) {
		logger.info("request landing in create employee handler");
		ServiceDto<Object> response = new ServiceDto<Object>();
		try{
			DbDto<Object> daoResponse = empManagementDao.addEmployee(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());	
		}catch(Exception e){
			logger.info("error in add employee handler "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<AcqEmpDetailsModel> empChangeProfile(
			AcqEmpDetailsModel modell) {
		ServiceDto<AcqEmpDetailsModel>  response = new ServiceDto<AcqEmpDetailsModel> ();
		try{
			DbDto<AcqEmpDetailsModel> daoResponse = empManagementDao.empChangeProfile(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Update emp change handler "+e);
		}
		return response;
		
	}

	@Override
	public ServiceDto<List<HashMap<String, String>>> emplockunlock() {
		logger.info("request landing in emp lock handler");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =empManagementDao.emplockunlock();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in emp lock handler "+e);
		}
		return response;
	}

	@Override
	public ServiceDto<HashMap<String, String>> empProfile(String empId) {
		logger.info("request landing in emp profile handler");
			ServiceDto<HashMap<String,String>> response = new ServiceDto<HashMap<String,String>>();
			try{
				DbDto<HashMap<String,String>> daoResponse =empManagementDao.empProfile(empId);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.info("error in emp lock handler "+e);
			}
			return response;
		}
	
}
