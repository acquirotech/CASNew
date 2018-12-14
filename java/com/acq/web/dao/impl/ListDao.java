package com.acq.web.dao.impl;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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

import com.acq.AcqStatusDefination;
import com.acq.users.entity.AcqBankItTransactionEntity;
import com.acq.users.entity.AcqRechargeListEntity;
import com.acq.AcqStatusDefination;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.users.entity.AcqAddNewMerchantEntity;
import com.acq.users.entity.AcqCardDetails;
import com.acq.users.entity.AcqMobikwikEntity;
import com.acq.users.entity.AcqRiskManagement;
import com.acq.users.entity.AcqWalletListEntity;
import com.acq.users.entity.AcqWalletRiskManagement;
import com.acq.users.model.AcqAppUser;
import com.acq.users.model.AcqDevice;
import com.acq.users.model.AcqDeviceMapUser;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization;
import com.acq.users.model.AcqOrganization1;
import com.acq.users.model.AcqUser;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dao.ListDaoInf;
import com.acq.web.dto.impl.DbDto;
import com.itextpdf.text.log.SysoLogger;

@Repository
public class ListDao implements ListDaoInf {
	
	final static Logger logger = Logger.getLogger(AcqMerchantDaoImpl.class);	
	
	@Autowired
	AcqMerchantDaoImpl AcqMerchantDaoImpl;
	
	
	@Override
	public DbDto<List<HashMap<String, String>>> rechargeList(AcqSearchModel modell) {
		logger.info("request is landing in dao for recharge List");
		try{
			Map<String,String> circleMap = new HashMap<String,String>();
			circleMap.put("1","Andhra Pradesh");
			circleMap.put("2","Chennai" );
			circleMap.put("3"," Delhi" );
			circleMap.put("4","Gujarat" );
			circleMap.put("5","Haryana" );
			circleMap.put("6"," Karnataka" );
			circleMap.put("7","Kerla" );
			circleMap.put("8","Kolkata");
			circleMap.put("9","Maharashtra Goa");
			circleMap.put("10","Mumbai");
			circleMap.put("11"," Punjab" );
			circleMap.put("12","Rajasthan");
			circleMap.put("13"," West Bengal" );
			circleMap.put("14","Tamil Nadu" );
			circleMap.put("15","UP East");
			circleMap.put("16","UP West");
			circleMap.put("17","Himachal Pradesh" );
			circleMap.put("18","Madhya Pradesh");
			circleMap.put("19","Assam");
			circleMap.put("20","Bihar" );
			circleMap.put("21","Jammu Kashmir" );
			circleMap.put("22","North East" );
			circleMap.put("23","Orissa" );
			circleMap.put("51","Unknown");
			Map<String,String> operatorMap = new HashMap<String,String>();
			operatorMap.put("1", " VODAFONE");
			operatorMap.put("2", " AIRTEL");
			operatorMap.put("3", " IDEA");
			operatorMap.put("4", " AIRCEL");
			operatorMap.put("5", " BSNL");
			operatorMap.put("6", " DOCOMO");
			operatorMap.put("7", " MTS");
			operatorMap.put("8", " RELIANCE");
			operatorMap.put("9", " RELIANCECDMA");
			operatorMap.put("10", " JIO");
			operatorMap.put("11", " TATACDMA");
			operatorMap.put("12", " TELENOR");
			operatorMap.put("13", " MTNL");
			operatorMap.put("20", " DOCOMO SPECIAL");
			operatorMap.put("21", " TELENOR SPECIAL");
			operatorMap.put("25", " BSNL STV");
			operatorMap.put("14", "Airtel DTH"); 
			operatorMap.put("15" ,"BigTV"); 
			operatorMap.put("16", "DishTV"); 
			operatorMap.put("17", "SunTV"); 
			operatorMap.put("18", "VideoconDTH"); 
			operatorMap.put("19", "TataSky");
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
				Session session = AcqMerchantDaoImpl.getSession();
				Criteria tx = session.createCriteria(AcqRechargeListEntity.class);
				Criteria tot = session.createCriteria(AcqRechargeListEntity.class);
				tot.setProjection(Projections.rowCount());				
				tx.addOrder(Order.desc("id"));
				tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
				tx.setMaxResults(20);
				List criteriaList = tx.list();
				Iterator etr1 = criteriaList.iterator();	
				Iterator etr = criteriaList.iterator();	
				Iterator<AcqRechargeListEntity> itr2 = criteriaList.iterator();
				List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
				HashMap<String,String> singleMap=null;				
				Set<Long> orgset = new HashSet<Long>();
				Set<Long> userset = new HashSet<Long>();
				Set<Integer> merchantSet = new HashSet<Integer>();
				HashMap<String,String> orgmap = null;
				HashMap<String,String> usermap = null;
				HashMap<String,String> merchantMap = null;
				System.out.println("criteriaList::"+criteriaList);
			
					while(itr2.hasNext()){
						AcqRechargeListEntity txEntity = (AcqRechargeListEntity)itr2.next();
					//	orgset.add(txEntity.getOrgId());
						userset.add(Long.valueOf(txEntity.getSessionId()));
					//	merchantSet.add(Integer.parseInt(txEntity.getMerchantId().toString()));
					}
				
				if(userset.isEmpty()){
				     logger.info("Org Name Users Name And Merchant Name Not Found");
				}else{
					/*try{
						Criteria org =session.createCriteria(AcqOrganization1.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("orgId"));
					     proList.add(Projections.property("name"));
					     org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
					    List list1 = org.list();
					    orgmap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        orgmap.put("orgName"+ob[0],""+ob[1]);					      
					    }
					}catch(Exception e){
						logger.error("error to select organization "+e);
					}*/try{
						Criteria user =session.createCriteria(AcqUser.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("userId"));
					     proList.add(Projections.property("loginId"));
					     user.setProjection(proList);
					     user.add((Restrictions.in("userId", userset)));
					    List list1 = user.list();
					    usermap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        usermap.put("loginId"+ob[0],""+ob[1]); 
					    }
					}catch(Exception e){
						logger.error("error in select user in wallet report "+e);
					}/*try{
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
					}*/
				}
				
				logger.info("card details selected");
				while(etr.hasNext()){
					AcqRechargeListEntity entit = (AcqRechargeListEntity)etr.next();
					AcqUser user = (AcqUser) session.createCriteria(AcqUser.class).add(Restrictions.eq("userId", Long.valueOf(entit.getSessionId()))).uniqueResult();
					singleMap = new HashMap<String,String>();
					singleMap = new HashMap<String,String>();
				    singleMap.put("id",""+entit.getId());
					singleMap.put("amount",""+entit.getAmount());
					singleMap.put("serviceType",""+entit.getServiceType());
					singleMap.put("operator",operatorMap.get(entit.getOperator()));
					SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				    singleMap.put("dateTime",""+sdfDestination.format(sdfSource.parse(entit.getDateTime())));
				    singleMap.put("circle",circleMap.get(entit.getCircle()));
				    singleMap.put("userName", ""+user.getLoginId());
				    singleMap.put("rechargeType", entit.getRechargeType());
				    singleMap.put("status", entit.getStatus());
				    singleMap.put("message", entit.getMessage());	
				    singleMap.put("subscriberId", entit.getSubscriberId());	
				    globalList.add(singleMap);				    
				    System.out.println("singleMap:: "+singleMap);
				   
				}
				    
				logger.info("records are putted in map");
				Long rows = (Long) tot.uniqueResult();
				Long totalRows= rows/20;
				Long modlus = rows%20;
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
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("wallet list selected successfully");
				return globleMap;	
				
			}catch(Exception e){
				logger.info("error to select wallet list"+e);
				return null;
			}
		
		}
		
	
	@Override
	public DbDto<List<HashMap<String, String>>> transactionList(AcqSearchModel modell) {
		logger.info("request is landing in dao for dmt transaction List");
		try{
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
				Session session = AcqMerchantDaoImpl.getSession();
				Criteria tx = session.createCriteria(AcqBankItTransactionEntity.class);
				Criteria tot = session.createCriteria(AcqBankItTransactionEntity.class);
				List<Long> merchantIds = new ArrayList<Long>();
				List<AcqMerchant> merchantList = null;
				if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&modell.getMerchantName()!="%41"){
					merchantList = (List<AcqMerchant>)session.createCriteria(AcqMerchant.class).setProjection(Projections.property("merchantId")).add(Restrictions.like("merchantName", modell.getMerchantName()+"%")).list();
					Iterator itr = merchantList.iterator();
					logger.info("merchant fetched successfully");
					while(itr.hasNext()){
						merchantIds.add(Long.parseLong(""+itr.next()));					
					}
				}
				long txn=0l;
				if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&modell.getUserPhone().length()==10&&!modell.getUserPhone().equals("%41")){		
					try{
						txn=(Long) session.createCriteria(AcqAppUser.class).add(Restrictions.eq("loginId", Long.valueOf(modell.getUserPhone()))).setProjection(Projections.property("userId")).uniqueResult();
					}catch(NullPointerException npe){
						txn=0;
					}catch(Exception e){
						System.out.println("error to select login id "+e);
					}
				}if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&!modell.getUserPhone().equals("%41")){
					tx.add(Restrictions.eq("sessionId", txn));
					tot.add(Restrictions.eq("sessionId", txn));
				}
				if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
					if(merchantIds.isEmpty()){
					     logger.info("merchantIds Not found");
					     tx.add(Restrictions.eq("merchantId", 0l));
					     tot.add(Restrictions.eq("merchantId", 0l));
					 }else{
					     tx.add(Restrictions.in("merchantId",merchantIds));
						 tot.add(Restrictions.in("merchantId",merchantIds));
					 }					
				}
				
				if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""&&!modell.getCustPhone().equals("%41")){
					tx.add(Restrictions.eq("mobileNo",modell.getCustPhone()));
					tot.add(Restrictions.eq("mobileNo",modell.getCustPhone()));
				}
				
				if(modell.getWalletStatus()!=null&&modell.getWalletStatus()!=""&&!modell.getWalletStatus().equals("%41")){
					if(modell.getWalletStatus().equalsIgnoreCase("success")){
						tx.add(Restrictions.eq("status", "00"));
						tot.add(Restrictions.eq("status", "00"));
					}else if(modell.getWalletStatus().equalsIgnoreCase("failed")){
						Set<String> list = new HashSet<String>();
						list.add("02");
						tx.add(Restrictions.in("status", list));
						tot.add(Restrictions.in("status", list));
					}else if(modell.getWalletStatus().equalsIgnoreCase("pending")){
					     tx.add(Restrictions.eq("status", "01"));
					      tot.add(Restrictions.eq("status", "01"));
					}else{
					     tx.add(Restrictions.eq("status", modell.getWalletStatus()));
					     tot.add(Restrictions.eq("status", modell.getWalletStatus()));
				    }
				}
				SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				
				if(modell.getFromDateTime()!=null&&modell.getFromDateTime()!=""&&!modell.getFromDateTime().equals("%41")){
					if(modell.getToDateTime()!=null&&modell.getToDateTime()!=""&&modell.getToDateTime().length()==10&&!modell.getToDateTime().equals("%41")){	
						tx.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
						tot.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
					}else{
						tx.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
						tot.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
					}
				}
				// filter for transaction type		
				if(modell.getTxnType()!=null&&modell.getTxnType()!=""&&!modell.getTxnType().equals("%41")){
						tx.add(Restrictions.eq("transactionType", modell.getTxnType()));
						tot.add(Restrictions.eq("transactionType", modell.getTxnType()));
					
				}if(modell.getAccount()!=null&&modell.getAccount()!=""&&!modell.getAccount().equals("%41")){
					
				    	tx.add(Restrictions.eq("accountNo",modell.getAccount()));
				    	tot.add(Restrictions.eq("accountNo",modell.getAccount()));
				    }
				
				
				if(modell.getAmount()!=null&&modell.getAmount()!=""&&!modell.getAmount().equals("%41")){
					tx.add(Restrictions.eq("amount",modell.getAmount()));
					tot.add(Restrictions.eq("amount",modell.getAmount()));
				}
				tot.setProjection(Projections.rowCount());				
				tx.addOrder(Order.desc("id"));
				tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
				tx.setMaxResults(20);
				List criteriaList = tx.list();
				Iterator etr1 = criteriaList.iterator();	
				Iterator etr = criteriaList.iterator();	
				Iterator<AcqBankItTransactionEntity> itr2 = criteriaList.iterator();
				List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
				HashMap<String,String> singleMap=null;				
				Set<Long> orgset = new HashSet<Long>();
				Set<Long> userset = new HashSet<Long>();
				Set<Long> merchantSet = new HashSet<Long>();
				HashMap<String,String> orgmap = null;
				HashMap<String,String> usermap = null;
				HashMap<String,String> merchantMap = null;
				
					while(itr2.hasNext()){
						AcqBankItTransactionEntity txEntity = (AcqBankItTransactionEntity)itr2.next();
					//	orgset.add(txEntity.getOrgId());
						userset.add(Long.valueOf(txEntity.getSessionId()));
						merchantSet.add(Long.valueOf(txEntity.getMerchantId().toString()));
					}
				
				if(userset.isEmpty()){
				     logger.info("Org Name Users Name And Merchant Name Not Found");
				}else{
					/*try{
						Criteria org =session.createCriteria(AcqOrganization1.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("orgId"));
					     proList.add(Projections.property("name"));
					     org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
					    List list1 = org.list();
					    orgmap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        orgmap.put("orgName"+ob[0],""+ob[1]);					      
					    }
					}catch(Exception e){
						logger.error("error to select organization "+e);
					}*/try{
						Criteria user =session.createCriteria(AcqUser.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("userId"));
					     proList.add(Projections.property("loginId"));
					     user.setProjection(proList);
					     user.add((Restrictions.in("userId", userset)));
					    List list1 = user.list();
					    usermap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        usermap.put("loginId"+ob[0],""+ob[1]); 
					    }
					}catch(Exception e){
						logger.error("error in select user in wallet report "+e);
					}try{
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
				}
				while(etr.hasNext()){
					AcqBankItTransactionEntity sngleTxn = (AcqBankItTransactionEntity)etr.next();
					AcqUser user = (AcqUser) session.createCriteria(AcqUser.class).add(Restrictions.eq("userId", Long.valueOf(sngleTxn.getSessionId()))).uniqueResult();
					singleMap = new HashMap<String,String>();
					singleMap.put("id", sngleTxn.getId());
					singleMap.put("txnType", sngleTxn.getTransactionType());
					singleMap.put("customerId", sngleTxn.getCustomerId());
					singleMap.put("clientRefId", sngleTxn.getClientRefId());
					singleMap.put("ifsc", sngleTxn.getIfsc());
					singleMap.put("recepientName", sngleTxn.getRecipientName());
					if(sngleTxn.getStatus().equals("00")){
						singleMap.put("status", "Success");
							
					}else if(sngleTxn.getStatus().equals("01")){
						singleMap.put("status", "Pending");
						
					}else if(sngleTxn.getStatus().equals("02")){
						singleMap.put("status", "Failed");
						
					}else{
						singleMap.put("status", sngleTxn.getStatus());
						
					}
					singleMap.put("accountNo", sngleTxn.getAccountNo());
					singleMap.put("amount", sngleTxn.getAmount());
					singleMap.put("dateTime", sngleTxn.getDateTime());
					singleMap.put("bankName", sngleTxn.getBankName());
					singleMap.put("mobileNo", sngleTxn.getMobileNo());
					if(merchantMap.get("merchantName"+sngleTxn.getMerchantId())==null||merchantMap.get("merchantName"+sngleTxn.getMerchantId())==""){
				    	  singleMap.put("merchantName", "Unknown");
				    	  singleMap.put("mid","0");
				      }else{
				    	  singleMap.put("mid",""+sngleTxn.getMerchantId());
				    	  singleMap.put("merchantName", ""+merchantMap.get("merchantName"+sngleTxn.getMerchantId()));
				      }
				      if(usermap.get("loginId"+sngleTxn.getSessionId())==null||usermap.get("loginId"+sngleTxn.getSessionId())==""){
				       singleMap.put("userName", "Unknown");
				      }else{
				       singleMap.put("userName", ""+usermap.get("loginId"+sngleTxn.getSessionId()));
				      } 
				    globalList.add(singleMap);				    
				  
				}
				logger.info("records are putted in map");
				Long rows = (Long) tot.uniqueResult();
				Long totalRows= rows/20;
				Long modlus = rows%20;
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
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("dmt transaction list selected successfully");
				return globleMap;	
				
			}catch(Exception e){
				logger.info("error to select dmt transaction list"+e);
				return null;
			}
		
		}
	
	
	
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> downloadRiskDetails(String fromDate,String toDate) {
		logger.info("request in download Bill Details");
		DbDto<List<HashMap<String,String>>> response = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String, String>> globalMap= new ArrayList<HashMap<String, String>>();
		try{	
			Session session = AcqMerchantDaoImpl.getSession();
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
			
		   Criteria criteria = session.createCriteria(AcqRiskManagement.class).add(Restrictions.eq("status", "1"));
		   if(fromDate!=null&&fromDate!=""&&!fromDate.equals("/")){
				if(toDate!=null&&toDate!=""&&toDate.length()==10){	
					criteria.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00",sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59"));
				}else{
					criteria.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00",sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59"));
				}
			}
		    logger.info("date criteria puttd");
			List txList = criteria.list();
			if(txList.isEmpty()){
				response.setResult(globalMap);
				response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("there is no Risk Details ");
			}else{
				logger.info("Risk Details entity selected");
				Iterator<AcqRiskManagement> itr1 = txList.iterator();
				Iterator<AcqRiskManagement> itr2 = txList.iterator();
				HashMap<String,String> responseMap = null;
				try	{
					Set<Long> orgset = new HashSet<Long>();
					Set<Long> merchantSet = new HashSet<Long>();
					Set<Long> txnIdSet = new HashSet<Long>();
					HashMap<String,String> orgmap = null;
					HashMap<String,String> merchantMap = null;
					HashMap<String,String> orgmap1 = null;
					HashMap<String,String> merchantMap1 = null;
					HashMap<String,String> orgmap2 = null;
					HashMap<String,String> merchantMap2 = null;
					try{
						while(itr2.hasNext()){
							AcqRiskManagement txEntity = (AcqRiskManagement)itr2.next();
							txnIdSet.add(Long.valueOf(""+txEntity.getTxnId()));
						}
					}catch(Exception e){
						logger.error("error iterate txn entity or add/org id in set", e);
					}try{
						Criteria org1 =session.createCriteria(AcqWalletListEntity.class).add((Restrictions.in("walletId", txnIdSet)));
					    List txnList = org1.list();
					    Iterator<AcqWalletListEntity> itr3 = txnList.iterator();
					    orgmap1 = new HashMap<String,String>();
					    merchantMap1 = new HashMap<String,String>();
					    orgmap2 = new HashMap<String,String>();
					    merchantMap2 = new HashMap<String,String>();
					    while(itr3.hasNext()){
					    AcqWalletListEntity txEntity = (AcqWalletListEntity)itr3.next();
					    merchantSet.add(Long.valueOf(""+txEntity.getMerchantId()));
					    orgset.add(Long.valueOf(""+txEntity.getOrgId()));					   
					    orgmap1.put("orgId"+txEntity.getOrgId(),""+txEntity.getWalletId());	
					    merchantMap1.put("merchantId"+txEntity.getMerchantId(),""+txEntity.getWalletId());	
					    orgmap2.put("orgId1"+txEntity.getWalletId(),""+txEntity.getOrgId());	
					    merchantMap2.put("merchantId1"+txEntity.getMerchantId(),""+txEntity.getWalletId());	
					    }				
					}catch(Exception e){
						logger.error("error to select txn ids "+e);
					}
					
					try{
						Criteria org =session.createCriteria(AcqOrganization1.class);
					    ProjectionList proList = Projections.projectionList();
					    proList.add(Projections.property("orgId"));
					    proList.add(Projections.property("name"));
					    org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
					    List list1 = org.list();
					    orgmap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        orgmap.put("orgName"+ob[0],""+ob[1]);					      
					    }
					}catch(Exception e){
						logger.error("error to select organization "+e);
					}
					try{
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
					while(itr1.hasNext()){
						responseMap = new HashMap<String,String>();
						AcqRiskManagement txEntity = (AcqRiskManagement)itr1.next();
						 responseMap.put("id",""+txEntity.getId());
						 responseMap.put("txnId",""+txEntity.getTxnId());
						 responseMap.put("description",""+txEntity.getDescription());
						 responseMap.put("status","Hold");
						 SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						 SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
						 if(txEntity.getDateTime()==null||txEntity.getDateTime()==""){
							 responseMap.put("dateTime","NA");
						 }else{
							 responseMap.put("dateTime",""+sdfDestinationDb.format(sdfSourceDb.parse(txEntity.getDateTime())));
						}	 System.out.println("sss:::::::0"+merchantMap.get("merchantName"+merchantMap1.get("merchantId"+merchantMap2.get("merchantId1"+txEntity.getTxnId()))));
					 globalMap.add(responseMap);
					}
					
					response.setResult(globalMap);
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("list are selected");
				}catch(Exception e){
					response.setResult(globalMap);
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError.getDetails());
					logger.error("error to download bill details report "+e);
				}
			}
		}catch (Exception e) {
			logger.error("error"+e);
			response.setResult(globalMap);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to download bill details report "+e);
		}
		return response;
	}


	
	
	@Override
	public DbDto<List<HashMap<String, String>>> wholeTxnList(
			AcqSearchModel modell) {
		logger.info("request is landing in dao for whole wallet list");
		try{
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
			Session session = AcqMerchantDaoImpl.getSession();
			List<Long> merchantIds = new ArrayList<Long>();
			List<AcqMerchant> merchantList = null;
			Criteria tot = session.createCriteria(AcqWalletListEntity.class);
			List<Long> orgIds = new ArrayList<Long>();
			List<AcqOrganization1> orgList = null;
			tot.setProjection(Projections.rowCount());				
			if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&modell.getMerchantName()!="%41"){
				merchantList = (List<AcqMerchant>)session.createCriteria(AcqMerchant.class).setProjection(Projections.property("merchantId")).add(Restrictions.like("merchantName", modell.getMerchantName()+"%")).list();
				Iterator itr = merchantList.iterator();
				logger.info("merchant fetched successfully");
				while(itr.hasNext()){
					merchantIds.add(Long.parseLong(""+itr.next()));					
				}
			}
			if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&modell.getOrgName()!="%41"){
				orgList = (List<AcqOrganization1>)session.createCriteria(AcqOrganization1.class).setProjection(Projections.property("orgId")).add(Restrictions.like("name", modell.getOrgName()+"%")).list();
				Iterator itr = orgList.iterator();
				logger.info("Organization fetched successfully");
				while(itr.hasNext()){
					orgIds.add(Long.parseLong(""+itr.next()));					
				}
			}
			Criteria tx=session.createCriteria(AcqWalletListEntity.class);				
			long txn=0l;
			if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&modell.getUserPhone().length()==10&&!modell.getUserPhone().equals("%41")){		
				try{
					txn=(Long) session.createCriteria(AcqAppUser.class).add(Restrictions.eq("loginId", Long.valueOf(modell.getUserPhone()))).setProjection(Projections.property("userId")).uniqueResult();
				}catch(NullPointerException npe){
					txn=0;
				}catch(Exception e){
					System.out.println("error to select login id "+e);
				}
			}if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&!modell.getUserPhone().equals("%41")){
				tx.add(Restrictions.eq("userId", txn));
				tot.add(Restrictions.eq("userId", txn));
			}
			if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
				if(merchantIds.isEmpty()){
				     logger.info("merchantIds Not found");
				     tx.add(Restrictions.eq("merchantId", 0l));
				     tot.add(Restrictions.eq("merchantId", 0l));
				 }else{
				     tx.add(Restrictions.in("merchantId",merchantIds));
					 tot.add(Restrictions.in("merchantId",merchantIds));
				 }					
			}
			if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&!modell.getOrgName().equals("%41")){
				if(orgIds.isEmpty()){
				    logger.info("OrgIds Not found");
				    tx.add(Restrictions.eq("orgId", 0l));
				    tot.add(Restrictions.eq("orgId", 0l));
				}else{
				    tx.add(Restrictions.in("orgId", orgIds));
				    tot.add(Restrictions.in("orgId", orgIds));
				}
			}			
			if(modell.getAccount()!=null&&modell.getAccount()!=""&&!modell.getAccount().equals("%41")){
				
			    	tx.add(Restrictions.eq("cardPanNo",modell.getAccount()));
			    	tot.add(Restrictions.eq("cardPanNo",modell.getAccount()));
			    
			}			
			if(modell.getAmount()!=null&&modell.getAmount()!=""&&!modell.getAmount().equals("%41")){
				tx.add(Restrictions.eq("walletAmount",modell.getAmount()));
				tot.add(Restrictions.eq("walletAmount",modell.getAmount()));
			}
			if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""&&!modell.getCustPhone().equals("%41")){
				tx.add(Restrictions.eq("walletMobileNo",modell.getCustPhone()));
				tot.add(Restrictions.eq("walletMobileNo",modell.getCustPhone()));
			}
			if(modell.getWalletTxnId()!=null&&modell.getWalletTxnId()!=""&&!modell.getWalletTxnId().equals("%41")){
				tx.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
				tot.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
			}
			if(modell.getWalletStatus()!=null&&modell.getWalletStatus()!=""&&!modell.getWalletStatus().equals("%41")){
					 tx.add(Restrictions.eq("walletStatus", modell.getWalletStatus()));
				     tot.add(Restrictions.eq("walletStatus", modell.getWalletStatus()));
			}
			if(modell.getWalletEmail()!=null&&modell.getWalletEmail()!=""&&!modell.getWalletEmail().equals("%41")){
				tx.add(Restrictions.like("walletEmail",modell.getWalletEmail()));
				tot.add(Restrictions.like("walletEmail",modell.getWalletEmail()));
			}
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
			
			if(modell.getFromDateTime()!=null&&modell.getFromDateTime()!=""&&!modell.getFromDateTime().equals("%41")){
				if(modell.getToDateTime()!=null&&modell.getToDateTime()!=""&&modell.getToDateTime().length()==10&&!modell.getToDateTime().equals("%41")){	
					tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
					tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
				}else{
					tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
					tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
				}
			}
			if(modell.getTxnType()!=null&&modell.getTxnType()!=""&&!modell.getTxnType().equals("%41")){
				if(modell.getTxnType().equalsIgnoreCase("card")|| modell.getTxnType().equalsIgnoreCase("cashatpos")||modell.getTxnType().equalsIgnoreCase("void")){
					tx.add(Restrictions.eq("txnType", modell.getTxnType()));
					tot.add(Restrictions.eq("txnType", modell.getTxnType()));
				}else{
			    	 tx.add(Restrictions.eq("txnType", modell.getTxnType()));
				     tot.add(Restrictions.eq("txnType", modell.getTxnType())); 			    	 
			    }
			}  
			List<Long> authCodeIds = new ArrayList<Long>();
		    List<AcqCardDetails> authcodeList = null;
			if(modell.getAuthcode()!=null&&modell.getAuthcode()!=""&&modell.getAuthcode()!="%41"){
				authcodeList = (List<AcqCardDetails>)session.createCriteria(AcqCardDetails.class).setProjection(Projections.property("transactionId")).add(Restrictions.eq("authCode", modell.getAuthcode())).list();
				Iterator etr1 = authcodeList.iterator();
				logger.info("Txn Ids fetched successfully"+modell.getAuthcode());
				while(etr1.hasNext()){
					authCodeIds.add(Long.parseLong(""+etr1.next()));					
				}
			}
			if(modell.getAuthcode()!=null&&modell.getAuthcode()!=""&&!modell.getAuthcode().equals("%41")){
				if(authCodeIds.isEmpty()){
				     logger.info("TxnIds Not found against authcode");
				     tx.add(Restrictions.eq("walletId", 0l));
				     tot.add(Restrictions.eq("walletId", 0l));
				 }else{
				     tx.add(Restrictions.in("walletId",authCodeIds));
					 tot.add(Restrictions.in("walletId",authCodeIds));
				 }					
			}
			
			tx.addOrder(Order.desc("walletId"));
			tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
			tx.setMaxResults(20);
			List criteriaList = tx.list();
			Iterator etr1 = criteriaList.iterator();	
			Iterator etr = criteriaList.iterator();	
			Iterator<AcqWalletListEntity> itr2 = criteriaList.iterator();
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> singleMap=null;				
			Set<Long> orgset = new HashSet<Long>();
			Set<Long> userset = new HashSet<Long>();
			Set<Long> merchantSet = new HashSet<Long>();
			HashMap<String,String> orgmap = null;
			HashMap<String,String> usermap = null;
			HashMap<String,String> merchantMap = null;
			try{
				while(itr2.hasNext()){
					AcqWalletListEntity txEntity = (AcqWalletListEntity)itr2.next();
					orgset.add(txEntity.getOrgId());
					userset.add(txEntity.getUserId());
					merchantSet.add(Long.valueOf(txEntity.getMerchantId().toString()));
				}
			}catch(Exception e){
				logger.error("error iterate txn entity or add user/org id in set", e);
			}
			if(userset.isEmpty()||orgset.isEmpty()||merchantSet.isEmpty()){
			     logger.info("Org Name Users Name And Merchant Name Not Found");
			}else{
				try{
					Criteria org =session.createCriteria(AcqOrganization1.class);
				    ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("orgId"));
				     proList.add(Projections.property("name"));
				     org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
				    List list1 = org.list();
				    orgmap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        orgmap.put("orgName"+ob[0],""+ob[1]);					      
				    }
				}catch(Exception e){
					logger.error("error to select organization "+e);
				}try{
					Criteria user =session.createCriteria(AcqUser.class);
				    ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("userId"));
				     proList.add(Projections.property("loginId"));
				     user.setProjection(proList);
				     user.add((Restrictions.in("userId", userset)));
				    List list1 = user.list();
				    usermap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        usermap.put("loginId"+ob[0],""+ob[1]); 
				    }
				}catch(Exception e){
					logger.error("error in select user in wallet report "+e);
				}try{
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
			}
			int i = 0;
			Set<Integer> transactionSet = new HashSet<Integer>();
			while(etr1.hasNext()){
				AcqWalletListEntity entit = (AcqWalletListEntity)etr1.next();
				transactionSet.add(Integer.valueOf(""+entit.getWalletId()));
			}
			if(transactionSet.isEmpty()){
			     logger.info("Transaction not found");
			     singleMap = new HashMap<String,String>();
			     singleMap.put("123", "133");
			     globalList.add(singleMap);
			     globleMap.setResult(globalList);
			     return globleMap;
			     
			}else{
					List<AcqCardDetails> cardDetails = session.createCriteria(AcqCardDetails.class).add(Restrictions.in("transactionId", transactionSet)).list();
					Map<String,Map<String,String>> cardDetailMap = new HashMap<String,Map<String,String>>();
					Map<String,String> map = null;
					for(AcqCardDetails details:cardDetails){
						map = new HashMap<String,String>();
						map.put("cardHolderName",details.getCardHolderName());
						map.put("terminalId",details.getTerminalId());
						map.put("rrNo",details.getRrNo());
						map.put("batchNo",details.getBatchNo());
						map.put("authCode",details.getAuthCode());
						map.put("cardType",details.getCardType());
						map.put("imeiNo",details.getImeiNo());
						map.put("ipAddress",details.getIpAddress());
						map.put("latitude",details.getLatitude());
						map.put("longitude",details.getLongitude());	
						map.put("stan",details.getStan());					
						cardDetailMap.put(""+details.getTransactionId(),map);
					}
					logger.info("card details selected");
					while(etr.hasNext()){
						AcqWalletListEntity entit = (AcqWalletListEntity)etr.next();
						singleMap = new HashMap<String,String>();
					    singleMap.put("id",""+entit.getWalletId());
						singleMap.put("amount",""+entit.getWalletAmount());
						singleMap.put("status", ""+entit.getWalletStatus());
						SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					    SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
					    singleMap.put("dateTime",""+sdfDestinationDb.format(sdfSourceDb.parse(entit.getWalletDateTime())));
					    singleMap.put("txnType",entit.getTxnType());
					    if(entit.getWalletMobileNo().equals("0000")){
					        singleMap.put("custPhone","NA");
					        singleMap.put("cardPanNo","NA");
					       }else{
					        singleMap.put("custPhone",entit.getWalletMobileNo());
					        singleMap.put("cardPanNo",entit.getWalletMobileNo());
					      }                      
		
					      if(merchantMap.get("merchantName"+entit.getMerchantId())==null||merchantMap.get("merchantName"+entit.getMerchantId())==""){
					       singleMap.put("merchantName", "Unknown");
					      }else{
					       singleMap.put("merchantName", ""+merchantMap.get("merchantName"+entit.getMerchantId()));
					      }
					      if(usermap.get("loginId"+entit.getUserId())==null||usermap.get("loginId"+entit.getUserId())==""){
					       singleMap.put("userName", "Unknown");
					      }else{
					       singleMap.put("userName", ""+usermap.get("loginId"+entit.getUserId()));
					      } 
					      if(orgmap.get("orgName"+entit.getOrgId())==null||orgmap.get("orgName"+entit.getOrgId())==""){
					       singleMap.put("orgName", "Unknown");
					      }else{
					       singleMap.put("orgName", ""+orgmap.get("orgName"+entit.getOrgId())); 
					      }     
					      if(entit.getWalletEmail()==null||entit.getWalletEmail()==""){
					       singleMap.put("custEmail","NA");
					      }else{
					      singleMap.put("custEmail",entit.getWalletEmail());
					      }
					    singleMap.put("statusDescription", entit.getStatusDescription());
					    singleMap.put("AcqMdr",""+entit.getWalletAcqMdr());
				        singleMap.put("bankMdr",""+entit.getWalletBankMdr());
					    if(entit.getPayoutStatus()==701&&entit.getWalletStatus().equals("505")){
					    	singleMap.put("payoutStatus", "Settled");
					    	singleMap.put("payoutDateTime", ""+sdfDestination.format(entit.getPayoutDateTime()));
					    }else if(entit.getPayoutStatus()==700&&entit.getWalletStatus().equals("505")){
					    	singleMap.put("payoutStatus", "OnHold");
					    	singleMap.put("payoutDateTime", "Payout on hold");
					    }else{
					    	singleMap.put("payoutStatus", "NA");
					    	singleMap.put("payoutDateTime", "NA");
					    }	   
					    if(cardDetailMap.containsKey(""+entit.getWalletId())){
					    	Map<String,String> cardDetail = cardDetailMap.get(""+entit.getWalletId());
					    	singleMap.put("cardHolderName",cardDetail.get("cardHolderName"));
					    	if(entit.getCardPanNo().equals("0000")||entit.getCardPanNo().equals("0")) {
					            singleMap.put("cardPanNo","NA"); 
					        }else{
					         singleMap.put("cardPanNo",entit.getCardPanNo()); 
					        }
					    	singleMap.put("terminalId",cardDetail.get("terminalId"));
					    	
					    	if(cardDetail.get("rrNo")==null||cardDetail.get("rrNo")==""){
					    		singleMap.put("rrNo","");
					    	}else{
					    		if(cardDetail.get("rrNo").startsWith("-")){
						    		singleMap.put("rrNo",cardDetail.get("rrNo").substring(1));
						    	}else{
						    		singleMap.put("rrNo",cardDetail.get("rrNo"));
						    	}				    		
					    	}		    								    	
					    	singleMap.put("batchNo",cardDetail.get("batchNo"));
					    	singleMap.put("authCode",cardDetail.get("authCode"));
					    	singleMap.put("issuerAuthCode","");
					    	singleMap.put("cardExpDate","");
					    	singleMap.put("cardType",cardDetail.get("cardType"));
					    	singleMap.put("referenceNo","");
					    	singleMap.put("imeiNo",cardDetail.get("imeiNo"));
					    	singleMap.put("ipAddress",cardDetail.get("ipAddress"));				    	
					    	singleMap.put("latitude",cardDetail.get("latitude"));
					    	singleMap.put("longitude",cardDetail.get("longitude"));	
					    	singleMap.put("stan",cardDetail.get("stan"));
					    	
					    }
					    globalList.add(singleMap);
						i++;
					}
					    }
			logger.info("records are putted in map");
			Long rows = (Long) tot.uniqueResult();
			Long totalRows= rows/20;
			Long modlus = rows%20;
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
			globleMap.setResult(globalList);
			globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
			globleMap.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("wallet list selected successfully");
			return globleMap;			
		}catch(Exception e){
			logger.info("error to select wallet list"+e);
			return null;
		}	}

	
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> txnMerchantlist1(AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		//Session s = null;
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
			ProjectionList proList = Projections.projectionList();
		    proList.add(Projections.property("merchantId"));
		    proList.add(Projections.property("merchantName"));
		    Criteria tx= session.createCriteria(AcqMerchant.class).setProjection(proList);			
		    if(modell.getEmpId()==null||modell.getEmpId()==""){
				System.out.println("Emp Id Is Null");
			}else if((modell.getEmpId()!=null||modell.getEmpId()!="")&&modell.getEmpId().equalsIgnoreCase("10")){
				tx.add(Restrictions.eq("cubMerchant", "1"));
			}
		    List list = tx.list();
			HashMap merchantMap=null;
			for(Object obj:list){
					merchantMap = new HashMap<String,String>();
			        Object[] ob=(Object[])obj;
			        merchantMap.put("merchantId",""+ob[0]);
			        merchantMap.put("mrchantName",""+ob[1]); 
			        merchantMap.put("merchantName",""+ob[1]+" -  "+ob[0]);
			        globalList.add(merchantMap);  
			}	
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("merchant successfully selected");
			return global;
	}catch(Exception e){
		global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		global.setMessage(AcqStatusDefination.RollBackError.getDetails());
		logger.error("error"+e);
		return null;
	}
}   
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> txnOrgList1(
			AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		//Session s = null;
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			if(""+modell.getMerchantId()!=null&&""+modell.getMerchantId()!=""&&!modell.getMerchantId().equals("null")){
				ProjectionList proList = Projections.projectionList();
				proList.add(Projections.property("orgId"));
				proList.add(Projections.property("name"));
				Criteria tx= session.createCriteria(AcqOrganization1.class).setProjection(proList).add(Restrictions.eq("merchantId", Integer.valueOf(""+modell.getMerchantId())));				
				List list = tx.list();
				HashMap OrgMap=null;
				for(Object obj:list){
					String merchantType = (String)session.createCriteria(AcqAddNewMerchantEntity.class).setProjection(Projections.property("merchantType")).add(Restrictions.eq("merchantId",Long.valueOf(modell.getMerchantId()))).uniqueResult();											
					OrgMap = new HashMap<String,String>();
				    Object[] ob=(Object[])obj;
				    OrgMap.put("orgId",""+ob[0]);
				    OrgMap.put("orgName",""+ob[1]);
				    globalList.add(OrgMap);
				}
			}
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("organization successfully selected");
			return global;
		}catch(Exception e){
			global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			global.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error in select org "+e);
			return null;
		}
	}
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> txnTerminalList1(AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		try	{
			Session session = AcqMerchantDaoImpl.getSession();
			if(""+modell.getOrgId()!=null&&""+modell.getOrgId()!=""&&!modell.getOrgId().equals("null")){
				ProjectionList proList = Projections.projectionList();
				proList.add(Projections.property("userId"));
				proList.add(Projections.property("loginId"));
				Criteria tx = session.createCriteria(AcqUser.class).setProjection(proList).add(Restrictions.eq("orgId", Long.valueOf(modell.getOrgId())));				
				List list = tx.list();
				HashMap userMap=null;
				for(Object obj:list){
					userMap = new HashMap<String,String>();
					Object[] ob=(Object[])obj;
					userMap.put("userId",""+ob[0]);
					userMap.put("loginId",""+ob[1]); 
					globalList.add(userMap);  
				}
			}
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("terminal list successfully selected");
			return global;
		}catch(Exception e){
			global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			global.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error select termainal "+e);
			return null;
		}
	}
	
	@Override
	public DbDto<String> updateMdr(String txnId, String AcqMdr, String bankMdr) {
		DbDto<String> response = new DbDto<String>();
		logger.info("request landing in update Mdr Dao");		
		Transaction tx = null;
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqWalletListEntity ent = (AcqWalletListEntity)session.createCriteria(AcqWalletListEntity.class).add(Restrictions.eq("walletId", Long.valueOf(txnId))).add(Restrictions.eq("payoutStatus", 700)).uniqueResult();
			if (ent == null || ent + "" == "") {
			    response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
			    response.setMessage(AcqStatusDefination.NotFound.getDetails());//"Transaction not found for update or batch is setteled");
			    logger.info("Transaction not found for update or batch is setteled");
			    return response;
			} else {
				if(bankMdr.equals(null)||bankMdr.equals("")){
					logger.info("BankMdr not found for update");
				}else{
					ent.setWalletBankMdr(bankMdr);
				}
				if(AcqMdr.equals(null)||AcqMdr.equals("")){
					logger.info("AcqMdr not found for update");
				}else{
					ent.setWalletAcqMdr(AcqMdr);
				}
				session.update(ent);
				tx = session.beginTransaction();
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Mdr successfully updated");

			}
		} catch (Exception e) {
			tx.rollback();
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
			logger.error("Error in Update Mdr " + e);
		}
		return response;
	}

	
	@Override
	public DbDto<HashMap<String, String>> getCardTxnDetails(String signImage){
		DbDto<HashMap<String, String>> response = new DbDto<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		try{
			System.out.println("sign image id: "+signImage);
			Session session = AcqMerchantDaoImpl.getSession();
			Criteria criteria = (Criteria) session.createCriteria(AcqMobikwikEntity.class);
			ProjectionList projList = Projections.projectionList();
			projList.add(Projections.countDistinct("id"));
			projList.add(Projections.property("userid"));
			projList.add(Projections.property("orgId"));
			projList.add(Projections.property("merchantId"));
			projList.add(Projections.property("otpDateTime"));
			projList.add(Projections.property("amount"));			
			criteria.add(Restrictions.eq("id", Integer.valueOf(signImage)));
			AcqMobikwikEntity entity = (AcqMobikwikEntity) criteria.uniqueResult();			
			if(entity==null||entity+""==""){
				logger.warn("No result found");
				response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				response.setResult(null);
			}else{
				logger.info("txn details is fetched");
				if(entity.getTxnType().equalsIgnoreCase("CARD")||entity.getTxnType().equalsIgnoreCase("CASHATPOS")||entity.getTxnType().equalsIgnoreCase("VOID")||entity.getTxnType().equalsIgnoreCase("CVOID")){
					AcqCardDetails cardEnt = (AcqCardDetails)session.createCriteria(AcqCardDetails.class).add(Restrictions.eq("transactionId",entity.getId())).uniqueResult();
					if(cardEnt==null||cardEnt+""==""){
						logger.warn("Card details not found");						
					}else{
						logger.info("card details found");
						if(cardEnt.getCardHolderName()==null||cardEnt.getCardHolderName()==""){
							map.put("cardHolderName", "NA");
						}else{
							map.put("cardHolderName", cardEnt.getCardHolderName());
						}
						
						if(entity.getCarPanNo()==null||entity.getCarPanNo()==""){
							map.put("cardPanNo", "NA");
						}else{
							map.put("cardPanNo", entity.getCarPanNo());
						}					
						
						if(cardEnt.getTerminalId()==null||cardEnt.getTerminalId()==""){
							map.put("terminalId", "NA");
						}else{
							map.put("terminalId", cardEnt.getTerminalId());
						}
						if(cardEnt.getCardType()==null||cardEnt.getCardType()==""){
							map.put("cardType", "NA");
						}else{
							map.put("cardType", cardEnt.getCardType());
						}
						
						if(cardEnt.getIpAddress()==null||cardEnt.getIpAddress()==""){
							map.put("ipAddress", "NA");
						}else{
							map.put("ipAddress", cardEnt.getIpAddress());
						}
						
						if(cardEnt.getImeiNo()==null||cardEnt.getImeiNo()==""){
							map.put("imeiNo", "NA");
						}else{
							map.put("imeiNo", cardEnt.getImeiNo());
						}
						if(cardEnt.getLatitude()==null||cardEnt.getLatitude()==""){
							map.put("latitude", "NA");
						}else{
							map.put("latitude", cardEnt.getLatitude());
						}
						if(cardEnt.getLongitude()==null||cardEnt.getLongitude()==""){
							map.put("longitude", "NA");
						}else{
							map.put("longitude", cardEnt.getLongitude());
						}
						if(cardEnt.getStan()==null||cardEnt.getStan()==""){
							map.put("stan", "NA");
						}else{
							map.put("stan", cardEnt.getStan());
						}
						
						if(cardEnt.getRrNo()==null||cardEnt.getRrNo()==""){
							map.put("rrNo", "NA");
						}else{
							if(cardEnt.getRrNo().startsWith("-")){
								map.put("rrNo", cardEnt.getRrNo().substring(1));
							}else{
								map.put("rrNo", cardEnt.getRrNo());
							}
						}
						
						if(cardEnt.getAuthCode()==null||cardEnt.getAuthCode()==""){
							map.put("authCode", "NA");
						}else{
							map.put("authCode", cardEnt.getAuthCode());
						}
						
						
						if(cardEnt.getBatchNo()==null||cardEnt.getBatchNo()==""){
							map.put("batchNo", "NA");
						}else{
							map.put("batchNo", cardEnt.getBatchNo());
						}
						logger.info("details selected and putted in map");
					}
				}
				map.put("txnId",""+ entity.getId());
				map.put("invoiceId",""+ entity.getId());
				map.put("amount",""+ entity.getAmount());
				if(entity.getDescription()==null|entity.getDescription()==""){
					map.put("description","NA");
				}else{
					map.put("description",""+ entity.getDescription());
				}
				
				map.put("txnType", entity.getTxnType());
				//System.out.println("entity org id "+entity.getOrgId());
				
				AcqOrganization orgEntity = (AcqOrganization)session.createCriteria(AcqOrganization.class).add(Restrictions.eq("id", Long.valueOf(""+entity.getOrgId()))).uniqueResult();
				logger.info("organization details selected");
				if(orgEntity==null||orgEntity+""==""){
					map.put("orgName", "NA");
					map.put("orgAddress", "NA");
				}else{
					String address = "".concat(orgEntity.getAddress1()).concat("|"+orgEntity.getAddress2()).			
					concat("|"+orgEntity.getCity());
					
					String address2="".concat(orgEntity.getState()).concat("|"+orgEntity.getCountry()).concat("|"+orgEntity.getPincode());
					map.put("orgName", orgEntity.getName());
					map.put("orgAddress1", address);
					map.put("orgAddress2", address2);
				}
				AcqUser AcqUser = (AcqUser)session.createCriteria(AcqUser.class).add(Restrictions.eq("id",Long.valueOf(""+entity.getUserid()))).uniqueResult();
				if(AcqUser==null||AcqUser+""==""){
					map.put("rmn","NA");
					map.put("emailId","NA");
				}else{
					map.put("rmn", ""+AcqUser.getRmn());
					map.put("emailId",AcqUser.getEmailId());
				}
				logger.info("user selected");
				SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				try{
					if(entity.getTxnType().equals("CARD")||entity.getTxnType().equals("CASHATPOS")||entity.getTxnType().equals("VOID")||entity.getTxnType().equals("CVOID")){
						String tid = (String)session.createCriteria(AcqDevice.class).setProjection(Projections.property("bankTId")).add(Restrictions.eq("userId",Long.valueOf(""+entity.getUserid()))).uniqueResult();
						if(tid!=null){
							map.put("tid", tid);
						}else{
							map.put("tid", "NA");
						}
					}else{
						map.put("tid", "NA");
					}
					if(entity.getTxnType().equals("CARD")||entity.getTxnType().equals("CASHATPOS")||entity.getTxnType().equals("VOID")||entity.getTxnType().equals("CVOID")){
						String merchantTID = (String)session.createCriteria(AcqMerchant.class).setProjection(Projections.property("bankMid")).add(Restrictions.eq("merchantId",entity.getMerchantId())).uniqueResult();
						if(merchantTID!=null){
							map.put("mid", merchantTID);
						}else{
							map.put("mid", "NA");
						}
					}else{
						map.put("mid", "NA");
					}
			}catch(Exception e){
				logger.error("error to select tid,mid "+e);
			}
				map.put("walletType",entity.getTxnType());
				map.put("dateTime", ""+df.format(entity.getOtpDateTime()));	
				if(entity.getEmail()==null||entity.getEmail()==""){
					map.put("custEmail", "NA");
				}else{
					map.put("custEmail", ""+entity.getEmail());
				}				
				map.put("custMobileNo", ""+entity.getMobile());
				if(entity.getStatus()==505){
					map.put("txnStatus", "SUCCESS");
				}else{
					map.put("txnStatus", "FAILED");
				}
				map.put("txnDes", ""+entity.getDescription());
				//map.put("dateTime", ""+entity.getDateTime());	
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(map);
				logger.info("Wallet txn details selected");
			}		
			
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to select transaction details in receipt dao "+e);
		}
		return response;
	}
	
	
	@Override
	public DbDto<String> addRisk(String txnId, String txnType) {
		DbDto<String> response = new DbDto<String>();
		logger.info("request landing in add Risk status Dao");		
		//Session session = null;
		Date date= new Date();
		Timestamp currentTimestamp= new Timestamp(date.getTime());
		System.out.println(txnId+" :txntype: "+txnType);
		try {				
			Session session = AcqMerchantDaoImpl.getSession();
			AcqWalletListEntity txnEnt = (AcqWalletListEntity) session.createCriteria(AcqWalletListEntity.class).add(Restrictions.eq("walletId", Long.valueOf(txnId))).add(Restrictions.eq("walletStatus","505")).add(Restrictions.eq("payoutStatus",700)).uniqueResult();
			if (txnEnt == null || txnEnt + "" == "") {
			    response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
			    response.setMessage("Txn is failed or Payout already done");
			    logger.info("Txn is failed or payout already done");
			 }else{
					if(txnType.equalsIgnoreCase("CARD")||txnType.equalsIgnoreCase("CASHATPOS")){
						AcqRiskManagement AcqRisk = (AcqRiskManagement) session.createCriteria(AcqRiskManagement.class).add(Restrictions.eq("txnId",Integer.valueOf(txnId))).uniqueResult();
						if (AcqRisk == null || AcqRisk + "" == "") {
							AcqRiskManagement AcqRisk1 = new AcqRiskManagement();
							AcqRisk1.setStatus("1");
							AcqRisk1.setDateTime(""+currentTimestamp);
							AcqRisk1.setTxnId(Integer.parseInt(txnId));
							AcqRisk1.setDescription("Acquiro add this txn in to risk");
							Transaction tx = session.beginTransaction();
							session.save(AcqRisk1);
							tx.commit();
							response.setStatus(AcqStatusDefination.OK.getIdentifier());
							response.setMessage(AcqStatusDefination.OK.getDetails());
							logger.info("Risk Status successfully added");
							return response;
						} else if(AcqRisk.getStatus().equals("0")){
							AcqRisk.setStatus("1");
							AcqRisk.setDateTime(""+currentTimestamp);
							AcqRisk.setDescription("Acquiro add this txn in to risk");
							Transaction tx = session.beginTransaction();
							session.update(AcqRisk);
							tx.commit();
							response.setStatus(AcqStatusDefination.OK.getIdentifier());
							response.setMessage(AcqStatusDefination.OK.getDetails());
							logger.info("Risk Status successfully added");
						}else{
							logger.info(" Txn already in Risk");
							response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
							response.setMessage(" Txn already in Risk");
							return response;
						}
						response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
					    response.setMessage("Added to risk");
					    logger.info("Txn can't be add to risk");
					}
				}
			} catch (Exception e) {
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
				logger.error("Error in add Risk Status " + e);
			}
			return response;
		}	
	
	
	@Override
	public DbDto<Object> updateRiskStatus(String id,String txnType) {
			DbDto<Object> response = new DbDto<Object>();
			logger.info("request landing in update Risk status Dao");		
			Date date= new Date();
			Timestamp currentTimestamp= new Timestamp(date.getTime());
			try {
				Session session = AcqMerchantDaoImpl.getSession();
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DAY_OF_YEAR, -1);
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(txnType.equalsIgnoreCase("CARD")||txnType.equalsIgnoreCase("VOID")|| txnType.equalsIgnoreCase("CASHATPOS")|| txnType.equalsIgnoreCase("CVOID")){
					AcqRiskManagement AcqRisk = (AcqRiskManagement) session.createCriteria(AcqRiskManagement.class).add(Restrictions.eq("id",Integer.valueOf(id))).uniqueResult();
					if (AcqRisk == null || AcqRisk + "" == "") {
						response.setMessage(AcqStatusDefination.NotFound.getDetails());
						logger.info("Detail not found for update");
					} else {
						logger.info("risk is selected");
						String dateTime = (String)session.createCriteria(AcqWalletListEntity.class).setProjection(Projections.property("walletDateTime")).add((Restrictions.eq("walletId",Long.valueOf(""+AcqRisk.getTxnId())))).uniqueResult();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String todayDate = sdf.format(new Date());					
						if(dateTime.equals(todayDate)){		
							AcqRisk.setDateTime(""+currentTimestamp);
						}else{
							String dayBefor=sd.format(cal.getTime().getTime());
							AcqRisk.setDateTime(dayBefor);
						}
						logger.info("Risk Status updating");
						AcqRisk.setStatus("0");				
						Transaction tx = session.beginTransaction();
						session.update(AcqRisk);
						tx.commit();
						response.setStatus(AcqStatusDefination.OK.getIdentifier());
						response.setMessage(AcqStatusDefination.OK.getDetails());
						logger.info("Risk Status successfully updated");
					}
				}else{
					AcqWalletRiskManagement AcqRisk = (AcqWalletRiskManagement) session.createCriteria(AcqWalletRiskManagement.class).add(Restrictions.eq("id",Integer.valueOf(id))).uniqueResult();
					if (AcqRisk == null || AcqRisk + "" == "") {
						response.setMessage(AcqStatusDefination.NotFound.getDetails());
						logger.info("Detail not found for Wallet Risk update");
					} else {
						logger.info("risk is selected");
						String dateTime = (String)session.createCriteria(AcqWalletListEntity.class).setProjection(Projections.property("walletDateTime")).add((Restrictions.eq("walletId",Long.valueOf(""+AcqRisk.getTxnId())))).uniqueResult();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String todayDate = sdf.format(new Date());				
						if(dateTime.equals(todayDate)){		
							AcqRisk.setDateTime(""+currentTimestamp);
						}else{							
							String dayBefor=sd.format(cal.getTime().getTime());
							AcqRisk.setDateTime(dayBefor);
						}
						logger.info("Wallet Risk Status updating");
						AcqRisk.setStatus("0");
						AcqRisk.setDateTime(""+currentTimestamp);
						Transaction tx = session.beginTransaction();
						session.update(AcqRisk);
						tx.commit();
						response.setStatus(AcqStatusDefination.OK.getIdentifier());
						response.setMessage(AcqStatusDefination.OK.getDetails());
						logger.info("Wallet Risk Status successfully updated");
					}
				}
			} catch (Exception e) {
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError
						.getDetails());
				logger.error("Error in Update Risk Status " + e);
			}
			return response;
		}
	
	
	
	
	@Override
	public DbDto<List<HashMap<String, String>>> riskManagementList(AcqSearchModel modell) {
		logger.info("request is landing in dao for risk Management list");
		//Session session = null;
		try{
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
			Session session = AcqMerchantDaoImpl.getSession();
			List<Long> list = new ArrayList<Long>();
			Map<Integer,String> listIds = new HashMap<Integer,String>();
			Map<Long,String> descriptionMap = new HashMap<Long,String>();
			Criteria riskCriteria = (Criteria)  session.createCriteria(AcqRiskManagement.class).add(Restrictions.eq("status", "1"));
			List riskList = riskCriteria.list();
			if(riskList.isEmpty()){
				logger.info("List is Empty");
			}else{
				Iterator<AcqRiskManagement> it = riskList.iterator();
				while(it.hasNext()){
					AcqRiskManagement entit1 = (AcqRiskManagement)it.next();
					list.add(Long.valueOf(""+entit1.getTxnId()));	
					listIds.put(Integer.valueOf(""+entit1.getTxnId()),""+entit1.getId());	
					descriptionMap.put(Long.valueOf(""+entit1.getTxnId()), entit1.getDescription());
				}
				System.out.println("List::::::::::::::::::"+listIds);
				Criteria tot = session.createCriteria(AcqWalletListEntity.class);
				tot.add(Restrictions.in("walletId",list));
				tot.setProjection(Projections.rowCount());				
				Criteria tx=session.createCriteria(AcqWalletListEntity.class);	
				long txn=0l;
				if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&modell.getUserPhone().length()==10&&!modell.getUserPhone().equals("%41")){  
				      try{
				       txn=(Long) session.createCriteria(AcqAppUser.class).add(Restrictions.eq("loginId", Long.valueOf(modell.getUserPhone()))).setProjection(Projections.property("userId")).uniqueResult();
				      }catch(NullPointerException npe){
				       txn=0;
				      }catch(Exception e){
				       System.out.println("error to select login id "+e);
				      }
				     }
				     if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&!modell.getUserPhone().equals("%41")){ 
				      tx.add(Restrictions.eq("userId", txn));
				      tot.add(Restrictions.eq("userId",txn));
				     }
				     if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""&&!modell.getCustPhone().equals("%41")){
				      tx.add(Restrictions.like("walletMobileNo","%"+modell.getCustPhone()+"%"));
				      tot.add(Restrictions.like("walletMobileNo","%"+modell.getCustPhone()+"%"));
				     }
				     if(modell.getWalletTxnId()!=null&&modell.getWalletTxnId()!=""&&!modell.getWalletTxnId().equals("%41")){
				      tx.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
				      tot.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
				     }
				     if(modell.getWalletEmail()!=null&&modell.getWalletEmail()!=""&&!modell.getWalletEmail().equals("%41")){
				      tx.add(Restrictions.like("walletEmail","%"+modell.getWalletEmail()));
				      tot.add(Restrictions.like("walletEmail","%"+modell.getWalletEmail()));
				     }
				     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
				     SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				      
				     if(modell.getFromDateTime()!=null&&modell.getFromDateTime()!=""&&!modell.getFromDateTime().equals("%41")){
				     
				      if(modell.getToDateTime()!=null&&modell.getToDateTime()!=""&&modell.getToDateTime().length()==10&&!modell.getToDateTime().equals("%41")){ 
				       tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
				       tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
				      }else{
				       tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
				       tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
				      }
				     }  
				     if(modell.getTxnType()!=null&&modell.getTxnType()!=""&&!modell.getTxnType().equals("%41")){
				      if(modell.getTxnType().equalsIgnoreCase("card")){
				       tx.add(Restrictions.eq("txnType", modell.getTxnType()));
				       tot.add(Restrictions.eq("txnType", modell.getTxnType()));
				      }else if(modell.getTxnType().equalsIgnoreCase("void")){
				       tx.add(Restrictions.eq("txnType", modell.getTxnType()));
				       tot.add(Restrictions.eq("txnType", modell.getTxnType()));
				      }else{
				           tx.add(Restrictions.eq("txnType", modell.getTxnType()));
				           tot.add(Restrictions.eq("txnType", modell.getTxnType()));          
				         }
				     }
				
				tx.add(Restrictions.in("walletId",list));
				tx.addOrder(Order.desc("walletId"));
				tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
				tx.setMaxResults(20);
				List criteriaList = tx.list();
				Iterator etr1 = criteriaList.iterator();	
				Iterator etr = criteriaList.iterator();	
				Iterator<AcqWalletListEntity> itr2 = criteriaList.iterator();
				List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
				HashMap<String,String> singleMap=null;				
				Set<Long> orgset = new HashSet<Long>();
				Set<Long> userset = new HashSet<Long>();
				Set<Long> merchantSet = new HashSet<Long>();
				HashMap<String,String> orgmap = null;
				HashMap<String,String> usermap = null;
				HashMap<String,String> merchantMap = null;
				try{
					while(itr2.hasNext()){
						AcqWalletListEntity txEntity = (AcqWalletListEntity)itr2.next();
						orgset.add(txEntity.getOrgId());
						userset.add(txEntity.getUserId());
						merchantSet.add(Long.valueOf(txEntity.getMerchantId().toString()));
					}
				}catch(Exception e){
					logger.error("error iterate txn entity or add user/org id in set", e);
				}try{
					Criteria org =session.createCriteria(AcqOrganization1.class);
				    ProjectionList proList = Projections.projectionList();
				    proList.add(Projections.property("orgId"));
				    proList.add(Projections.property("name"));
				    org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
				    List list1 = org.list();
				    orgmap= new HashMap<String,String>();
				    for(Object obj:list1){
				        Object[] ob=(Object[])obj;
				        orgmap.put("orgName"+ob[0],""+ob[1]);					      
				    }
				}catch(Exception e){
					logger.error("error to select organization "+e);
				}try{
					Criteria user =session.createCriteria(AcqUser.class);
				    ProjectionList proList = Projections.projectionList();
				    proList.add(Projections.property("userId"));
				    proList.add(Projections.property("loginId"));
				    user.setProjection(proList);
				    user.add((Restrictions.in("userId", userset)));
				    List list1 = user.list();
				    usermap= new HashMap<String,String>();
				    for(Object obj:list1){
				    	Object[] ob=(Object[])obj;
				        usermap.put("loginId"+ob[0],""+ob[1]); 
				    }
				}catch(Exception e){
					logger.error("error in select user in wallet report "+e);
				}try{
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
				int i = 0;
				Set<Integer> transactionSet = new HashSet<Integer>();
				for(Long j: list){
					transactionSet.add(j.intValue());					
				}
				List<AcqCardDetails> cardDetails = session.createCriteria(AcqCardDetails.class).add(Restrictions.in("transactionId", transactionSet)).list();
				Map<String,Map<String,String>> cardDetailMap = new HashMap<String,Map<String,String>>();
				Map<String,String> map = null;
				for(AcqCardDetails details:cardDetails){
					map = new HashMap<String,String>();
					map.put("cardHolderName",details.getCardHolderName());
					map.put("terminalId",details.getTerminalId());
					map.put("rrNo",details.getRrNo());
					map.put("batchNo",details.getBatchNo());
					map.put("authCode",details.getAuthCode());
					map.put("cardType",details.getCardType());
					map.put("imeiNo",details.getImeiNo());
					map.put("ipAddress",details.getIpAddress());
					map.put("latitude",details.getLatitude());
					map.put("longitude",details.getLongitude());	
					map.put("stan", details.getStan());
					cardDetailMap.put(""+details.getTransactionId(),map);
				}
				while(etr.hasNext()){
					AcqWalletListEntity entit = (AcqWalletListEntity)etr.next();
					singleMap = new HashMap<String,String>();
				    singleMap.put("id",""+entit.getWalletId());
					singleMap.put("amount",""+entit.getWalletAmount());
					if(entit.getWalletStatus().equals("505")){
						singleMap.put("status","SUCCESS");
					}else {
						singleMap.put("status","FAILED");
					}
					if(entit.getWalletAmount().startsWith("-")&entit.getWalletStatus().equals("505")){
						singleMap.put("status","VOID");
					}
					singleMap.put("custPhone",""+entit.getWalletMobileNo());
					SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				    singleMap.put("dateTime",""+sdfDestinationDb.format(sdfSourceDb.parse(entit.getWalletDateTime())));
				    singleMap.put("txnType",entit.getTxnType());
				    if(merchantMap.get("merchantName"+entit.getMerchantId())==null||merchantMap.get("merchantName"+entit.getMerchantId())==""){
				        singleMap.put("merchantName", "Unknown");
				    }else{
				        singleMap.put("merchantName", ""+merchantMap.get("merchantName"+entit.getMerchantId()));
				    }
				    if(usermap.get("loginId"+entit.getUserId())==null||usermap.get("loginId"+entit.getUserId())==""){
				       singleMap.put("userName", "Unknown");
				    }else{
				        singleMap.put("userName", ""+usermap.get("loginId"+entit.getUserId()));
				    } 
				    if(orgmap.get("orgName"+entit.getOrgId())==null||orgmap.get("orgName"+entit.getOrgId())==""){
				        singleMap.put("orgName", "Unknown");
				    }else{
				        singleMap.put("orgName", ""+orgmap.get("orgName"+entit.getOrgId())); 
				    }     
				    if(entit.getWalletEmail()==null||entit.getWalletEmail()==""){
				        singleMap.put("custEmail","NA");
				    }else{
				       singleMap.put("custEmail",entit.getWalletEmail());
				    }
				    singleMap.put("riskId",""+listIds.get(entit.getWalletId()));
				    singleMap.put("statusDescription", entit.getStatusDescription());
				    if(cardDetailMap.containsKey(""+entit.getWalletId())){
				    	Map<String,String> cardDetail = cardDetailMap.get(""+entit.getWalletId());
				    	singleMap.put("cardHolderName",cardDetail.get("cardHolderName"));
				    	singleMap.put("cardPanNo",entit.getCardPanNo());
				    	singleMap.put("terminalId",cardDetail.get("terminalId"));
				    	singleMap.put("rrNo",cardDetail.get("rrNo"));
				    	singleMap.put("batchNo",cardDetail.get("batchNo"));
				    	singleMap.put("authCode",cardDetail.get("authCode"));
				    	singleMap.put("issuerAuthCode","");
				    	singleMap.put("cardExpDate","");
				    	singleMap.put("cardType",cardDetail.get("cardType"));
				    	singleMap.put("referenceNo","");
				    	singleMap.put("imeiNo",cardDetail.get("imeiNo"));
				    	singleMap.put("ipAddress",cardDetail.get("ipAddress"));		    	
				    	singleMap.put("latitude",cardDetail.get("latitude"));
				    	singleMap.put("longitude",cardDetail.get("longitude"));
				    	singleMap.put("stan",cardDetail.get("stan"));
				    	
				    	singleMap.put("riskDescription", descriptionMap.get(entit.getWalletId()));
				    }
				    
				    globalList.add(singleMap);
					i++;
				}
				Long rows = (Long) tot.uniqueResult();
				Long totalRows= rows/20;
				Long modlus = rows%20;
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
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Risk Management list selected successfully");
				}
				return globleMap;	
			
			}catch(Exception e){
				logger.info("error to select Risk Management list"+e);
				return null;
			}
		}

	

	@Override
	public DbDto<List<HashMap<String, String>>> txnMerchantlist(AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		//Session s = null;
		try{
			Session s = AcqMerchantDaoImpl.getSession();
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
			ProjectionList proList = Projections.projectionList();
		     proList.add(Projections.property("merchantId"));
		     proList.add(Projections.property("merchantName"));
		   Criteria tx= s.createCriteria(AcqMerchant.class).setProjection(proList);				
			List list = tx.list();
			HashMap merchantMap=null;
			for(Object obj:list){
					merchantMap = new HashMap<String,String>();
			        Object[] ob=(Object[])obj;
			        merchantMap.put("merchantId",""+ob[0]);
			        merchantMap.put("merchantName",""+ob[1]); 
			        globalList.add(merchantMap);  
			}	
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("merchant successfully selected");
			return global;
	}catch(Exception e){
		global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		global.setMessage(AcqStatusDefination.RollBackError.getDetails());
		logger.error("error"+e);
		return null;
	}
}   
	
	public DbDto<List<HashMap<String, String>>> txnOrgList(
			AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		//Session s = null;
		try{
			if(""+modell.getMerchantId()!=null&&""+modell.getMerchantId()!=""&&!modell.getMerchantId().equals("null")){			
				Session s = AcqMerchantDaoImpl.getSession();
				ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("orgId"));
			     proList.add(Projections.property("name"));	
				Criteria tx= s.createCriteria(AcqOrganization.class).setProjection(proList).add(Restrictions.eq("merchantId", Integer.valueOf(""+modell.getMerchantId())));				
				List list = tx.list();
				HashMap OrgMap=null;
				for(Object obj:list){
					String merchantType = (String)s.createCriteria(AcqAddNewMerchantEntity.class).setProjection(Projections.property("merchantType")).add(Restrictions.eq("merchantId",modell.getMerchantId())).uniqueResult();											
						OrgMap = new HashMap<String,String>();
				        Object[] ob=(Object[])obj;
				        OrgMap.put("orgId",""+ob[0]);				        
				        System.out.println("orgId--"+ob[0]);
				        OrgMap.put("orgName",""+ob[1]);
				        globalList.add(OrgMap);  
				}
					}        
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("organization successfully selected");
			return global;
		}catch(Exception e){
			global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			global.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error in select org "+e);
			return null;
		}
	}
	
	@Override
	public DbDto<List<HashMap<String, String>>> txnTerminalList(AcqBillingModel modell) {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		//Session s = null;
		try	{
			if(""+modell.getOrgId()!=null&&""+modell.getOrgId()!=""&&!modell.getOrgId().equals("null")){
				
				Session s = AcqMerchantDaoImpl.getSession();
				 ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("userId"));
			     proList.add(Projections.property("loginId"));	
				Criteria tx= s.createCriteria(AcqUser.class).setProjection(proList).add(Restrictions.eq("orgId", modell.getOrgId()));				
				List list = tx.list();
				HashMap userMap=null;
				for(Object obj:list){
						userMap = new HashMap<String,String>();
				        Object[] ob=(Object[])obj;
				        userMap.put("userId",""+ob[0]);
				        userMap.put("loginId",""+ob[1]); 
				        globalList.add(userMap);  
			}  }
			global.setResult(globalList);
			global.setStatus(AcqStatusDefination.OK.getIdentifier());
			global.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("terminal list successfully selected");
			return global;
		}catch(Exception e){
			global.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			global.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error select termainal "+e);
			return null;
		}
	}
	@Override
	public DbDto<List<HashMap<String, String>>> walletList(AcqSearchModel modell) {
			logger.info("request is landing in dao for wallet list");
			//Session session = null;
			try{
				DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
				Session session = AcqMerchantDaoImpl.getSession();
				List<Long> merchantIds = new ArrayList<Long>();
				List<AcqMerchant> merchantList = null;
				Criteria tot = session.createCriteria(AcqWalletListEntity.class);
				List<String> statusList = new ArrayList<String>();
				List<Long> orgIds = new ArrayList<Long>();
				List<AcqOrganization1> orgList = null;
				statusList.add("504");statusList.add("505");
				tot.add(Restrictions.in("walletStatus",statusList));
				tot.setProjection(Projections.rowCount());
				if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&modell.getMerchantName()!="%41"){
					merchantList = (List<AcqMerchant>)session.createCriteria(AcqMerchant.class).setProjection(Projections.property("merchantId")).add(Restrictions.like("merchantName", modell.getMerchantName()+"%")).list();
					Iterator itr = merchantList.iterator();
					logger.info("merchant fetched successfully");
					while(itr.hasNext()){
						merchantIds.add(Long.parseLong(""+itr.next()));					
					}
				}
				if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&modell.getOrgName()!="%41"){
					orgList = (List<AcqOrganization1>)session.createCriteria(AcqOrganization1.class).setProjection(Projections.property("orgId")).add(Restrictions.like("name", modell.getOrgName()+"%")).list();
					Iterator itr = orgList.iterator();
					logger.info("Organization fetched successfully");
					while(itr.hasNext()){
						orgIds.add(Long.parseLong(""+itr.next()));					
					}
				}
				Criteria tx=session.createCriteria(AcqWalletListEntity.class);				
				long txn=0l;
				if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&modell.getUserPhone().length()==10&&!modell.getUserPhone().equals("%41")){		
					try{
						txn=(Long) session.createCriteria(AcqAppUser.class).add(Restrictions.eq("loginId", Long.valueOf(modell.getUserPhone()))).setProjection(Projections.property("userId")).uniqueResult();
					}catch(NullPointerException npe){
						txn=0;
					}catch(Exception e){
						System.out.println("error to select login id "+e);
					}
				}if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""&&!modell.getUserPhone().equals("%41")){
					tx.add(Restrictions.eq("userId", txn));
					tot.add(Restrictions.eq("userId", txn));
				}
				if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
					if(merchantIds.isEmpty()){
					     logger.info("merchantIds Not found");
					     tx.add(Restrictions.eq("merchantId", 0l));
					     tot.add(Restrictions.eq("merchantId", 0l));
					 }else{
					     tx.add(Restrictions.in("merchantId",merchantIds));
						 tot.add(Restrictions.in("merchantId",merchantIds));
					 }					
				}
				if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&!modell.getOrgName().equals("%41")){
					if(orgIds.isEmpty()){
					    logger.info("OrgIds Not found");
					    tx.add(Restrictions.eq("orgId", 0l));
					    tot.add(Restrictions.eq("orgId", 0l));
					}else{
					    tx.add(Restrictions.in("orgId", orgIds));
					    tot.add(Restrictions.in("orgId", orgIds));
					}
				}
				if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""&&!modell.getCustPhone().equals("%41")){
					tx.add(Restrictions.eq("walletMobileNo",modell.getCustPhone()));
					tot.add(Restrictions.eq("walletMobileNo",modell.getCustPhone()));
				}
				if(modell.getWalletTxnId()!=null&&modell.getWalletTxnId()!=""&&!modell.getWalletTxnId().equals("%41")){
					tx.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
					tot.add(Restrictions.eq("walletId", Long.valueOf(modell.getWalletTxnId())));
				}
				if(modell.getWalletStatus()!=null&&modell.getWalletStatus()!=""&&!modell.getWalletStatus().equals("%41")){
					if(modell.getWalletStatus().equalsIgnoreCase("success")){
						tx.add(Restrictions.eq("walletStatus", "505")).add(Restrictions.ne("txnType", "VOID"));
						tot.add(Restrictions.eq("walletStatus", "505")).add(Restrictions.ne("txnType", "VOID"));
					}else if(modell.getWalletStatus().equalsIgnoreCase("failed")){
						Set<String> list = new HashSet<String>();
						list.add("504");
						tx.add(Restrictions.in("walletStatus", list));
						tot.add(Restrictions.in("walletStatus", list));
					}else if(modell.getWalletStatus().equalsIgnoreCase("void")){
					      tx.add(Restrictions.eq("txnType", modell.getWalletStatus()));
					      tot.add(Restrictions.eq("txnType", modell.getWalletStatus()));
					}else{
					     tx.add(Restrictions.eq("walletStatus", modell.getWalletStatus()));
					     tot.add(Restrictions.eq("walletStatus", modell.getWalletStatus()));
				    }
				}
				if(modell.getWalletEmail()!=null&&modell.getWalletEmail()!=""&&!modell.getWalletEmail().equals("%41")){
					tx.add(Restrictions.like("walletEmail",modell.getWalletEmail()));
					tot.add(Restrictions.like("walletEmail",modell.getWalletEmail()));
				}
				SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				
				if(modell.getFromDateTime()!=null&&modell.getFromDateTime()!=""&&!modell.getFromDateTime().equals("%41")){
					if(modell.getToDateTime()!=null&&modell.getToDateTime()!=""&&modell.getToDateTime().length()==10&&!modell.getToDateTime().equals("%41")){	
						tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
						tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(sdfDestination.parse(modell.getToDateTime()))+" 23:59:59"));
					}else{
						tx.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
						tot.add(Restrictions.between("walletDateTime",sdfSource.format(sdfDestination.parse(modell.getFromDateTime()))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
					}
				}
				if(modell.getTxnType()!=null&&modell.getTxnType()!=""&&!modell.getTxnType().equals("%41")){
					if(modell.getTxnType().equalsIgnoreCase("card")|| modell.getTxnType().equalsIgnoreCase("cashatpos")||modell.getTxnType().equalsIgnoreCase("void")){
						tx.add(Restrictions.eq("txnType", modell.getTxnType()));
						tot.add(Restrictions.eq("txnType", modell.getTxnType()));
					}else{
				    	 tx.add(Restrictions.eq("txnType", modell.getTxnType()));
					     tot.add(Restrictions.eq("txnType", modell.getTxnType())); 			    	 
				    }
				}if(modell.getAccount()!=null&&modell.getAccount()!=""&&!modell.getAccount().equals("%41")){
					
				    	tx.add(Restrictions.eq("cardPanNo",modell.getAccount()));
				    	tot.add(Restrictions.eq("cardPanNo",modell.getAccount()));
				    
				}
				
				if(modell.getAmount()!=null&&modell.getAmount()!=""&&!modell.getAmount().equals("%41")){
					tx.add(Restrictions.eq("walletAmount",modell.getAmount()));
					tot.add(Restrictions.eq("walletAmount",modell.getAmount()));
				}
				List<Long> authCodeIds = new ArrayList<Long>();
			    List<AcqCardDetails> authcodeList = null;
				if(modell.getAuthcode()!=null&&modell.getAuthcode()!=""&&modell.getAuthcode()!="%41"){
					authcodeList = (List<AcqCardDetails>)session.createCriteria(AcqCardDetails.class).setProjection(Projections.property("transactionId")).add(Restrictions.eq("authCode", modell.getAuthcode())).list();
					Iterator etr1 = authcodeList.iterator();
					logger.info("Txn Ids fetched successfully"+modell.getAuthcode());
					while(etr1.hasNext()){
						authCodeIds.add(Long.parseLong(""+etr1.next()));					
					}
				}
				if(modell.getAuthcode()!=null&&modell.getAuthcode()!=""&&!modell.getAuthcode().equals("%41")){
					if(authCodeIds.isEmpty()){
					     logger.info("TxnIds Not found against authcode");
					     tx.add(Restrictions.eq("walletId", 0l));
					     tot.add(Restrictions.eq("walletId", 0l));
					 }else{
					     tx.add(Restrictions.in("walletId",authCodeIds));
						 tot.add(Restrictions.in("walletId",authCodeIds));
					 }					
				}
				tx.add(Restrictions.in("walletStatus",statusList));
				tx.addOrder(Order.desc("walletId"));
				/*tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
				tx.setMaxResults(20);*/
				List criteriaList = tx.list();
				Iterator etr1 = criteriaList.iterator();	
				Iterator etr = criteriaList.iterator();	
				Iterator<AcqWalletListEntity> itr2 = criteriaList.iterator();
				List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
				HashMap<String,String> singleMap=null;				
				Set<Long> orgset = new HashSet<Long>();
				Set<Long> userset = new HashSet<Long>();
				Set<Long> merchantSet = new HashSet<Long>();
				HashMap<String,String> orgmap = null;
				HashMap<String,String> usermap = null;
				HashMap<String,String> merchantMap = null;
				try{
					while(itr2.hasNext()){
						AcqWalletListEntity txEntity = (AcqWalletListEntity)itr2.next();
						orgset.add(txEntity.getOrgId());
						userset.add(txEntity.getUserId());
						merchantSet.add(Long.valueOf(txEntity.getMerchantId().toString()));
					}
				}catch(Exception e){
					logger.error("error iterate txn entity or add user/org id in set", e);
				}
				if(userset.isEmpty()||orgset.isEmpty()||merchantSet.isEmpty()){
				     logger.info("Org Name Users Name And Merchant Name Not Found");
				}else{
					try{
						Criteria org =session.createCriteria(AcqOrganization1.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("orgId"));
					     proList.add(Projections.property("name"));
					     org.setProjection(proList).add((Restrictions.in("orgId", orgset)));
					    List list1 = org.list();
					    orgmap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        orgmap.put("orgName"+ob[0],""+ob[1]);					      
					    }
					}catch(Exception e){
						logger.error("error to select organization "+e);
					}try{
						Criteria user =session.createCriteria(AcqUser.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("userId"));
					     proList.add(Projections.property("loginId"));
					     user.setProjection(proList);
					     user.add((Restrictions.in("userId", userset)));
					    List list1 = user.list();
					    usermap= new HashMap<String,String>();
					    for(Object obj:list1){
					        Object[] ob=(Object[])obj;
					        usermap.put("loginId"+ob[0],""+ob[1]); 
					    }
					}catch(Exception e){
						logger.error("error in select user in wallet report "+e);
					}try{
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
				}
				int i = 0;
				Set<Integer> transactionSet = new HashSet<Integer>();
				while(etr1.hasNext()){
					AcqWalletListEntity entit = (AcqWalletListEntity)etr1.next();
					transactionSet.add(Integer.valueOf(""+entit.getWalletId()));
				}
				if(transactionSet.isEmpty()){
				     logger.info("Transaction not found");
				     singleMap = new HashMap<String,String>();
				     singleMap.put("123", "133");
				     globalList.add(singleMap);
				     globleMap.setResult(globalList);
				     return globleMap;
				     
				    }else{
				List<AcqCardDetails> cardDetails = session.createCriteria(AcqCardDetails.class).add(Restrictions.in("transactionId", transactionSet)).list();
				Map<String,Map<String,String>> cardDetailMap = new HashMap<String,Map<String,String>>();
				Map<String,String> map = null;
				for(AcqCardDetails details:cardDetails){
					map = new HashMap<String,String>();
					map.put("cardHolderName",details.getCardHolderName());
					map.put("terminalId",details.getTerminalId());
					map.put("rrNo",details.getRrNo());
					map.put("batchNo",details.getBatchNo());
					map.put("authCode",details.getAuthCode());
					map.put("cardType",details.getCardType());
					map.put("imeiNo",details.getImeiNo());
					map.put("ipAddress",details.getIpAddress());
					map.put("latitude",details.getLatitude());
					map.put("longitude",details.getLongitude());	
					map.put("stan",details.getStan());					
					cardDetailMap.put(""+details.getTransactionId(),map);
				}
				logger.info("card details selected");
				while(etr.hasNext()){
					AcqWalletListEntity entit = (AcqWalletListEntity)etr.next();
					singleMap = new HashMap<String,String>();
				    singleMap.put("id",""+entit.getWalletId());
					singleMap.put("amount",""+entit.getWalletAmount());
					if(entit.getWalletStatus().equals("505")){
						singleMap.put("status","SUCCESS");
					}else {
						singleMap.put("status","FAILED");
					}
					if(entit.getWalletAmount().startsWith("-")&&entit.getWalletStatus().equals("505")){
						singleMap.put("status","VOID");
					}			
					SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				    singleMap.put("dateTime",""+sdfDestinationDb.format(sdfSourceDb.parse(entit.getWalletDateTime())));
				    singleMap.put("txnType",entit.getTxnType());
				    if(entit.getWalletMobileNo().equals("0000")){
				        singleMap.put("custPhone","NA");
				        singleMap.put("cardPanNo","NA");
				       }else{
				        singleMap.put("custPhone",entit.getWalletMobileNo());
				        singleMap.put("cardPanNo",entit.getWalletMobileNo());
				      }                      
				    	singleMap.put("mid",""+entit.getMerchantId());
				      	
				    	
				      if(merchantMap.get("merchantName"+entit.getMerchantId())==null||merchantMap.get("merchantName"+entit.getMerchantId())==""){
				    	  singleMap.put("merchantName", "Unknown");
				    	  singleMap.put("mid","0");
				      }else{
				    	  singleMap.put("mid",""+entit.getMerchantId());
				    	  singleMap.put("merchantName", ""+merchantMap.get("merchantName"+entit.getMerchantId()));
				      }
				      if(usermap.get("loginId"+entit.getUserId())==null||usermap.get("loginId"+entit.getUserId())==""){
				       singleMap.put("userName", "Unknown");
				      }else{
				       singleMap.put("userName", ""+usermap.get("loginId"+entit.getUserId()));
				      } 
				      if(orgmap.get("orgName"+entit.getOrgId())==null||orgmap.get("orgName"+entit.getOrgId())==""){
				       singleMap.put("orgName", "Unknown");
				      }else{
				       singleMap.put("orgName", ""+orgmap.get("orgName"+entit.getOrgId())); 
				      }     
				      if(entit.getWalletEmail()==null||entit.getWalletEmail()==""){
				       singleMap.put("custEmail","NA");
				      }else{
				      singleMap.put("custEmail",entit.getWalletEmail());
				      }
				    singleMap.put("statusDescription", entit.getStatusDescription());
				    singleMap.put("AcqMdr",""+entit.getWalletAcqMdr());
			        singleMap.put("bankMdr",""+entit.getWalletBankMdr());
				    if(entit.getPayoutStatus()==701&&entit.getWalletStatus().equals("505")){
				    	singleMap.put("payoutStatus", "Settled");
				    	singleMap.put("payoutDateTime", ""+sdfDestination.format(entit.getPayoutDateTime()));
				    }else if(entit.getPayoutStatus()==700&&entit.getWalletStatus().equals("505")){
				    	singleMap.put("payoutStatus", "OnHold");
				    	singleMap.put("payoutDateTime", "Payout on hold");
				    }else{
				    	singleMap.put("payoutStatus", "NA");
				    	singleMap.put("payoutDateTime", "NA");
				    }	
				    if(entit.getCardPanNo().equals("0000")||entit.getCardPanNo().equals("0")) {
			            singleMap.put("cardPanNo","NA"); 
			        }else{
			         singleMap.put("cardPanNo",entit.getCardPanNo()); 
			        }
				    if(cardDetailMap.containsKey(""+entit.getWalletId())){
				    	Map<String,String> cardDetail = cardDetailMap.get(""+entit.getWalletId());
				    	singleMap.put("cardHolderName",cardDetail.get("cardHolderName"));
				    	
				    	singleMap.put("terminalId",cardDetail.get("terminalId"));
				    	
				    	if(cardDetail.get("rrNo")==null||cardDetail.get("rrNo")==""){
				    		singleMap.put("rrNo","");
				    	}else{
				    		if(cardDetail.get("rrNo").startsWith("-")){
					    		singleMap.put("rrNo",cardDetail.get("rrNo").substring(1));
					    	}else{
					    		singleMap.put("rrNo",cardDetail.get("rrNo"));
					    	}				    		
				    	}		    								    	
				    	singleMap.put("batchNo",cardDetail.get("batchNo"));
				    	singleMap.put("authCode",cardDetail.get("authCode"));
				    	singleMap.put("issuerAuthCode","");
				    	singleMap.put("cardExpDate","");
				    	singleMap.put("cardType",cardDetail.get("cardType"));
				    	singleMap.put("referenceNo","");
				    	singleMap.put("imeiNo",cardDetail.get("imeiNo"));
				    	singleMap.put("ipAddress",cardDetail.get("ipAddress"));				    	
				    	singleMap.put("latitude",cardDetail.get("latitude"));
				    	singleMap.put("longitude",cardDetail.get("longitude"));	
				    	singleMap.put("stan",cardDetail.get("stan"));
				    	
				    }
				    globalList.add(singleMap);
				}
				    }
				logger.info("records are putted in map:::");
				Long rows = (Long) tot.uniqueResult();
				Long totalRows= rows/20;
				Long modlus = rows%20;
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
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("wallet list selected successfully");
				return globleMap;			
			}catch(Exception e){
				logger.info("error to select wallet list"+e);
				return null;
			}
		}
}
