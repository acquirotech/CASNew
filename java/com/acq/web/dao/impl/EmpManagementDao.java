package com.acq.web.dao.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.acq.AcqBase;
import com.acq.AcqNumberValidator;
import com.acq.AcqStatusDefination;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.users.entity.AcqCustomerDetailComments;
import com.acq.users.entity.AcqCustomerDetails;
import com.acq.users.entity.AcqDsaEntity;
import com.acq.users.entity.AcqEmpPasswordEntity;
import com.acq.users.entity.AcqEmpRoleEntity;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization1;
import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqDSAModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqTeleCallerModel;
import com.acq.web.dao.EmpManagementDaoInf;
import com.acq.web.dto.impl.DbDto;

@Repository
public class EmpManagementDao implements EmpManagementDaoInf {

	final static Logger logger = Logger.getLogger(EmpManagementDao.class);  

	@Autowired
	AcqMerchantDaoImpl AcqMerchantDaoImpl;

	@Override
	 public DbDto<String> updateTeleCustomer(AcqTeleCallerModel model) {
		DbDto<String> response = new DbDto<String>();
		Session session = AcqMerchantDaoImpl.getSession();
		Transaction tx = null;
		try {
			if (model.getUser() != null && model.getUser() != "") {
				AcqCustomerDetails customerDetailEnt = (AcqCustomerDetails) session.createCriteria(AcqCustomerDetails.class).add(Restrictions.eq("id", Long.valueOf(model.getId()))).uniqueResult();
				if(customerDetailEnt==null||customerDetailEnt+""==""){
					logger.warn("No records fetch");
					return null;
				}else{	
				customerDetailEnt.setCallerName(model.getCallerName());
				customerDetailEnt.setCallType(model.getCallType());
				customerDetailEnt.setCallPurpose(model.getCallPurpose());
				DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
				customerDetailEnt.setUpdatedDateTime(smdf.parse(smdf.format(new Date())));	
				customerDetailEnt.setMerchantName(model.getMerchantName());
				customerDetailEnt.setUpdatedBy(model.getUser());
				customerDetailEnt.setCallbackNo(model.getCallbackNo());
				 session.saveOrUpdate(customerDetailEnt);
			    AcqCustomerDetailComments customerDetailCommentEnt = new AcqCustomerDetailComments();	
			    customerDetailCommentEnt.setCallerId(""+customerDetailEnt.getId());
				customerDetailCommentEnt.setComment(model.getComment());
				customerDetailCommentEnt.setUser(model.getUser());
				customerDetailCommentEnt.setDateTime(smdf.parse(smdf.format(new Date())));
				session.save(customerDetailCommentEnt);
			    response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(""+customerDetailEnt.getId());
				tx = session.beginTransaction();
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Detail Added Succesfully");
				}
		    }else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("Detail not found");
		}			
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete Employee :" + e);
		}
		return response;
	 }
	
	@Override
	public DbDto<HashMap<String, String>> callerDetails(String callerId) {
		DbDto<HashMap<String,String>> globleMap = new DbDto<HashMap<String,String>>();
		HashMap<String,String> empDetails = new HashMap<String,String>();
		Session session = AcqMerchantDaoImpl.getSession();
		HashMap<String, String> map = null;
		try{
			AcqCustomerDetails entity = (AcqCustomerDetails) session.createCriteria(AcqCustomerDetails.class).add(Restrictions.eq("id", Long.valueOf(callerId))).uniqueResult();
			if(entity==null||entity+""==""){
				logger.warn("No records fetch");
				return null;
			}else{	
				
				logger.info("employee details is fetched");
				empDetails.put("id",String.valueOf(entity.getId()));
				empDetails.put("callerName",entity.getCallerName());	
				empDetails.put("callPurpose",entity.getCallPurpose());
				empDetails.put("dateTime",""+entity.getDateTime());
				empDetails.put("userName",entity.getUserName());
				empDetails.put("merchantName",entity.getMerchantName());
				empDetails.put("callType",entity.getCallType());
				empDetails.put("callbackNo",entity.getCallbackNo());
				List<AcqCustomerDetailComments> entity1 = (List<AcqCustomerDetailComments>) session.createCriteria(AcqCustomerDetailComments.class).add(Restrictions.eq("callerId", callerId)).list();
				if(entity1==null||entity1+""==""){
					logger.warn("No records fetch");
					return null;
				}else{
					Iterator<AcqCustomerDetailComments> itr1 = entity1.iterator();
					 Set<String> empIdSet = new HashSet<>();
					while(itr1.hasNext()){
						AcqCustomerDetailComments comments = (AcqCustomerDetailComments)itr1.next();
						empIdSet.add(comments.getUser());				
					}
					HashMap<String, String> createdEMpMap = null;
					try{
						Criteria org =session.createCriteria(AcqEmpRoleEntity.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("emailId"));
					     proList.add(Projections.property("name"));
					     org.setProjection(proList).add((Restrictions.in("emailId", empIdSet)));
					    List list1 = org.list();
					    createdEMpMap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        createdEMpMap.put("createdEmpName"+ob[0],""+ob[1]);					      
					    }
					}catch(Exception e){
						logger.error("error to select Emp "+e);
					}
					StringBuffer b = new StringBuffer();
					b.append("<ol>");
					logger.info("employee details is fetched");
					Iterator<AcqCustomerDetailComments> itr = entity1.iterator();
					 int i=1;
					while(itr.hasNext()){
						AcqCustomerDetailComments comments = (AcqCustomerDetailComments)itr.next();
							b.append("<li>"+comments.getComment()+"<small>"+"  --"+createdEMpMap.get("createdEmpName"+comments.getUser())+"</small>"+"</li>");						
					}
					b.append("</ol>");					
					empDetails.put("comments",""+b);
				}
			}
			logger.info("Emp detail successfully selected");
			globleMap.setResult(empDetails);
			globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
			globleMap.setMessage(AcqStatusDefination.OK.getDetails());
			return globleMap;
		}catch(Exception e){
			logger.error("Error in emp profile dao"+e);
			return globleMap;
		}
	}
	
	@Override
	 public DbDto<String> createTeleCustomer(AcqTeleCallerModel model) {
		DbDto<String> response = new DbDto<String>();
		Session session = AcqMerchantDaoImpl.getSession();
		Transaction tx = null;
		try {
			if (model.getUser() != null && model.getUser() != "") {
				AcqCustomerDetails customerDetailEnt = new AcqCustomerDetails();	   
				customerDetailEnt.setCallerName(model.getCallerName());
				customerDetailEnt.setCallType(model.getCallType());
				customerDetailEnt.setCallPurpose(model.getCallPurpose());
				DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
				customerDetailEnt.setDateTime(smdf.parse(smdf.format(new Date())));	
				customerDetailEnt.setUpdatedDateTime(smdf.parse(smdf.format(new Date())));	
				customerDetailEnt.setMerchantName(model.getMerchantName());
				customerDetailEnt.setUserName(model.getUser());
				customerDetailEnt.setUpdatedBy(model.getUser());
				customerDetailEnt.setCallbackNo(model.getCallbackNo());
				 session.save(customerDetailEnt);
			    AcqCustomerDetailComments customerDetailCommentEnt = new AcqCustomerDetailComments();	
			    customerDetailCommentEnt.setCallerId(""+customerDetailEnt.getId());
				customerDetailCommentEnt.setComment(model.getComment());
				customerDetailCommentEnt.setUser(model.getUser());
				customerDetailCommentEnt.setDateTime(smdf.parse(smdf.format(new Date())));
				session.save(customerDetailCommentEnt);
			    response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(""+customerDetailEnt.getId());
				tx = session.beginTransaction();
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Detail Added Succesfully");
		    }else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("Detail not found");
		}			
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete Employee :" + e);
		}
		return response;
	 }
	@Override
	public DbDto<List<HashMap<String, String>>> teleCustomerList(AcqSearchModel model){
		DbDto<List<HashMap<String, String>>> response = new DbDto<List<HashMap<String, String>>>();
		List<HashMap<String, String>> globalList = new ArrayList<HashMap<String, String>>();
		try	{
			Session session = AcqMerchantDaoImpl.getSession();
			HashMap<String, String> map = null;
			SimpleDateFormat sdtf = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdtf1 = new SimpleDateFormat("yyyy-MM-dd");
			Criteria criteriaList = session.createCriteria(AcqCustomerDetails.class);
			Criteria row = session.createCriteria(AcqCustomerDetails.class);
			row.setProjection(Projections.rowCount());
			criteriaList.addOrder(Order.desc("id"));
			criteriaList.setFirstResult((Integer.valueOf(model.getPage()) - 1) * 20);
			criteriaList.setMaxResults(20);
			List mainList = criteriaList.list();
			Set<String> empIdSet = new HashSet<String>();
			Set<String> updatedEmpIdSet = new HashSet<String>();
			Set<Long> merchantSet = new HashSet<Long>();
			HashMap<String, String> createdEMpMap = null;
			HashMap<String, String> updatedEMpMap = null;
			HashMap<String,String> merchantMap = null;
			if(mainList.isEmpty()){
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				map = new HashMap<String,String>();
				map.put("123","123");
				globalList.add(map);
				response.setResult(globalList);
				logger.info("employee empty list selected.");
				return response;				
			}else{
				logger.info("11111111111111111");
				Iterator<AcqCustomerDetails> itr1 = mainList.iterator();
				while(itr1.hasNext()){
					logger.info("2222222222222222222");
					AcqCustomerDetails entity = (AcqCustomerDetails)itr1.next();
					empIdSet.add(entity.getUserName());
					updatedEmpIdSet.add(entity.getUpdatedBy());
					merchantSet.add(Long.valueOf(entity.getMerchantName().toString()));
				}try{
					logger.info("3333333333333333333333");
					Criteria merchant =session.createCriteria(AcqMerchant.class);
				    ProjectionList proList = Projections.projectionList();
				    proList.add(Projections.property("merchantId"));
				    proList.add(Projections.property("merchantName"));
				    merchant.setProjection(proList).add((Restrictions.in("merchantId", merchantSet)));
				    List list1 = merchant.list();
				    merchantMap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        merchantMap.put("merchantName"+ob[0],""+ob[1]);					      
				    }
				}catch(Exception e){
					logger.error("error to select merchant "+e);
				}
				try{
					logger.info("4444444444444444");
					Criteria org =session.createCriteria(AcqEmpRoleEntity.class);
				    ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("emailId"));
				     proList.add(Projections.property("name"));
				     org.setProjection(proList).add((Restrictions.in("emailId", empIdSet)));
				    List list1 = org.list();
				    createdEMpMap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        createdEMpMap.put("createdEmpName"+ob[0],""+ob[1]);					      
				    }
				}catch(Exception e){
					logger.error("error to select Emp "+e);
				}
				try{
					logger.info("555555555555555555555.");
					Criteria org =session.createCriteria(AcqEmpRoleEntity.class);
				    ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("emailId"));
				     proList.add(Projections.property("name"));
				     org.setProjection(proList).add((Restrictions.in("emailId", updatedEmpIdSet)));
				    List list1 = org.list();
				    updatedEMpMap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        updatedEMpMap.put("updatedEmpName"+ob[0],""+ob[1]);					      
				    }
				}catch(Exception e){
					logger.error("error to select Emp "+e);
				}
				Iterator<AcqCustomerDetails> itr = mainList.iterator();
				while(itr.hasNext()){
					logger.info("66666666666666666666666666");
					AcqCustomerDetails entity = (AcqCustomerDetails)itr.next();
					map = new HashMap<String, String>();					
						map.put("id",String.valueOf(entity.getId()));
						map.put("callerName",entity.getCallerName());	
						map.put("callPurpose",entity.getCallPurpose());
						 if(entity.getCallPurpose().equalsIgnoreCase("1")){
							map.put("callPurpose","Software grievances");
						}else if(entity.getCallPurpose().equalsIgnoreCase("2")){
							map.put("callPurpose","Hardware repairs");
						}else if(entity.getCallPurpose().equalsIgnoreCase("3")){
							map.put("callPurpose","Transaction related queries");
						}else if(entity.getCallPurpose().equalsIgnoreCase("4")){
							map.put("callPurpose","Charge pack/Cash@pos");
						}else if(entity.getCallPurpose().equalsIgnoreCase("5")){
							map.put("callPurpose","Technical support");
						}else if(entity.getCallPurpose().equalsIgnoreCase("6")){
							map.put("callPurpose","Rental call");
						}else if(entity.getCallPurpose().equalsIgnoreCase("7")){
							map.put("callPurpose","Change of bank account");
						}else if(entity.getCallPurpose().equalsIgnoreCase("8")){
							map.put("callPurpose"," New Pos inquiry/Sign up");
						}else{
							map.put("callPurpose","Others");
						}
					//	SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					//	String dbDate = sdfSource.format(entity.getDateTime());
					   // Date date = sdfSource.parse(entity.getUpdatedDateTime());
					  //  SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
					    SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
					    SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
					    System.out.println("ede::"+""+sdfDestination.format(entity.getDateTime()));
					   map.put("dateTime",""+sdfDestination.format(entity.getDateTime()));
						logger.info("777777777777777");
						map.put("userName",createdEMpMap.get("createdEmpName"+entity.getUserName()));
						map.put("updatedBy",updatedEMpMap.get("updatedEmpName"+entity.getUpdatedBy()));
						if(merchantMap.get("merchantName"+entity.getMerchantName())==null||merchantMap.get("merchantName"+entity.getMerchantName())==""){
							map.put("merchantName", "Unknown");
							map.put("mid","0");
					      }else{
					    	  map.put("mid",""+entity.getMerchantName());
					    	  map.put("merchantName", ""+merchantMap.get("merchantName"+entity.getMerchantName()));
					      }
						logger.info("888888888888888888888");
						map.put("callType",entity.getCallType());
					globalList.add(map);
				}
			}
				Long rowsNo = (Long) row.uniqueResult();
				Long totalRows= rowsNo/20;
				Long modlus = rowsNo%20;
				HashMap<String,String> rowsMap = new HashMap<String,String>();
				if(totalRows<=0){
					rowsMap.put("rows","1");
				}else{
					if(modlus>0){
						rowsMap.put("rows",totalRows+1+"");
					}else{
						rowsMap.put("rows",totalRows+"");
					}
				}
				globalList.add(0,rowsMap);
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(globalList);
				logger.info("employee list selected.");
			
		}catch(Exception e){
			logger.error("error employee list "+e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			response.setResult(globalList);
		}
		return response;
	}
	
	@Override
	 public DbDto<String> deleteTeleCaller(String empId) {
		DbDto<String> response = new DbDto<String>();
		Session session = AcqMerchantDaoImpl.getSession();
		Transaction tx = null;
		try {
			if (empId != null && empId != "") {
				AcqCustomerDetails AcqEmp = (AcqCustomerDetails) session.createCriteria(AcqCustomerDetails.class).add(Restrictions.eq("id", Long.valueOf(empId))).uniqueResult();
				if (AcqEmp != null && AcqEmp + "" != ""){
					tx = session.beginTransaction();
					session.delete(AcqEmp);
					List<AcqCustomerDetailComments> emp = (List<AcqCustomerDetailComments>) session.createCriteria(AcqCustomerDetailComments.class).add(Restrictions.eq("callerId", (empId))).list();
					if(emp !=null&& emp+""!=""){
						Iterator<AcqCustomerDetailComments> itr = emp.iterator();
						while(itr.hasNext()){
							AcqCustomerDetailComments entity = (AcqCustomerDetailComments)itr.next();
					session.delete(entity);
						}
					}else{
						logger.info("Caller Not Found For Delete");
					}
					tx.commit();
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("Caller is successfully deleted");
				
				}else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("Caller not found");
				}
			} else {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Caller is not available");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete Caller :" + e);
		}
		return response;
	 }
	
	@Override
	public DbDto<AcqDSAModel> updateDSA(AcqDSAModel model) {
		logger.info("request landing in add employee dao");
		DbDto<AcqDSAModel> response = new DbDto<AcqDSAModel>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			logger.info("session object is created");
			AcqDsaEntity emp = (AcqDsaEntity) session.createCriteria(AcqDsaEntity.class).add(Restrictions.eq("id", Long.valueOf(model.getUpdateId()))).uniqueResult();
			if(emp!=null&&emp+""!=""){
			emp.setName(model.getName());
			emp.setCashatposIncentive(model.getCashAtPosIncentive());
			emp.setDeviceRental(model.getDeviceRent());
			emp.setAddress(model.getAddress());
			DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");		
			emp.setDate(smdf.format(new Date()));	
			emp.setMdrCreditNpre(new BigDecimal(model.getMdrCreditNpre()));
			emp.setMdrCreditPre(new BigDecimal(model.getMdrCreditPre()));
			emp.setAddress(model.getAddress());
			emp.setMdrDebit0(new BigDecimal(model.getMdrDebit0()));
			emp.setMdrDebit1(new BigDecimal(model.getMdrDebit1()));
			emp.setMdrDebit2(new BigDecimal(model.getMdrDebit2()));
			session.update(emp);
			Transaction tx = session.beginTransaction();
			tx.commit();
		    response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			//response.setResult(emp.getId());
			}
			else{
				
			}
			logger.info("DSA updated successfully");    
	    }catch(NumberFormatException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem in updated DSA dao "+e);
		}catch(NullPointerException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in updated DSA dao "+e);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to create hibernate session in updated DSA dao "+e);
		}
		return response;
	}
	
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> dsaManagement() {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			 
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		    Criteria tx= session.createCriteria(AcqDsaEntity.class);				
			List list = tx.list();
			Iterator etr = list.iterator();	
			HashMap empMap=null;
			while(etr.hasNext()){
				empMap = new HashMap<String, String>();
				AcqDsaEntity txEntity = (AcqDsaEntity)etr.next();
				empMap.put("dsaid", ""+txEntity.getId());
				empMap.put("name",""+txEntity.getName()); 
				empMap.put("deviceRental",""+txEntity.getDeviceRental()); 
				empMap.put("cashatPosIncentive",""+txEntity.getCashatposIncentive()); 
				empMap.put("mdr0",""+txEntity.getMdrDebit0()); 
				empMap.put("mdr1",""+txEntity.getMdrDebit1()); 
				empMap.put("address",""+txEntity.getAddress());
				empMap.put("mdrCre",""+txEntity.getMdrCreditNpre()); 
				empMap.put("mdrNonPre",""+txEntity.getMdrCreditPre()); 
				empMap.put("other",""+txEntity.getOther()); 
				empMap.put("mdr2",""+txEntity.getMdrDebit2()); 
				empMap.put("walletMdr",""+txEntity.getWalletMdr()); 
				globalList.add(empMap);  
			}
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			return global;
	}catch(Exception e){
		global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		global.setMessage(AcqStatusDefination.RollBackError.getDetails());
		logger.error("error"+e);
		return null;
	}
}
	@Override
	public DbDto<AcqDSAModel> addDsa(AcqDSAModel model) {
		logger.info("request landing in add employee dao");
		DbDto<AcqDSAModel> response = new DbDto<AcqDSAModel>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			logger.info("session object is created");
			AcqDsaEntity emp = new AcqDsaEntity();	   
			emp.setName(model.getName());
			emp.setCashatposIncentive(model.getCashAtPosIncentive());
			emp.setDeviceRental(model.getDeviceRent());
			emp.setAddress(model.getAddress());
			DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");		
			emp.setDate(smdf.format(new Date()));	
			emp.setMdrCreditNpre(new BigDecimal(model.getMdrCreditNpre()));
			emp.setMdrCreditPre(new BigDecimal(model.getMdrCreditPre()));
			emp.setAddress(model.getAddress());
			emp.setMdrDebit0(new BigDecimal(model.getMdrDebit0()));
			emp.setWalletMdr(new BigDecimal(model.getWalletMdr()));
			emp.setMdrDebit1(new BigDecimal(model.getMdrDebit1()));
			emp.setMdrCashAtPos(new BigDecimal(model.getMdrCashAtpos()));
			emp.setCashatposIncentive(model.getCashAtPosIncentive());
			
			emp.setMdrDebit2(new BigDecimal(model.getMdrDebit2()));
			session.save(emp);
			Transaction tx = session.beginTransaction();
			tx.commit();
		    response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			//response.setResult(emp.getId());
			
			logger.info("DSA added successfully");    
	    }catch(NumberFormatException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem in add DSA dao "+e);
		}catch(NullPointerException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in add DSA dao "+e);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to create hibernate session in add DSA dao "+e);
		}
		return response;
	}
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> empList() {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			 
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		    Criteria tx= session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("empRole", "5"));				
			List list = tx.list();
			Iterator etr = list.iterator();	
			HashMap empMap=null;
			while(etr.hasNext()){
				empMap = new HashMap<String, String>();
				AcqEmpRoleEntity txEntity = (AcqEmpRoleEntity)etr.next();
				empMap.put("executiveEmail",""+txEntity.getEmailId()); 
				empMap.put("executiveName",""+txEntity.getName()); 
				empMap.put("executiveId",""+txEntity.getId()); 
				globalList.add(empMap);  
			}
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			return global;
	}catch(Exception e){
		global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		global.setMessage(AcqStatusDefination.RollBackError.getDetails());
		logger.error("error"+e);
		return null;
	}
}
	@Transactional
	public DbDto<List<HashMap<String, String>>> empReportList() {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			 
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		    Criteria tx= session.createCriteria(AcqEmpRoleEntity.class);				
			List list = tx.list();
			Iterator etr = list.iterator();	
			HashMap empMap=null;
			while(etr.hasNext()){
				empMap = new HashMap<String, String>();
				AcqEmpRoleEntity txEntity = (AcqEmpRoleEntity)etr.next();
				empMap.put("executiveEmail",""+txEntity.getEmailId()); 
				empMap.put("executiveName",""+txEntity.getName()); 
				empMap.put("executiveId",""+txEntity.getId()); 
				globalList.add(empMap);  
			}
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			return global;
	}catch(Exception e){
		global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		global.setMessage(AcqStatusDefination.RollBackError.getDetails());
		logger.error("error"+e);
		return null;
	}
}
	
	@Override
	 public DbDto<String> deleteEmployee(String empId) {
		DbDto<String> response = new DbDto<String>();
		Session session = AcqMerchantDaoImpl.getSession();
		Transaction tx = null;
		try {
			if (empId != null && empId != "") {
				AcqEmpRoleEntity AcqEmp = (AcqEmpRoleEntity) session.get(AcqEmpRoleEntity.class,Long.valueOf(empId));
				if (AcqEmp != null && AcqEmp + "" != ""){
					if(AcqEmp.getName().equals("admin")){
						logger.info("Admin Cannot be deleted");
						response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
						response.setMessage("Admin Cannot Be Deleted");
					}else{
					tx = session.beginTransaction();
					session.delete(AcqEmp);
					AcqEmpPasswordEntity emp = (AcqEmpPasswordEntity) session.createCriteria(AcqEmpPasswordEntity.class).add(Restrictions.eq("empId", Long.valueOf(empId))).uniqueResult();
					if(emp !=null&& emp+""!=""){
					tx = session.beginTransaction();
					session.delete(emp);
					}else{
						logger.info("Password Not Found For Delete");
					}
					tx.commit();
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("Employee is successfully deleted");
				}
				}else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("Employee not found");
				}
			} else {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Employee is not available");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete Employee :" + e);
		}
		return response;
	 }
	
	@Override
	public DbDto<HashMap<String, String>> empChangePassword(String empEmailId) {
		DbDto<HashMap<String,String>> globleMap = new DbDto<HashMap<String,String>>();
		HashMap<String,String> empDetails = new HashMap<String,String>();
		try{
		
			Session session = AcqMerchantDaoImpl.getSession();
		AcqEmpRoleEntity emp = (AcqEmpRoleEntity) session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId", empEmailId)).uniqueResult();
		if(emp==null||emp+""==""){
			logger.warn("No records fetch");
			return null;
		}else{		
			logger.info("employee details is fetched");
			empDetails.put("empId", ""+emp.getId());
			empDetails.put("empName", emp.getName());
			empDetails.put("empEmailId", emp.getEmailId());
			empDetails.put("empPhone", emp.getPhone());
			empDetails.put("empEnabled", emp.getEnabled());
			empDetails.put("reportManager", emp.getReportManager());
			DateFormat smdf = new SimpleDateFormat("dd-MM-yyyy");
			empDetails.put("empCreatedOn", ""+smdf.format(emp.getCreatedOn()));
			if(emp.getEmpRole().equals("2")){
				empDetails.put("empRole", "Boarding");
			}else if(emp.getEmpRole().equals("3")){
				empDetails.put("empRole", "Billing");
			}else if(emp.getEmpRole().equals("4")){
				empDetails.put("empRole", "Support");
			}else if(emp.getEmpRole().equals("1")){
				empDetails.put("empRole", "Admin");
			}			
		}
		logger.info("emp Detail successfully selected");
		globleMap.setResult(empDetails);
		globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
		globleMap.setMessage(AcqStatusDefination.OK.getDetails());
		return globleMap;
		}catch(Exception e){
			logger.error("Error in Emp Profile Dao"+e);
			return globleMap;
		}
	}




	@Override
	public DbDto<AcqEmpDetailsModel> empChangePassword(AcqEmpDetailsModel modell) {
			logger.info("request landing in emp change password dao");
			DbDto<AcqEmpDetailsModel> response = new DbDto<AcqEmpDetailsModel>();
			Session session = AcqMerchantDaoImpl.getSession();
				logger.info("session object is created");
				Transaction tx=null;
			try{
				logger.info("sesion opened in update Employee");
				AcqEmpRoleEntity empEnt = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("id",Long.valueOf(modell.getEmpid()))).uniqueResult();
				if(empEnt==null||empEnt+""==""){
					logger.warn("not found");
					}else{
					empEnt.setPhone(modell.getPhone());
					DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");		
					empEnt.setCreatedOn(smdf.parse(smdf.format(new Date())));	
					empEnt.setReportManager(modell.getReportManager());
					empEnt.setPhone(modell.getPhone());
	if(modell.getPassword()!=null&&modell.getPassword()!=""&&modell.getPassword().length()>7&&modell.getPassword().length()<21){	
		try{
				String newpassword = AcqBase.generateSHA(modell.getPassword());
				try{
				if(empEnt.getPassword().equals(newpassword)){							
						response.setMessage("Current Password And New Password Is Same");
						logger.info("current password is same");
						return response;
						}else{
							System.out.println("current password is not same");
							AcqEmpPasswordEntity passwordEnt = (AcqEmpPasswordEntity) session.createCriteria(AcqEmpPasswordEntity.class).add(Restrictions.eq("empId",Long.valueOf(modell.getEmpid()))).uniqueResult();
							logger.info(" Password succesfully selected");
							SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							if (passwordEnt == null || passwordEnt + "" == "") {
								System.out.println("password is empty");
								AcqEmpPasswordEntity passwrd = new AcqEmpPasswordEntity();
								passwrd.setEmpId(empEnt.getId());
								passwrd.setPasswd1(empEnt.getPassword());
								passwrd.setPasswd2("NA");
								passwrd.setPasswd3("NA");
								empEnt.setPassword(newpassword);
								passwrd.setLastUpdatedOn(format.format(new Date()));
								tx = session.beginTransaction();
								logger.info("Password save succesfully");
								session.save(passwrd);
								tx.commit();
								response.setStatus(AcqStatusDefination.OK.getIdentifier());
								response.setMessage(AcqStatusDefination.OK.getDetails());
								return response;
							} else {
								logger.info("Verifing last password same or not");
								if (passwordEnt.getPasswd1().equals(newpassword)){
									logger.info(" Last 4 password can't be same");
									response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
									response.setMessage("Last 4 Password Can't Be Same");
									return response;
								} else if(passwordEnt.getPasswd2().equals(newpassword)){
									logger.info(" Last 4 password can't be same");
									response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
									response.setMessage("Last 4 Password Can't Be Same");
									return response;
								} else if(passwordEnt.getPasswd3().equals(newpassword)){
									logger.info(" Last 4 password can't be same");
									response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
									response.setMessage("Last 4 Password Can't Be Same");
									return response;
								}else {
										passwordEnt.setPasswd3(passwordEnt.getPasswd2());
										passwordEnt.setPasswd2(passwordEnt.getPasswd1());
										passwordEnt.setPasswd1(empEnt.getPassword());
										passwordEnt.setLastUpdatedOn(format.format(new Date()));
										empEnt.setPassword(newpassword);
										session.update(passwordEnt);
										response.setStatus(AcqStatusDefination.OK.getIdentifier());
										response.setMessage(AcqStatusDefination.OK.getDetails());
										logger.info("Password successfully updated");
									
									logger.info("Putting new password in entity");
									
								}
							}		
						}
					modell.setName(empEnt.getName());
					modell.setEmail(empEnt.getEmailId());
					modell.setPhone(empEnt.getPhone());
					tx = session.beginTransaction();
					session.saveOrUpdate(empEnt);
					tx.commit();
					logger.info("password successfully updated.");
					return response;
				}catch (Exception e) {
					logger.error("Error: rror to fetch password " + e);
				}
					}					
				catch(Exception e){
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError.getDetails());
					logger.error("error to change password in emp change password "+e);
				}		
	}
				    tx=session.beginTransaction();
					session.saveOrUpdate(empEnt);	
					session.flush();
					tx.commit();
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("Employee change password successfully updated");
					}
			}catch(NumberFormatException e){		
				logger.error("Error in update Emp Dao "+e);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			return response;
		}

	
	
	@Override
	public DbDto<Object> addEmployee(AcqCreateEmployeeModel model) {
		logger.info("request landing in add employee dao");
		DbDto<Object> response = new DbDto<Object>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			logger.info("session object is created");
			if(model.getEmpEmailId()!=null){
				AcqEmpRoleEntity entity = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",model.getEmpEmailId())).uniqueResult();
				if(entity==null||entity+""==""){
					logger.info("email not found");
				}else{
					response.setStatus(AcqStatusDefination.InvalidCrediential.getIdentifier());
					response.setMessage("EmailId already in use");
					logger.warn("Email already in use");
					return response;
				}
			}
			AcqEmpRoleEntity emp = new AcqEmpRoleEntity();	   
			emp.setName(model.getEmployeeName());
			emp.setEmailId(model.getEmpEmailId());
			emp.setEnabled("1");
			String password = AcqBase.generateSHA(model.getEmpPassword());
			emp.setPassword(password);
			DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");		
			emp.setCreatedOn(smdf.parse(smdf.format(new Date())));	
			emp.setPhone(model.getEmpPhone());
			emp.setEmpRole(model.getEmpRole());
			emp.setReportManager(model.getReportManager());
		    session.save(emp);
		    response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(emp.getId());
			
			logger.info("employee added successfully");    
	    }catch(NumberFormatException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem in add employee dao "+e);
		}catch(NullPointerException e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in add employee dao "+e);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to create hibernate session in add employee dao "+e);
		}
		return response;
	}
	
	@Override
	public DbDto<AcqEmpDetailsModel> empChangeProfile(AcqEmpDetailsModel modell) {
		logger.info("request landing in change emp profile dao");
		DbDto<AcqEmpDetailsModel> response = new DbDto<AcqEmpDetailsModel>();
			Session session = AcqMerchantDaoImpl.getSession();
			logger.info("session object is created");
			Transaction tx=null;
		try{
			logger.info("sesion opened in update Employee");
			AcqEmpRoleEntity empEnt = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("id",Long.valueOf(modell.getEmpid()))).uniqueResult();
			if(empEnt==null||empEnt+""==""){
				logger.warn("not found");
				}else{		
				empEnt.setEnabled(modell.getEnabled());
				empEnt.setPhone(modell.getPhone());
				empEnt.setName(modell.getName());
				empEnt.setReportManager(modell.getReportManager());
				DateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");		
				empEnt.setCreatedOn(smdf.parse(smdf.format(new Date())));	
if(modell.getPassword()!=null&&modell.getPassword()!=""&&modell.getPassword().length()>7&&modell.getPassword().length()<21){	
	try{
			String newpassword = AcqBase.generateSHA(modell.getPassword());
			System.out.println("new password is: "+newpassword);
			try{
			if(empEnt.getPassword().equals(newpassword)){							
					response.setMessage("Current Password And New Password Is Same");
					logger.info("current password is same");
					return response;
					}else{
						System.out.println("current password is not same");
						AcqEmpPasswordEntity passwordEnt = (AcqEmpPasswordEntity) session.createCriteria(AcqEmpPasswordEntity.class).add(Restrictions.eq("empId",Long.valueOf(modell.getEmpid()))).uniqueResult();
						logger.info(" Password succesfully selected");
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						if (passwordEnt == null || passwordEnt + "" == "") {
							System.out.println("password is empty");
							AcqEmpPasswordEntity passwrd = new AcqEmpPasswordEntity();
							passwrd.setEmpId(empEnt.getId());
							passwrd.setPasswd1(empEnt.getPassword());
							passwrd.setPasswd2("NA");
							passwrd.setPasswd3("NA");
							empEnt.setPassword(newpassword);
							passwrd.setLastUpdatedOn(format.format(new Date()));
							tx = session.beginTransaction();
							logger.info("Password save succesfully");
							session.save(passwrd);
							tx.commit();
							response.setStatus(AcqStatusDefination.OK.getIdentifier());
							response.setMessage(AcqStatusDefination.OK.getDetails());
							return response;
						} else {
							logger.info("Verifing last password same or not");
							if (passwordEnt.getPasswd1().equals(newpassword)){
								logger.info(" Last 4 password can't be same");
								response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
								response.setMessage("Last 4 Password Can't Be Same");
								return response;
							} else if(passwordEnt.getPasswd2().equals(newpassword)){
								logger.info(" Last 4 password can't be same");
								response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
								response.setMessage("Last 4 Password Can't Be Same");
								return response;
							} else if(passwordEnt.getPasswd3().equals(newpassword)){
								logger.info(" Last 4 password can't be same");
								response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
								response.setMessage("Last 4 Password Can't Be Same");
								return response;
							}else {
									passwordEnt.setPasswd3(passwordEnt.getPasswd2());
									passwordEnt.setPasswd2(passwordEnt.getPasswd1());
									passwordEnt.setPasswd1(empEnt.getPassword());
									passwordEnt.setLastUpdatedOn(format.format(new Date()));
									empEnt.setPassword(newpassword);
									session.update(passwordEnt);
									response.setStatus(AcqStatusDefination.OK.getIdentifier());
									response.setMessage(AcqStatusDefination.OK.getDetails());
									logger.info("Password successfully updated");								
								logger.info("Putting new password in entity");								
							}
						}						
					}
				tx = session.beginTransaction();
				session.saveOrUpdate(empEnt);
				tx.commit();
				logger.info("password successfully updated.");
				return response;
			}catch (Exception e) {
				logger.error("Error: rror to fetch password " + e);
			}
				}					
			catch(Exception e){
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
				logger.error("error to change password in emp change profile dao "+e);
			}		
}
			    tx=session.beginTransaction();
				session.saveOrUpdate(empEnt);	
				session.flush();
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Employee profile successfully updated");
				}
		}catch(NumberFormatException e){		
			logger.error("Error in update Emp Dao "+e);
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		return response;
	}

	@SuppressWarnings("unused")
	@Override
	public DbDto<List<HashMap<String, String>>> emplockunlock() {
		DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
		try{
			logger.info("request landing for emp management");
				
			Session s = AcqMerchantDaoImpl.getSession();
				logger.info("session is open for emp management");
				List<HashMap<String,String>> global = new ArrayList<HashMap<String,String>>();
				ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("id"));
			     proList.add(Projections.property("name"));
			     proList.add(Projections.property("emailId"));
			     proList.add(Projections.property("phone"));
			     proList.add(Projections.property("enabled"));
			     proList.add(Projections.property("createdOn"));
			     proList.add(Projections.property("empRole"));
			     proList.add(Projections.property("reportManager"));
			     Criteria tx= s.createCriteria(AcqEmpRoleEntity.class).setProjection(proList);		
			    System.out.println("tx"+tx);
				List<AcqEmpRoleEntity> list =(List<AcqEmpRoleEntity> ) tx.list();
				HashMap<String, String> empMap=null;
				for(Object obj:list){
					empMap = new HashMap<String, String>();
				        Object[] ob=(Object[])obj;
				        empMap.put("id",""+ob[0]);
				        empMap.put("name",""+ob[1]); 
				        empMap.put("emailId",""+ob[2]); 
				        empMap.put("phone",""+ob[3]); 
				        empMap.put("reportManager", ""+ob[7]);
					       
				        if(""+ob[4].equals("1") != null){
				        	 empMap.put("enabled","Active"); 
				        }else{
				        	 empMap.put("enabled","DeActive"); 
				        }
				        if(ob[6].toString().equals("1")){
				        	empMap.put("empRole", "Admin");
				        }else if(ob[6].toString().equals("2")){
				        	empMap.put("empRole", "Boarding");
				        }else if(ob[6].toString().equals("3")){
				        	empMap.put("empRole", "Billing");
				        }else if(ob[6].toString().equals("4")){
				        	empMap.put("empRole", "Support");
				        }else if(ob[6].toString().equals("5")){
				        	empMap.put("empRole", "Sales");
				        }else if(ob[6].toString().equals("6")){
				        	empMap.put("empRole", "PreBoarding");
				        }else if(ob[6].toString().equals("7")){
				        	empMap.put("empRole", "SeniorSupport");
				        }else if(ob[6].toString().equals("8")){
				        	empMap.put("empRole", "HR");
				        }else if(ob[6].toString().equals("9")){
				        	empMap.put("empRole", "Sales Coordinator");
				        }
				       
				        DateFormat smdf = new SimpleDateFormat("dd-MM-yyyy");
				        DateFormat smd = new SimpleDateFormat("yyyy-MM-dd");
						empMap.put("dateTime",""+smdf.format(smd.parse(""+ob[5]))); 
				        global.add(empMap); 				        
				}	
		logger.info("Employee name successfully selected");
		globleMap.setResult(global);
		globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
		globleMap.setMessage(AcqStatusDefination.OK.getDetails());
		return globleMap;
		}catch(Exception e){
			logger.error("Error in lock/unlock employee in Dao"+e);
			return null;
		}
	}

	@Override
	public DbDto<HashMap<String, String>> empProfile(String empId) {
		DbDto<HashMap<String,String>> globleMap = new DbDto<HashMap<String,String>>();
		HashMap<String,String> empDetails = new HashMap<String,String>();
		Session session = AcqMerchantDaoImpl.getSession();
		try{
			AcqEmpRoleEntity emp = null;
			if(AcqNumberValidator.checkId(empId)!=true){
				emp = (AcqEmpRoleEntity) session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId", empId)).uniqueResult();
			}else{
				emp = (AcqEmpRoleEntity) session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("id", Long.valueOf(empId))).uniqueResult();
			}
			if(emp==null||emp+""==""){
				logger.warn("No records fetch");
				return null;
			}else{		
				logger.info("employee details is fetched");
				empDetails.put("empId", ""+emp.getId());
				empDetails.put("empName", emp.getName());
				empDetails.put("empEmailId", emp.getEmailId());
				empDetails.put("empPhone", emp.getPhone());
				empDetails.put("empEnabled", emp.getEnabled());
				DateFormat smdf = new SimpleDateFormat("dd-MM-yyyy");
				empDetails.put("empCreatedOn", ""+smdf.format(emp.getCreatedOn()));
				if(emp.getEmpRole().equals("2")){
					empDetails.put("empRole", "Boarding");
				}else if(emp.getEmpRole().equals("6")){
					empDetails.put("empRole", "PreBoarding");
				}else if(emp.getEmpRole().equals("5")){
					empDetails.put("empRole", "Sales");
				}else if(emp.getEmpRole().equals("3")){
					empDetails.put("empRole", "Billing");
				}else if(emp.getEmpRole().equals("4")){
					empDetails.put("empRole", "Support");
				}else if(emp.getEmpRole().equals("1")){
					empDetails.put("empRole", "Admin");
				}else if(emp.getEmpRole().equals("7")){
					empDetails.put("empRole", "SeniorSupport");
				}else if(emp.getEmpRole().equals("8")){
					empDetails.put("empRole", "HR");
				}else if(emp.getEmpRole().equals("9")){
					empDetails.put("empRole", "Sales Coordinator ");
				}
				empDetails.put("reportManager", emp.getReportManager());				
			}
			logger.info("Emp detail successfully selected");
			globleMap.setResult(empDetails);
			globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
			globleMap.setMessage(AcqStatusDefination.OK.getDetails());
			return globleMap;
		}catch(Exception e){
			logger.error("Error in emp profile dao"+e);
			return globleMap;
		}
	}
	}

