package com.acq.web.handler.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.mail.AcqEmailServiceHandler;
import com.acq.web.dao.ReportsDaoInf;
import com.acq.web.handler.ReportsHandlerInf;

@Component
public class ReportsHandler implements ReportsHandlerInf {

final static Logger logger = Logger.getLogger(ReportsHandler.class); 
	
	@Autowired
	ReportsDaoInf reportsDao;
	
	@Autowired
	AcqEmailServiceHandler AcqEmailServiceHandler;
	
	@Override
	public ServiceDto<List<HashMap<String, String>>> downloadCardTxnReport(String merchantId, String orgId, String userId, String fromDate,
			String toDate,String txnType) {
		logger.info("request landing in download Card txn report");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =reportsDao.downloadCardTxnReport(merchantId,orgId,userId,fromDate,toDate,txnType);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in download Card txn report "+e);
		}
		return response;
	}
	@Override
	public ServiceDto<List<HashMap<String, String>>> downloadRechargeReport(String merchantId, String orgId, String userId, String fromDate,
			String toDate,String txnType) {
		logger.info("request landing in download Recharge txn report");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =reportsDao.downloadRechargeReport(merchantId,orgId,userId,fromDate,toDate,txnType);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in download Recharge txn report "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<List<HashMap<String, String>>> downloadDmtReport(String merchantId, String orgId, String userId, String fromDate,
			String toDate,String txnType) {
		logger.info("request landing in download Dmt txn report");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =reportsDao.downloadDmtReport(merchantId,orgId,userId,fromDate,toDate,txnType);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in download Dmt txn report "+e);
		}
		return response;
	}
}
