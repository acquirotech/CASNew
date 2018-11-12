package com.acq.web.handler.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.acq.AcqStatusDefination;
import com.acq.mail.AcqEmailServiceHandler;
import com.acq.users.dao.UserDaoInf;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.MainHandlerInf;


@Component
public class MainHandler implements MainHandlerInf{	

		final static Logger logger = Logger.getLogger(MainHandler.class); 
		
		@Autowired
		UserDaoInf usrDao;
		
		@Autowired
		AcqEmailServiceHandler AcqEmailServiceHandler;
	
		public ServiceDto<List<String>> getSettingUpdateList(AcqSettingModel modell) {
			ServiceDto<List<String>> response = new ServiceDto<List<String>>();
			logger.info("request in super details handler");
			try{
				DbDto<List<String>> daoResponse =usrDao.getSettingUpdateList(modell);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.error("error to get super details handler "+e);
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());				
			}
			return response;
		}

		public ServiceDto<List<String>> getSettingList() {
			ServiceDto<List<String>> response = new ServiceDto<List<String>>();
			logger.info("request in super details handler");
			try{
				DbDto<List<String>> daoResponse =  usrDao.getSettingList();
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.error("error to get super details handler "+e);
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
				
			}
			return response;
		}
	
		public ServiceDto<List<HashMap<String,String>>> getMerchantList(AcqSearchModel modell) {
			ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
			logger.info("request in super details handler");
			try{
				DbDto<List<HashMap<String,String>>> daoResponse = usrDao.getMerchantList(modell);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.error("error to get merchant details handler "+e);
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			}
			return response;
		}
		
		@Override
		public ServiceDto<HashMap<String,String>> getSuperAdminDetails(String emailId, String admnres) {
			ServiceDto<HashMap<String,String>> response = new ServiceDto<HashMap<String,String>>();
			logger.info("request in super details handler");
			try{
				DbDto<HashMap<String,String>> daoResponse = usrDao.getSuperAdminDetails(emailId,admnres);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.error("error to get super details handler "+e);
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
				return response;
			}
			return response;
		}
		
		@Override
		public ServiceDto<Object> getDetails(String servervalue) {
			ServiceDto<Object> response = new ServiceDto<Object>();
			logger.info("request in details handler");
			try{
				DbDto<Object> daoResponse = usrDao.getDetails();
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.error("error to get details handler "+e);
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
				return response;
			}
			return response;
			
		}
		
		@Override
		public ServiceDto<List<String>> getHomePageReport(String email) {
			ServiceDto<List<String>> response = new ServiceDto<List<String>>();
			try{
				DbDto<List<String>> daoResponse =usrDao.getHomePageReport(email);		
				
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String endDate = df.format(new Date());
					String startDate = null;
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date d1 = null;
					Date d2 = null;
					startDate = (daoResponse.getResult().get(2));
					d1 = format.parse(startDate);
					d2 = format.parse(endDate);
					long diff = d2.getTime() - d1.getTime();
					long diffDays = diff / (24 * 60 * 60 * 1000);
					if(diffDays>80&&diffDays<91){
						logger.info("notification time");
						HashMap<String,Object> pageData= new HashMap<String,Object>();
						try{
							pageData.put("email", email);
							pageData.put("fname",daoResponse.getResult().get(0) );
							AcqEmailServiceHandler.sendEmail(pageData,"/emailtemplate/empchangepass.html" , email);
						}catch(Exception e){
							logger.error("Error to send email "+e);
						}
					}			
					response.setStatus(daoResponse.getStatus());
					response.setMessage(daoResponse.getMessage());
					response.setResult(daoResponse.getResult());	
			}catch(Exception e){
				logger.error("error in welcome report "+e);
			}return response;
		}

		
	}	

