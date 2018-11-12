package com.acq.web.handler.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.acq.mail.AcqEmailServiceHandler;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dao.ListDaoInf;
import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.ListHandlerInf;

@Component
public class ListHandler implements ListHandlerInf {
	final static Logger logger = Logger.getLogger(ListHandler.class); 
	
	@Autowired
	ListDaoInf walletDao;
	
	@Autowired
	AcqEmailServiceHandler AcqEmailServiceHandler;
	
	@Override
	 public ServiceDto<List<HashMap<String, String>>> rechargeList(
	   AcqSearchModel modell) {
	  logger.info("request landing in recharge List");
	  ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
	  try{
	   DbDto<List<HashMap<String,String>>> daoResponse =walletDao.rechargeList(modell);
	   response.setStatus(daoResponse.getStatus());
	   response.setMessage(daoResponse.getMessage());
	   response.setResult(daoResponse.getResult());
	  }catch(Exception e){
	   logger.info("error in recharge List handler "+e);
	  }
	  return response;
	 }
	
	@Override
	 public ServiceDto<List<HashMap<String, String>>> transactionList(AcqSearchModel modell) {
	  logger.info("request landing in dmt transaction List");
	  ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
	  try{
	   DbDto<List<HashMap<String,String>>> daoResponse =walletDao.transactionList(modell);
	   response.setStatus(daoResponse.getStatus());
	   response.setMessage(daoResponse.getMessage());
	   response.setResult(daoResponse.getResult());
	  }catch(Exception e){
	   logger.info("error in dmt transaction List handler "+e);
	  }
	  return response;
	 }
	
	
	public ServiceDto<List<HashMap<String, String>>> downloadRiskDetails(String fromDate,String toDate) {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String, String>>> daoResponse = walletDao.downloadRiskDetails(fromDate,toDate);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in download Risk Details handler "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<List<HashMap<String, String>>> wholeTxnList(
			AcqSearchModel modell) {
		logger.info("request landing in whole Wallet List");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.wholeTxnList(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in whole Wallet List handler "+e);
		}
		return response;
	}
public ServiceDto<List<HashMap<String, String>>> txnMerchantlist1(AcqBillingModel modell) {
		logger.info("request landing in txn merchant list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnMerchantlist1(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn merchant List handler "+e);
		}
		return response;
	}

	public ServiceDto<List<HashMap<String, String>>> txnOrgList1(AcqBillingModel modell) {
		logger.info("request landing in txn org list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnOrgList1(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn org List handler "+e);
		}
		return response;
	}

	public ServiceDto<List<HashMap<String, String>>> txnTerminalList1(AcqBillingModel modell) {
		logger.info("request landing in txn terminal list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnTerminalList1(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn terminal List handler "+e);
		}
		return response;
	}
	
	

	
	
	
	
	
	
	@Override
	public ServiceDto<HashMap<String, String>> getCardTxnDetails(
			String signImage){
		ServiceDto<HashMap<String, String>>  response = new ServiceDto<HashMap<String, String>>();
		try{
			DbDto<HashMap<String, String>>  daoResponse = walletDao.getCardTxnDetails(signImage);
		    response.setMessage(daoResponse.getMessage());
			    response.setResult(daoResponse.getResult());
			    response.setStatus(daoResponse.getStatus());	 
			}catch(Exception e){
				logger.error("Error in transaction receipt handler "+e);
			}
			return response;
		}
	
	@Override
	public ServiceDto<String> addRisk(String txnId, String txnType) {
		logger.info("request landing in add risk status handler");
		ServiceDto<String> response = new ServiceDto<String>();
		try{
			DbDto<String> daoResponse =walletDao.addRisk(txnId,txnType);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in add risk status handler "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<Object> updateRiskStatus(String id,String txnType) {
			logger.info("request landing in update risk status handler");
			ServiceDto<Object> response = new ServiceDto<Object>();
			try{
				DbDto<Object> daoResponse =walletDao.updateRiskStatus(id,txnType);
				response.setStatus(daoResponse.getStatus());
				response.setMessage(daoResponse.getMessage());
				response.setResult(daoResponse.getResult());
			}catch(Exception e){
				logger.info("error in update risk status handler "+e);
			}
			return response;
	}
	

	
	@Override
	 public ServiceDto<List<HashMap<String, String>>> riskManagementList(
	   AcqSearchModel modell) {
	  logger.info("request landing in risk management List");
	  ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
	  try{
	   DbDto<List<HashMap<String,String>>> daoResponse =walletDao.riskManagementList(modell);
	   response.setStatus(daoResponse.getStatus());
	   response.setMessage(daoResponse.getMessage());
	   response.setResult(daoResponse.getResult());
	  }catch(Exception e){
	   logger.info("error in risk management List handler "+e);
	  }
	  return response;
	 }

	@Override
	public ServiceDto<List<HashMap<String, String>>> txnMerchantlist(AcqBillingModel modell) {
		logger.info("request landing in txn merchant list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnMerchantlist(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn merchant List handler "+e);
		}
		return response;
	}

	@Override
	public ServiceDto<List<HashMap<String, String>>> txnOrgList(AcqBillingModel modell) {
		logger.info("request landing in txn org list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnOrgList(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn org List handler "+e);
		}
		return response;
	}

	@Override
	public ServiceDto<List<HashMap<String, String>>> txnTerminalList(AcqBillingModel modell) {
		logger.info("request landing in txn terminal list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.txnTerminalList(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in txn terminal List handler "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<List<HashMap<String,String>>> walletList(AcqSearchModel modell) {
		logger.info("request landing in Wallet List");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse =walletDao.walletList(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Wallet List handler "+e);
		}
		return response;
	}
	
	@Override
	public ServiceDto<String> updateMdr(String txnId, String AcqMdr, String bankMdr) {
		ServiceDto<String> response = new ServiceDto<String>();
		try{
			DbDto<String> daoResponse =walletDao.updateMdr(txnId,AcqMdr,bankMdr);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in update mdr status handler "+e);
		}
		return response;
	}



}
