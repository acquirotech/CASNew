package com.acq.users.dao;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.acq.AcqBase;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.users.entity.AcqAddNewMerchantEntity;
import com.acq.users.entity.AcqDsaEntity;
import com.acq.users.entity.AcqEmpRoleEntity;
import com.acq.users.entity.AcqLoanDetails;
import com.acq.users.entity.AcqSettingEntity;
import com.acq.users.entity.AcqTransactionListEntity;
import com.acq.users.entity.AcqWalletListEntity;
import com.acq.users.entity.PreBoardNewMerchantEntity;
import com.acq.users.model.AcqAppUser;
import com.acq.users.model.AcqDeviceMapUser;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization;
import com.acq.users.model.AcqOrganization1;
import com.acq.users.model.AcqUser;
import com.acq.users.model.Users;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.impl.DbDto;

@Repository
public class AcqMerchantDaoImpl implements UserDaoInf{

	SessionFactory sessionFactory;
	
	@Autowired
    ServletContext context;
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	final static Logger logger = Logger.getLogger(AcqMerchantDaoImpl.class);	

	
	@Override
	public void getMe(){		
	}
	
	public Session getSession(){
		ApplicationContext appContext = AcqBase.getAppContext();
		AcqMerchantDaoImpl stockBo = (AcqMerchantDaoImpl)appContext.getBean("merchantDao");
		return stockBo.getSessionFactory().openSession();
	}
	@Override
	public DbDto<Map> PreBoardedmerchantdetails(String merchantId, String emp){
		DbDto<Map> response = new DbDto<Map>();
		HashMap<String,HashMap<String,String>> globalMap = new  HashMap<String,HashMap<String,String>>();	
		try{
			Session session = getSession();
		PreBoardNewMerchantEntity merchant = (PreBoardNewMerchantEntity) session.createCriteria(PreBoardNewMerchantEntity.class).add(Restrictions.eq("id", Integer.parseInt(merchantId))).uniqueResult();
			logger.info("merchant selected");
			Map<String,String> merchantDetails = new HashMap<String, String>();
			if(merchant==null||merchant+""==""){
				logger.info("No records fetch");
				return null;
			}else{
				AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",emp)).uniqueResult();    
				Criteria tx= session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("empRole", "5"));				
					List list = tx.list();
					Iterator etr = list.iterator();	
					HashMap<String,String> merchantMap=null;
					int k=1;
					while(etr.hasNext()){
						merchantMap = new HashMap<String, String>();
						AcqEmpRoleEntity txEntity = (AcqEmpRoleEntity)etr.next();
						merchantMap.put("executiveEmail",""+txEntity.getEmailId()); 
						merchantMap.put("executiveName",""+txEntity.getName()); 
						merchantMap.put("executiveId",""+txEntity.getId());
						globalMap.put(""+k,merchantMap);
					}
					k++;
					/*if(merchant.getSalesType().equals("2")){
				Criteria tx1= session.createCriteria(AcqDsaEntity.class);				
						List list1 = tx1.list();
						Iterator etr1 = list1.iterator();	
						HashMap<String,String> merchantMapDsa=null;
						int j=1;
						while(etr1.hasNext()){
							merchantMap = new HashMap<String, String>();
							AcqDsaEntity txEntity = (AcqDsaEntity)etr.next();
							merchantMapDsa.put("dsaId",""+txEntity.getId()); 
							merchantMapDsa.put("dsaName",""+txEntity.getName()); 
							globalMap.put(""+j,merchantMapDsa);
						}
						j++;
					}*/
				response.setResult(globalMap);	
				merchantDetails.put("kycCheck", merchant.getKycCheck());
				merchantDetails.put("salesType", merchant.getSalesType());
				merchantDetails.put("merchantId", ""+merchant.getId());
				merchantDetails.put("merchantName", merchant.getMerchantName());
				merchantDetails.put("marketingName", merchant.getMarketingName());
				merchantDetails.put("location", merchant.getLocation());
				if(merchant.getExecutiveName()!=null&&merchant.getExecutiveName()!=""&&!merchant.getExecutiveName().equals("NA")){
					merchantDetails.put("executiveName", merchant.getExecutiveName());
				}else{
					merchantDetails.put("executiveName", "");
				}
				merchantDetails.put("salesType", merchant.getSalesType());
				merchantDetails.put("employeeName", merchant.getEmployeeName());
				merchantDetails.put("verificationStatus", merchant.getStatus());
				merchantDetails.put("phoneNo", merchant.getPhoneNo());
				merchantDetails.put("amount", ""+merchant.getAmount());
				merchantDetails.put("chequeNo", merchant.getChequeNo());
				merchantDetails.put("createdOn", merchant.getCreated_on());
				merchantDetails.put("note", merchant.getNote());
				merchantDetails.put("empRole", emp1.getEmpRole());
				merchantDetails.put("cubBranch", merchant.getCubBranch());
				merchantDetails.put("nachNo", merchant.getNashNumber());
				merchantDetails.put("nachBank", merchant.getNashBankNAme());
				merchantDetails.put("nashDate", merchant.getNachDate());
			System.out.println("pre boarded merchant details is populated........");				
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(merchantDetails);
			logger.info("final return");
			return response;
		}
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in pre boarded MerchantDetails : "+e);
			return null;
		}
	}
	

	@Transactional
	public DbDto<List<HashMap<String, String>>> PreBoardedMerchantlist(AcqSearchModel modell) {
		logger.info("request in pre board merchant list dao");
		DbDto<List<HashMap<String, String>>> response = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> merchantList = new ArrayList<HashMap<String,String>>();	
		try{
			Session session = getSession();
		Criteria tx=session.createCriteria(PreBoardNewMerchantEntity.class);
		Criteria tot=session.createCriteria(PreBoardNewMerchantEntity.class);		
		if(modell.getUserId().equals("5")&&modell.getWalletEmail()!=null){
			logger.info("executive role is executed");
			tx.add(Restrictions.eq("executiveName",modell.getWalletEmail()));
			tot.add(Restrictions.eq("executiveName",modell.getWalletEmail()));
		}
		if(modell.getModelName()!=null && modell.getModelName()!="" && modell.getModelName()!="%41"&&!modell.getModelName().equals("%41")){
			tx.add(Restrictions.like("executiveName","%"+modell.getModelName()+"%"));
			tot.add(Restrictions.like("executiveName","%"+modell.getModelName()+"%"));
		}if(modell.getMerchantName()!=null&&modell.getMerchantName()!="" && modell.getMerchantName()!="%41"&&!modell.getMerchantName().equals("%41")){
			tx.add(Restrictions.like("merchantName","%"+modell.getMerchantName()+"%"));
			tot.add(Restrictions.like("merchantName","%"+modell.getMerchantName()+"%"));
		}
		if(modell.getMarketingName()!=null&&modell.getMarketingName()!="" && modell.getMarketingName()!="%41"&&!modell.getMarketingName().equals("%41")){
			tx.add(Restrictions.like("marketingName","%"+modell.getMarketingName()+"%"));
			tot.add(Restrictions.like("marketingName","%"+modell.getMarketingName()+"%"));
		}
		if(modell.getVerificationstatus()!=null&&modell.getVerificationstatus()!="" && modell.getVerificationstatus()!="%41"&&!modell.getVerificationstatus().equals("%41")){
			tx.add(Restrictions.like("status","%"+modell.getVerificationstatus()+"%"));
			tot.add(Restrictions.like("status","%"+modell.getVerificationstatus()+"%"));
		}
		tx.addOrder(Order.desc("id"));
		tot.setProjection(Projections.rowCount());
		tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 10);
		tx.setMaxResults(10);
		List criteriaList = tx.list();
		AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",modell.getWalletEmail())).uniqueResult();
		
		HashMap<String,String> merchantMap=null;
		try{
			Long rows = (Long) tot.uniqueResult();
			Long totalRows= rows/10;
			Long modlus = rows%10;
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
			merchantList.add(0,rowsMap);
			Iterator<PreBoardNewMerchantEntity> itr2 = criteriaList.iterator();
			while(itr2.hasNext()){
				PreBoardNewMerchantEntity txEntity = (PreBoardNewMerchantEntity)itr2.next();
				merchantMap = new HashMap<String,String>();
				merchantMap.put("applicationNo",""+txEntity.getId());
		        merchantMap.put("merchantName",""+txEntity.getMerchantName());
		        merchantMap.put("marketingName",""+txEntity.getMarketingName());
		        merchantMap.put("location",txEntity.getLocation());
		        merchantMap.put("executiveName",txEntity.getExecutiveName());
		        merchantMap.put("phoneNo",txEntity.getPhoneNo());
		        merchantMap.put("aquirerCode",txEntity.getAquirerCode());
		        merchantMap.put("empRole",emp1.getEmpRole());
		        if(txEntity.getStatus().equalsIgnoreCase("oktoboard")){
		        	merchantMap.put("varificationStatus","Ok To Board");
		        }else{
		        	merchantMap.put("varificationStatus",txEntity.getStatus());
		        }
		        merchantList.add(merchantMap);
			}
		}catch(Exception e){
			logger.info("Error to generate map and pre boarding list "+e);
		}
		logger.info("pre boarding merchant list successfully selected");
		}catch(Exception e){
			logger.info("Error to create hibernate session: "+e);
		}
		response.setStatus(AcqStatusDefination.OK.getIdentifier());
		response.setMessage(AcqStatusDefination.OK.getDetails());
		response.setResult(merchantList);
		return response;
	}
	
	@Override
	public DbDto<HashMap<String,String>> getSuperAdminDetails(String email,String admnres) {
		logger.info("request for super merchant details in dao");
		DbDto<HashMap<String,String>> response = new DbDto<HashMap<String,String>>();
		HashMap<String,String> responseMap = new HashMap<String,String>();
		Long totalNoOfMerchant=0l;
		Long todayNoOfMerchant=0l;
		Long monthlyNoOfMerchant=0l;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		try{
			Session session = getSession();
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.DAY_OF_MONTH, 1);
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(new Date());
			Date dateBefore1Days = cal2.getTime();
			Date dateBefore30Days = cal.getTime();
			String fromDateBefore1Days = sdf.format(dateBefore1Days)+" 23:59:59";
		    String toDateBefore30Days = sdf.format(dateBefore30Days)+" 00:00:01";
			if(admnres.equals("merchantBoarded")){
				totalNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).uniqueResult();
				todayNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.eq("dateCreated", sdf.format(new Date()))).uniqueResult();
				monthlyNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.between("dateCreated", toDateBefore30Days,fromDateBefore1Days)).uniqueResult();
				if(totalNoOfMerchant==null){
					logger.warn("merchant not found");
					response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					response.setResult(responseMap);
					return response;
				}
				responseMap.put("todayNoOfMerchant",""+todayNoOfMerchant);
				responseMap.put("monthlyNoOfMerchant",""+monthlyNoOfMerchant);
				responseMap.put("totalNoOfMerchant",""+totalNoOfMerchant);
				logger.info("merchant details selected");
			}if(admnres.equals("todayActivities")){
				Criteria entity = (Criteria) session.createCriteria(AcqWalletListEntity.class).add(Restrictions.between("walletDateTime", (sdf.format(new Date())+" 00:00:01"), (sdf.format(new Date())+" 23:59:59"))).add(Restrictions.eq("walletStatus","505"));
				List txList = entity.list();
				if(txList.isEmpty()){
					responseMap.put("todayTxnCount", "0");
					responseMap.put("todaySales", "0");
					responseMap.put("todayMdr", "0");
					responseMap.put("todayCommission", "0");
					logger.info("today's report is empty");
				}else{
					Iterator<AcqWalletListEntity> itrMain = txList.iterator();
					Long totalNoTxn = 0l;
					Double totalAmount = 0.0;
					Double totalMdr=0.0;
					Double acquiroShare = 0.0;	
					Long totalNoSuccessTxn1= 0l;
					Long totalNoTxnVoid1= 0l;
					try{
						while(itrMain.hasNext()){
							AcqWalletListEntity ent = (AcqWalletListEntity)itrMain.next();	
							Double mdrCharged = Double.parseDouble(ent.getWalletAmount())*Double.parseDouble(ent.getWalletAcqMdr())/100;
							totalMdr=totalMdr+mdrCharged;
							Double bankMdrCharged= Double.valueOf(ent.getWalletAmount())*Double.valueOf(ent.getWalletBankMdr())/100;
							Double bankServiceTax= Double.parseDouble(ent.getServiceTax())*bankMdrCharged/100;
							Double bankShare=  bankMdrCharged+bankServiceTax;
							Double servicetax = Double.parseDouble(ent.getServiceTax())*mdrCharged/100;
							Double totalDeduction=mdrCharged+servicetax;
							acquiroShare = acquiroShare+(totalDeduction-bankShare);
							totalAmount = totalAmount+Double.valueOf(ent.getWalletAmount());
							if(ent.getTxnType().equalsIgnoreCase("void")||ent.getTxnType().equalsIgnoreCase("cvoid")||ent.getTxnType().equalsIgnoreCase("cashvoid")){
								totalNoTxnVoid1 = totalNoTxnVoid1+1;
							}else{
								totalNoSuccessTxn1 = totalNoSuccessTxn1+1;
							}
						}
						totalNoTxn = totalNoSuccessTxn1 - totalNoTxnVoid1;
						responseMap.put("todayTxnCount", ""+totalNoTxn);
						responseMap.put("todaySales", ""+new DecimalFormat("#.###").format(totalAmount));
						responseMap.put("todayMdr", ""+new DecimalFormat("#.###").format(totalMdr));
						responseMap.put("todayCommission", ""+new DecimalFormat("#.###").format(acquiroShare));						
					}catch(NumberFormatException fx){
						logger.error("error to parse txn records "+fx);
					}catch(Exception e){
						logger.error("error to iterate txn records "+e);
					}
				}
				logger.info("merchant today's details selected");
			}if(admnres.equals("monthlyActivities")){
		    	try{		
					Criteria entity1 = (Criteria) session.createCriteria(AcqWalletListEntity.class).add(Restrictions.between("walletDateTime",toDateBefore30Days,fromDateBefore1Days)).add(Restrictions.eq("walletStatus","505"));
					List txList1 = entity1.list();
					if(txList1.isEmpty()){
						responseMap.put("totalNoTxn1","0.0");
						responseMap.put("totalAmount1","0.0");
						responseMap.put("totalMdr1","0.0");
						responseMap.put("acquiroShare1","0.0");
						responseMap.put("gmv","0.0");
						logger.info("monthly report is empty");
					}else{
						Iterator<AcqWalletListEntity> itrMain1 = txList1.iterator();					
						Long totalNoTxn1= 0l;
						Double totalAmount1 = 0.0;
						Double totalMdr1=0.0;
						Double acquiroShare1 = 0.0;
						Long totalNoSuccessTxn1= 0l;
					    Long totalNoTxnVoid1= 0l;
						try{
							while(itrMain1.hasNext()){
								AcqWalletListEntity ent = (AcqWalletListEntity)itrMain1.next();
								Double mdrCharged1 = Double.parseDouble(ent.getWalletAmount())*Double.parseDouble(ent.getWalletAcqMdr())/100;
								totalMdr1=totalMdr1+mdrCharged1;
								Double bankMdrCharged1= Double.valueOf(ent.getWalletAmount())*Double.valueOf(ent.getWalletBankMdr())/100;
								Double bankServiceTax1= Double.parseDouble(ent.getServiceTax())*bankMdrCharged1/100;
								Double bankShare1=  bankMdrCharged1+bankServiceTax1;
								Double servicetax1 = Double.parseDouble(ent.getServiceTax())*mdrCharged1/100;
								Double totalDeduction1=mdrCharged1+servicetax1;
								acquiroShare1 = acquiroShare1+(totalDeduction1-bankShare1);
								//totalNoTxn1 = totalNoTxn1+1;
								totalAmount1 = totalAmount1+Double.valueOf(ent.getWalletAmount());
								if(ent.getTxnType().equalsIgnoreCase("void")||ent.getTxnType().equalsIgnoreCase("cvoid")||ent.getTxnType().equalsIgnoreCase("cashvoid")){
							        totalNoTxnVoid1 = totalNoTxnVoid1+1;
							    }else{
							        totalNoSuccessTxn1 = totalNoSuccessTxn1+1;
							    }
							}
							totalNoTxn1 = totalNoSuccessTxn1 - totalNoTxnVoid1;
						}catch(NumberFormatException fx){
							logger.error("error to parse totalAmount "+fx);
						}catch(Exception e){
						    logger.error("error to iterate txn records "+e);
						}
						responseMap.put("totalNoTxn1",""+totalNoTxn1);
						responseMap.put("totalAmount1",""+new DecimalFormat("#.###").format(totalAmount1));
						responseMap.put("totalMdr1",""+new DecimalFormat("#.###").format(totalMdr1));
						responseMap.put("acquiroShare1",""+new DecimalFormat("#.###").format(acquiroShare1));
						Double gmv = totalAmount1/totalNoTxn1;
						responseMap.put("gmv",""+new DecimalFormat("#.###").format(gmv));
					}
					logger.info("monthly report is generated");
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					response.setResult(responseMap);
					logger.info("merchant monthly details selected");
		    	}catch(Exception e){
		    		response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		    		response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		    		logger.error("Error in fetch merchant monthly details "+e);
		    		return response;
		    	}
		    	logger.info("merchant monthly details selected");
		    }
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(responseMap);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in super merchant details "+e);
			return response;
		}
		return response;
	}
	
	@Override
	public DbDto<Object> getDetails(){
		DbDto<Object> response = new DbDto<Object>();
		Map<String,String> responseMap = new HashMap<String,String>();
		Long totalNoOfMerchant=0l;
		Long todayNoOfMerchant=0l;
		Long monthlyNoOfMerchant=0l;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try{
			Session session = getSession();
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.DAY_OF_MONTH, 1);
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(new Date());
			Date dateBefore1Days = cal2.getTime();
			Date dateBefore30Days = cal.getTime();
			String fromDateBefore1Days = sdf.format(dateBefore1Days)+" 23:59:59";
		    String toDateBefore30Days = sdf.format(dateBefore30Days)+" 00:00:01";				
			totalNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).uniqueResult();
			todayNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.eq("dateCreated", sdf.format(new Date()))).uniqueResult();
			monthlyNoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.between("dateCreated", toDateBefore30Days,fromDateBefore1Days)).uniqueResult();
			if(totalNoOfMerchant==null){
				logger.warn("merchant not found");
				response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				response.setResult(responseMap);
				return response;
			}
			responseMap.put("todayNoOfMerchant",""+todayNoOfMerchant);
			responseMap.put("monthlyNoOfMerchant",""+monthlyNoOfMerchant);
			responseMap.put("totalNoOfMerchant",""+totalNoOfMerchant);
			logger.info("merchant count selected");
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(responseMap);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to create hibernate session:"+e);
			return response;
		}
		return response;
	}
	
	@Override
	public DbDto<List<String>> getHomePageReport(String email){
		DbDto<List<String>> response = new DbDto<List<String>>();	
		List<String> globalList = new ArrayList<String>();
		Users userinfo = null;
		try{
			Session session = getSession();
			userinfo = (Users)session.createCriteria(Users.class).add(Restrictions.eq("username",email)).uniqueResult();
			if(userinfo==null){
				logger.warn("user not found");
				response.setResult(globalList);
				return response;
			}
			globalList.add(0,userinfo.getEmpName());
			globalList.add(1,userinfo.getEmpRole());
			globalList.add(2,userinfo.getLastUpdatedOn());
			response.setResult(globalList);
		}catch(Exception e){
			logger.error("Error to create hibernate session:"+e);
			return response;
		}
		return response;
	}

	public DbDto<List<String>> getAdminPageReport(String email){
		DbDto<List<String>> global = new DbDto<List<String>>();	
		List<String> globalList = new ArrayList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Users userinfo = null;
		try{
			Session session = getSession();
			Long noOfMerchant=0l;
			Long totalnoOfMerchant=(long) 01;
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.DAY_OF_MONTH, 1);
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(new Date());
			Date dateBefore1Days = cal2.getTime();
			Date dateBefore30Days = cal.getTime();
			String fromDateBefore1Days = sdf.format(dateBefore1Days)+" 23:59:59";
		    String toDateBefore30Days = sdf.format(dateBefore30Days)+" 00:00:01";	
			String monthlyFromDate = toDateBefore30Days;
			String monthlyToDate = sdf.format(new Date())+" 00:00:01";
			if(email.equals("admin@acquiropayments.com")){
			// today's report started
				try{
				String toDayFromDate = sdf.format(new Date())+" 00:00:01";
				String toDayToDate = sdf.format(new Date())+" 23:59:59";
				String toDaydate = sdf.format(new Date());
				Criteria entity = (Criteria) session.createCriteria(AcqWalletListEntity.class).add(Restrictions.between("walletDateTime", toDayFromDate, toDayToDate)).add(Restrictions.eq("walletStatus","505"));
				List txList = entity.list();
				if(txList.isEmpty()){
					 globalList.add(0,"0.0");
					 globalList.add(1,"0.0");
					 globalList.add(2,"0.0");
					 globalList.add(3,"0.0");
					 logger.info("today's report is empty");
				}else{
					Iterator<AcqWalletListEntity> itrMain = txList.iterator();
					Long totalNoTxn = 0l;
					Double totalAmount = 0.0;
					Double totalMdr=0.0;
					Double acquiroShare = 0.0;	
					Long totalNoSuccessTxn1= 0l;
					Long totalNoTxnVoid1= 0l;
					try{
						while(itrMain.hasNext()){
							AcqWalletListEntity ent = (AcqWalletListEntity)itrMain.next();	
							Double mdrCharged = Double.parseDouble(ent.getWalletAmount())*Double.parseDouble(ent.getWalletAcqMdr())/100;
							totalMdr=totalMdr+mdrCharged;
							Double bankMdrCharged= Double.valueOf(ent.getWalletAmount())*Double.valueOf(ent.getWalletBankMdr())/100;
							Double bankServiceTax= Double.parseDouble(ent.getServiceTax())*bankMdrCharged/100;
							Double bankShare=  bankMdrCharged+bankServiceTax;
							Double servicetax = Double.parseDouble(ent.getServiceTax())*mdrCharged/100;
							Double totalDeduction=mdrCharged+servicetax;
							acquiroShare = acquiroShare+(totalDeduction-bankShare);
							totalAmount = totalAmount+Double.valueOf(ent.getWalletAmount());
							if(ent.getTxnType().equalsIgnoreCase("void")||ent.getTxnType().equalsIgnoreCase("cvoid")||ent.getTxnType().equalsIgnoreCase("cashvoid")){
								totalNoTxnVoid1 = totalNoTxnVoid1+1;
							}else{
								totalNoSuccessTxn1 = totalNoSuccessTxn1+1;
							}
						}
						totalNoTxn = totalNoSuccessTxn1 - totalNoTxnVoid1;
						globalList.add(0,""+totalNoTxn);
						globalList.add(1,""+new DecimalFormat("#.###").format(totalAmount));
						globalList.add(2,""+new DecimalFormat("#.###").format(totalMdr));
						globalList.add(3,""+new DecimalFormat("#.###").format(acquiroShare));				
					}catch(NumberFormatException fx){
						logger.error("error to parse txn records "+fx);
					}catch(Exception e){
						logger.error("error to iterate txn records "+e);
					}
				}
				Long todaynoOfMerchant=0l;
				try{
					todaynoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.eq("dateCreated", toDaydate)).uniqueResult();
				}catch(Exception e){
					logger.error("error to count today merchant "+e);
				}
				globalList.add(4,""+todaynoOfMerchant);
				logger.info("today's repport generated");
			}catch (Exception e) {
				logger.error("error in today's report"+e);
			}
			// monthly report stared
			try{										
				Criteria entity1 = (Criteria) session.createCriteria(AcqWalletListEntity.class).add(Restrictions.between("walletDateTime",toDateBefore30Days,fromDateBefore1Days)).add(Restrictions.eq("walletStatus","505"));
				List txList1 = entity1.list();
				if(txList1.isEmpty()){
					globalList.add(5,"0.0");
					globalList.add(6,"0.0");
					globalList.add(7,"0.0");
					globalList.add(8,"0.0");
					globalList.add(9,"0.0");
					logger.info("monthly report is empty");
				}else{
					Iterator<AcqWalletListEntity> itrMain1 = txList1.iterator();					
					Long totalNoTxn1= 0l;
					Double totalAmount1 = 0.0;
					Double totalMdr1=0.0;
					Double acquiroShare1 = 0.0;
					Long totalNoSuccessTxn1= 0l;
				    Long totalNoTxnVoid1= 0l;
					try{
						while(itrMain1.hasNext()){
							AcqWalletListEntity ent = (AcqWalletListEntity)itrMain1.next();
							Double mdrCharged1 = Double.parseDouble(ent.getWalletAmount())*Double.parseDouble(ent.getWalletAcqMdr())/100;
							totalMdr1=totalMdr1+mdrCharged1;
							Double bankMdrCharged1= Double.valueOf(ent.getWalletAmount())*Double.valueOf(ent.getWalletBankMdr())/100;
							Double bankServiceTax1= Double.parseDouble(ent.getServiceTax())*bankMdrCharged1/100;
							Double bankShare1=  bankMdrCharged1+bankServiceTax1;
							Double servicetax1 = Double.parseDouble(ent.getServiceTax())*mdrCharged1/100;
							Double totalDeduction1=mdrCharged1+servicetax1;
							acquiroShare1 = acquiroShare1+(totalDeduction1-bankShare1);
							totalAmount1 = totalAmount1+Double.valueOf(ent.getWalletAmount());
							if(ent.getTxnType().equalsIgnoreCase("void")||ent.getTxnType().equalsIgnoreCase("cvoid")||ent.getTxnType().equalsIgnoreCase("cashvoid")){
						        totalNoTxnVoid1 = totalNoTxnVoid1+1;
						    }else{
						        totalNoSuccessTxn1 = totalNoSuccessTxn1+1;
						    }
						}
						totalNoTxn1 = totalNoSuccessTxn1 - totalNoTxnVoid1;
					}catch(NumberFormatException fx){
						logger.error("error to parse totalAmount "+fx);
					}catch(Exception e){
					    logger.error("error to iterate txn records "+e);
					}
					globalList.add(5,""+totalNoTxn1);
				    globalList.add(6,""+new DecimalFormat("#.###").format(totalAmount1));
					globalList.add(7,""+new DecimalFormat("#.###").format(totalMdr1));
					globalList.add(8,""+new DecimalFormat("#.###").format(acquiroShare1));
					Double gmv = totalAmount1/totalNoTxn1;
					globalList.add(9,""+new DecimalFormat("#.###").format(gmv));			
				}
				try{
					noOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.between("dateCreated", monthlyFromDate,monthlyToDate)).uniqueResult();
					totalnoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).uniqueResult();
				}catch(Exception e){
					logger.error("Error to count monthly merchant "+e);
				}
				globalList.add(10,""+noOfMerchant);
				globalList.add(11,""+totalnoOfMerchant);
				userinfo = (Users)session.createCriteria(Users.class).add(Restrictions.eq("username",email)).uniqueResult();
				globalList.add(12,userinfo.getEmpName());
				globalList.add(13,userinfo.getEmpRole());
				globalList.add(14,userinfo.getLastUpdatedOn());
				global.setResult(globalList);
				logger.info("Employee role fetched successfully");
				}catch(Exception e){
					logger.error("Error in monthly report"+e);
				}
			}else{
				try{
					noOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).add(Restrictions.between("dateCreated", monthlyFromDate,monthlyToDate)).uniqueResult();
					totalnoOfMerchant = (Long)session.createCriteria(AcqMerchant.class).setProjection(Projections.count("merchantId")).uniqueResult();
				}catch(Exception e){
					logger.error("Error to count monthly merchant "+e);
				}
				 globalList.add(0,"0.0");
				 globalList.add(1,"0.0");
				 globalList.add(2,"0.0");
				 globalList.add(3,"0.0");
				 globalList.add(4,"0.0");
				 globalList.add(5,"0.0");
				 globalList.add(6,"0.0");
				 globalList.add(7,"0.0");
				 globalList.add(8,"0.0");
				 globalList.add(9,"0.0");
				 globalList.add(10,""+noOfMerchant);
				 globalList.add(11,""+totalnoOfMerchant);
				 userinfo = (Users)session.createCriteria(Users.class).add(Restrictions.eq("username",email)).uniqueResult();
				 globalList.add(12,userinfo.getEmpName());
				 globalList.add(13,userinfo.getEmpRole());
				 globalList.add(14,userinfo.getLastUpdatedOn());
				 global.setResult(globalList);
			}
		}catch(NumberFormatException nfe){
			logger.error("Error to get string "+nfe);
		}catch(Exception e){
			logger.error("Error to create hibernate session:"+e);
			return global;
		}
		return global;
	}
	

	
	

	@Override
	public DbDto<List<HashMap<String, String>>> getMerchantList(AcqSearchModel modell) {
		DbDto<List<HashMap<String, String>>> response = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> merchantList = new ArrayList<HashMap<String,String>>();	
		try{
			Session s = getSession();
		Set<String> empSet = new HashSet<String>();
		ProjectionList pList=Projections.projectionList();
		pList.add(Projections.property("merchantId"));
		pList.add(Projections.property("merchantName"));
		pList.add(Projections.property("directorsName"));			
		pList.add(Projections.property("marketingName"));
		pList.add(Projections.property("businessAddress1"));
		pList.add(Projections.property("businessAddress2"));
		pList.add(Projections.property("businessState"));
		pList.add(Projections.property("businessCity"));
		pList.add(Projections.property("businessPincode"));			
		pList.add(Projections.property("country"));
		pList.add(Projections.property("phoneNo"));
		pList.add(Projections.property("emailId"));
		pList.add(Projections.property("tinNo"));
		pList.add(Projections.property("serviceTaxNo"));
		pList.add(Projections.property("bankMid"));
		pList.add(Projections.property("verificationStatus"));
		pList.add(Projections.property("dateCreated"));
		Criteria tx=s.createCriteria(AcqAddNewMerchantEntity.class).setProjection(pList);
		tx.addOrder(Order.desc("merchantId"));
		Criteria tot=s.createCriteria(AcqAddNewMerchantEntity.class);
		tot.setProjection(Projections.rowCount());
		if(modell.getEmpId().equalsIgnoreCase("10")){
			tx.add(Restrictions.eq("cubMerchant","1"));
			tot.add(Restrictions.eq("cubMerchant","1"));
		}
		if(modell.getBankMid()!=null&&modell.getBankMid()!=""&& modell.getBankMid()!="%41"&&!modell.getBankMid().equals("%41")){
				tx.add(Restrictions.eq("bankMid",modell.getBankMid()));
			tot.add(Restrictions.eq("bankMid",modell.getBankMid()));
		}
		if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&& modell.getMerchantName()!="%41"&&!modell.getMerchantName().equals("%41")){
			tx.add(Restrictions.like("merchantName","%"+modell.getMerchantName()+"%"));
			tot.add(Restrictions.like("merchantName","%"+modell.getMerchantName()+"%"));
		}
		if(modell.getMarketingName()!=null&&modell.getMarketingName()!=""&& modell.getMarketingName()!="%41"&&!modell.getMarketingName().equals("%41")){
			tx.add(Restrictions.like("marketingName","%"+modell.getMarketingName()+"%"));
			tot.add(Restrictions.like("marketingName","%"+modell.getMarketingName()+"%"));
		}
		if(modell.getApplicationNo()!=null&&modell.getApplicationNo()!=""&& modell.getApplicationNo()!="%41"&&!modell.getApplicationNo().equals("%41")){
			tx.add(Restrictions.eq("merchantId",Long.valueOf(modell.getApplicationNo())));
			tot.add(Restrictions.eq("merchantId",Long.valueOf(modell.getApplicationNo())));
		}
		if(modell.getVerificationstatus()!=null&&modell.getVerificationstatus()!=""&& modell.getVerificationstatus()!="%41"&&!modell.getVerificationstatus().equals("%41")){
			tx.add(Restrictions.eq("verificationStatus",modell.getVerificationstatus()));
			tot.add(Restrictions.eq("verificationStatus",modell.getVerificationstatus()));
		}
		if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""&& modell.getCustPhone()!="%41"&&!modell.getCustPhone().equals("%41")){
			tx.add(Restrictions.like("phoneNo","%"+modell.getCustPhone()+"%"));
			tot.add(Restrictions.like("phoneNo","%"+modell.getCustPhone()+"%"));
		}
		
		if(modell.getCity()!=null && modell.getCity()!="" && modell.getCity()!="%41"&&!modell.getCity().equals("%41")){
			tx.add(Restrictions.like("businessCity","%"+modell.getCity()+"%"));
			tot.add(Restrictions.like("businessCity","%"+modell.getCity()+"%"));
		}
		if(modell.getState()!=null && modell.getState()!="" && modell.getState() !="%41"&&!modell.getState().equals("%41")){
			tx.add(Restrictions.like("businessState","%"+modell.getState()+"%"));
			tot.add(Restrictions.like("businessState","%"+modell.getState()+"%"));
		}
		if(modell.getModelName()!=null && modell.getModelName()!="" && modell.getModelName()!="%41"&&!modell.getModelName().equals("%41")){   
				List<AcqEmpRoleEntity> empList = (List )s.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.like("name","%"+modell.getModelName()+"%")).add(Restrictions.eq("empRole","5")).list();   
					for(AcqEmpRoleEntity ent : empList){    
						empSet.add(""+ent.getEmailId());    
					}
			if(empSet.isEmpty()){
				tx.add(Restrictions.eq("executiveName","sd2"));  
				tot.add(Restrictions.eq("executiveName","sd2")); 
			}else{
				tx.add(Restrictions.in("executiveName",empSet));  
				tot.add(Restrictions.in("executiveName",empSet)); 
			}			 
		}
		
		
		if(modell.getDateTime()!=null&&modell.getDateTime()!=""&&modell.getDateTime()!="%41"&&!modell.getDateTime().equals("%41")){
			SimpleDateFormat sdfSource1 = new SimpleDateFormat("dd/MM/yyyy");
			Date fdate1 =sdfSource1.parse(modell.getDateTime());
			SimpleDateFormat sdfDestination1 = new SimpleDateFormat("yyyy-MM-dd");
			String newFromDate2 = sdfDestination1.format(fdate1);
			tx.add(Restrictions.eq("dateCreated",newFromDate2));
			tot.add(Restrictions.eq("dateCreated",newFromDate2));
		}
		SimpleDateFormat sdfSource1 = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdfDestination1 = new SimpleDateFormat("yyyy-MM-dd");
		if(modell.getFromDateTime()!=null && modell.getFromDateTime()!="" && modell.getFromDateTime()!="%41"&&!modell.getFromDateTime().equals("%41")&&modell.getToDateTime()!=null && modell.getToDateTime()!="" && modell.getToDateTime()!="%41"&&!modell.getToDateTime().equals("%41")){
			Date fdate1 =sdfSource1.parse(modell.getFromDateTime());
		    Date tdate1 =sdfSource1.parse(modell.getToDateTime());	
		    if(tdate1.before(fdate1)){
		    	logger.info("to date is gretter than from date");
			}else{
			    String newFromDate1 = sdfDestination1.format(fdate1);
			    String newToDate1 = sdfDestination1.format(tdate1);
			    tx.add(Restrictions.between("dateCreated",newFromDate1,newToDate1));
			    tot.add(Restrictions.between("dateCreated",newFromDate1,newToDate1));
			}
		}else if(modell.getToDateTime()==null || modell.getToDateTime()=="" || modell.getToDateTime()=="%41"||modell.getToDateTime().equals("%41")){
			if(modell.getFromDateTime()!=null && modell.getFromDateTime()!="" && modell.getFromDateTime()!="%41"&&!modell.getFromDateTime().equals("%41")){
				Date fdate2 =sdfSource1.parse(modell.getFromDateTime());
				String newFromDate2 = sdfDestination1.format(fdate2);
				String newToDate2 = sdfDestination1.format(new Date());
				tx.add(Restrictions.between("dateCreated",newFromDate2,newToDate2));
			    tot.add(Restrictions.between("dateCreated",newFromDate2,newToDate2));
			}else{
				logger.info("from date todate are empty");
			}
		}
		tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 10);
		tx.setMaxResults(10);
		List criteriaList = tx.list();
		AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)s.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",modell.getWalletEmail())).uniqueResult();
		HashMap merchantMap=null;
		try{
			Long rows = (Long) tot.uniqueResult();
			Long totalRows= rows/10;
			Long modlus = rows%10;			
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
			merchantList.add(0,rowsMap);
		for(Object obj:criteriaList){
			merchantMap = new HashMap<String,String>();
		        Object[] ob=(Object[])obj;
		        merchantMap.put("applicationNo",""+ob[0]);
		        merchantMap.put("merchantName",""+ob[1]); 
		        merchantMap.put("directorName",""+ob[2]);
		        merchantMap.put("marketingName",""+ob[3]);
		        merchantMap.put("address1",""+ob[4]);
		        merchantMap.put("address2",""+ob[5]);
		        merchantMap.put("state",""+ob[6]);
		        merchantMap.put("city",""+ob[7]);
		        merchantMap.put("pincode",""+ob[8]);
		        merchantMap.put("country",""+ob[9]);
		        merchantMap.put("phoneNo",""+ob[10]);
		        merchantMap.put("emailId",""+ob[11]);
		        if(Long.valueOf(""+ob[12])==0){
		        	merchantMap.put("tinNo","");
		        }else{
		        	merchantMap.put("tinNo",""+ob[12]);
		        }merchantMap.put("serviceTaxNo",""+ob[13]);
		        if(ob[14]==null||ob[14]=="null"||ob[14]==""){
		        	 merchantMap.put("bankMid","");
		        }else{
		        	merchantMap.put("bankMid",""+ob[14]);
		        }
		        merchantMap.put("varificationStatus",""+ob[15]);
		        merchantMap.put("empRole",emp1.getEmpRole());
		        merchantList.add(merchantMap); 
		      }
		}catch(Exception e){
			logger.info("Error to generate map and list "+e);
		}
		logger.info("merchant list successfully selected");
		}catch(Exception e){
			logger.info("Error to create hibernate session "+e);
		}
		response.setStatus(AcqStatusDefination.OK.getIdentifier());
		response.setMessage(AcqStatusDefination.OK.getDetails());
		response.setResult(merchantList);
		return response;
	}
	
	
	
	@SuppressWarnings("null")
	public List<HashMap<String,String>> merchantList(){
		List<HashMap<String,String>> merchantList = new ArrayList<HashMap<String,String>>();	
		Session session = getSession();
		List<AcqMerchant> criteriaList = session.createCriteria(AcqMerchant.class).list();		
		Iterator<AcqMerchant> itr = criteriaList.iterator();
		while(itr.hasNext()){
			System.out.println();
			AcqMerchant merchant =(AcqMerchant)itr.next();
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("merchantId", ""+merchant.getMerchantId());
			map.put("merchantName", merchant.getMerchantName());
			String address = merchant.getBusinessAddress1()+", "+merchant.getBusinessAddress2()+", "+merchant.getBusinessCity()+", "+merchant.getBusinessState()+", "+merchant.getCountry();
			map.put("address", address);
			map.put("emailId", merchant.getEmailId());
			String taxDetails = "TinNo:"+merchant.getTinNo()+" Service Tax No:"+merchant.getServiceTaxNo()+" Bank MID:"+merchant.getBankMid();
			map.put("taxDetails", taxDetails);
			map.put("varificationStatus", merchant.getVerificationStatus());
			map.put("note", merchant.getNote());
			map.put("lastUpdatedOn",merchant.getDateUpdated());
			merchantList.add(map);
		}
		return merchantList;
	}
	
	

	@Override
	public List txnHome(AcqSearchModel modell) {
		logger.info("request is landing in dao for txn list");
		try{
			Session session= getSession();
			Set<String> merchantIds = new HashSet<String>();
			List<AcqMerchant> merchantList = null;
			Criteria tx=session.createCriteria(AcqTransactionListEntity.class).addOrder(Order.desc("id"));
			Criteria tot = session.createCriteria(AcqTransactionListEntity.class);
			tot.setProjection(Projections.rowCount());			
			
			if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""){	
				try{
				merchantList = (List<AcqMerchant>)session.createCriteria(AcqMerchant.class).setProjection(Projections.property("merchantId")).add(Restrictions.like("merchantName", modell.getMerchantName()+"%")).list();
					Iterator itr = merchantList.iterator();
					logger.info("merchant fetched successfully");
					while(itr.hasNext()){
						merchantIds.add(""+itr.next());					
					}if(!merchantIds.isEmpty()){
						//System.out.println("qqqqqqqq"+merchantIds);
						tx.add(Restrictions.in("merchantId", merchantIds));
						tot.add(Restrictions.in("merchantId", merchantIds));
					}else{
						logger.info("Merchant Name Not Found");
					}		
				}catch(Exception e){
					System.out.println("error"+e);
				}	
				}
			long txn=0l;
			if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""){		
				try{
					txn=(Long) session.createCriteria(AcqAppUser.class).add(Restrictions.eq("loginId", Long.valueOf(modell.getUserPhone()))).setProjection(Projections.property("userId")).uniqueResult();
				}catch(Exception e){
					System.out.println("error"+e);
				}	}
				if(modell.getUserPhone()!=null&&modell.getUserPhone()!=""){ 
					tx.add(Restrictions.eq("userId",""+ txn));
					tot.add(Restrictions.eq("userId",""+ txn));
			    }
			if(modell.getCustPhone()!=null&&modell.getCustPhone()!=""){
				tx.add(Restrictions.eq("custPhone",Long.valueOf(modell.getCustPhone())));
				tot.add(Restrictions.eq("custPhone",Long.valueOf(modell.getCustPhone())));
				//phone puted in criteria
			}if(modell.getFromDateTime()!=null&&modell.getFromDateTime()!=""){				
				SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
				Date fdate =sdfDestination.parse(modell.getFromDateTime());
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				String newFromDate1 = sdfSource.format(fdate);
				String newToDate=null;
				String newFromDate = newFromDate1+" 00:00:00";
				if(modell.getToDateTime()!=null&&modell.getToDateTime()!=""&&modell.getToDateTime().length()==10){	
					Date tdate =sdfDestination.parse(modell.getToDateTime());
					String newToDate1 = sdfSource.format(tdate);
					newToDate= newToDate1+" 23:59:59";
					System.out.println("newFromDate1: "+newFromDate);
					System.out.println("newToDate1: "+newToDate);
					tx.add(Restrictions.between("datetime",newFromDate,newToDate));
					tot.add(Restrictions.between("datetime",newFromDate,newToDate));
				}else{
					Date tdate =sdfDestination.parse(modell.getToDateTime());
					String newToDate1 = sdfSource.format(tdate);
					newToDate = newToDate1+" 23:59:59";
					System.out.println("newFromDate2: "+newFromDate);
					System.out.println("newToDate: "+newToDate);
					tx.add(Restrictions.between("datetime",newFromDate,newToDate));
					tot.add(Restrictions.between("datetime",newFromDate,newToDate));
				}
			}
			
			tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
			tx.setMaxResults(20);
			List criteriaList = tx.list();
			Long rows = (Long) tot.uniqueResult();
			List globleMap = new ArrayList();
			//System.out.println("totalRecords: "+rows);
			Long totalRows= rows/20;
			Long modlus = rows%20;
			System.out.println("modlus "+modlus);
			if(totalRows<=0){
				globleMap.add(0,1);
			}else{
				if(modlus>0)
					globleMap.add(0,totalRows+1);
				else globleMap.add(0,totalRows);
			}			
			Iterator etr = criteriaList.iterator();			
			HashMap singleMap=null;
			int i = 0;
			String merchantName= null;
			while(etr.hasNext()){
				AcqTransactionListEntity entit = (AcqTransactionListEntity)etr.next();
				try{
				 merchantName = (String) session.createCriteria(AcqAddNewMerchantEntity.class).setProjection(Projections.property("merchantName")).add(Restrictions.eq("merchantId",Long.valueOf(entit.getMerchantId()+""))).uniqueResult();						
				}
				catch (Exception e) {
					logger.error("error to fetch merchant name"+e);
				}
				String orgName =(String) session.createCriteria(AcqOrganization.class).setProjection(Projections.property("name")).add(Restrictions.eq("orgId",Long.valueOf(entit.getOrgId()+""))).uniqueResult();
				
				singleMap = new HashMap();
				singleMap.put("id",""+entit.getWalletId());
				singleMap.put("amount",""+entit.getWalletAmount());
				if(entit.getWalletStatus().equals("VOID")){
					singleMap.put("status",""+entit.getWalletStatus());
				}else{
					singleMap.put("status","SUCCESSFUL");					
				}
				singleMap.put("cardPanNo",entit.getCardPanNo());
				if(entit.getWalletMobileNo()==null){
					singleMap.put("custPhone","");
				}else{
					singleMap.put("custPhone",""+entit.getWalletMobileNo());
				}if(entit.getWalletEmail()==null){
					singleMap.put("custEmail","");
				}else{
					singleMap.put("custEmail",entit.getWalletEmail());
				}
				singleMap.put("merchantName",merchantName);
				singleMap.put("batchstatus",""+entit.getAgsPayoutStatus());
				singleMap.put("orgName",orgName);
				SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    Date date = sdfSource1.parse(entit.getWalletDateTime());
			    SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			    singleMap.put("dateTime",""+sdfDestination1.format(date));
				globleMap.add(singleMap);
				i++;
				}
			logger.info("transaction list selected successfully");
			return globleMap;			
		}catch(Exception e){
			logger.info("error to select transaction list"+e);
			return null;
		}
	}	

	public static void main(String arr[]){

	}
	
	public HashMap<String,String> getMerchanteDetail(Integer merchantId){
		Session session = getSession();
		AcqMerchant merchant = (AcqMerchant) session.createCriteria(AcqMerchant.class).add(Restrictions.eq("merchantId", 14)).uniqueResult();
		if(merchant==null||merchant+""==""){
			return null;
		}else{
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("merchantId", ""+merchant.getMerchantId());
			map.put("merchantName", merchant.getMerchantName());
			map.put("businessType", merchant.getBusinessType());
			map.put("directorsName", merchant.getDirectorsName());
			map.put("authorizedSignatory", merchant.getAuthorizedSignatory());
			map.put("businessNature", merchant.getBusinessNature());
			map.put("marketingName", merchant.getMarketingName());
			map.put("address1", merchant.getBusinessAddress1());
			map.put("address2", merchant.getBusinessAddress2());
			map.put("city", merchant.getBusinessCity());
			map.put("state", merchant.getBusinessState());
			map.put("country", merchant.getCountry());
			map.put("webSiteUrl", merchant.getWebsiteUrl());
			map.put("emailId", merchant.getEmailId());
			map.put("tinNo", "123");
			map.put("serviceTaxNo", merchant.getServiceTaxNo());
			map.put("bankMId", merchant.getBankMid());
			map.put("verificationStatus", merchant.getVerificationStatus());
			map.put("note", merchant.getNote());
			return map;
		}
	}
	@Override
	
		public TreeMap<String, Object> merchantDetails(String merchantId, String emp){
			TreeMap<String, Object> response = new TreeMap<String,Object>();
			try{
				SimpleDateFormat sdfDestination1 = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdfSource1 = new SimpleDateFormat("dd/MM/yyyy");
				Session session = getSession();
				AcqAddNewMerchantEntity merchant = (AcqAddNewMerchantEntity) session.createCriteria(AcqAddNewMerchantEntity.class).add(Restrictions.eq("merchantId", Long.valueOf(merchantId))).uniqueResult();
				AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",emp)).uniqueResult();
				TreeMap<String,Object> merchantDetails = new TreeMap<String,Object>();
				if(merchant==null||merchant+""==""){
					logger.info("No records fetch");
					return null;
				}else{
					merchantDetails.put("merchantId", merchant.getMerchantId());
					merchantDetails.put("merchantName", merchant.getMerchantName());
					merchantDetails.put("businessType", merchant.getBusinessType());
					merchantDetails.put("merchantType", merchant.getMerchantType());
					merchantDetails.put("directorsName", merchant.getDirectorsName());
					merchantDetails.put("authorizedSignatory", merchant.getAuthorizedSignatory());
					merchantDetails.put("businessNature", merchant.getBusinessNature());
					merchantDetails.put("marketingName", merchant.getMarketingName());
					merchantDetails.put("businessAddress1", merchant.getBusinessAddress1());
					merchantDetails.put("businessAddress2", merchant.getBusinessAddress2());
					merchantDetails.put("businessCity", merchant.getBusinessCity());
					merchantDetails.put("businessState", merchant.getBusinessState());
					merchantDetails.put("businessPincode", merchant.getBusinessPincode());
					merchantDetails.put("personalAddress1", merchant.getPersonalUserAddress1());
					merchantDetails.put("personalAddress2", merchant.getPersonalUserAddress2());
					merchantDetails.put("personalCity", merchant.getPersonalUserCity());
					merchantDetails.put("personalState", merchant.getPersonalUserState());
					merchantDetails.put("personalPincode", merchant.getPersonalUserPincode());				
					merchantDetails.put("country", merchant.getCountry());
					merchantDetails.put("webSiteUrl", merchant.getWebsiteUrl());
					merchantDetails.put("emailId", merchant.getEmailId());
					merchantDetails.put("cubMerchant", merchant.getCubMerchant());
					merchantDetails.put("emprole1", emp1.getEmpRole());
					if(merchant.getAquirerCode().equalsIgnoreCase("Acquiro")){ 
						merchantDetails.put("acquirerCode", "Acquiro");    
					}else{   
						merchantDetails.put("acquirerCode", merchant.getAquirerCode());     
						}
					if(Long.valueOf(merchant.getTinNo())==0){
						merchantDetails.put("tinNo", "");
					}else{
						merchantDetails.put("tinNo", merchant.getTinNo());
					}
					if(merchant.getExecutiveName()!=null&&merchant.getExecutiveName()!=""&&!merchant.getExecutiveName().equals("NA")){
						merchantDetails.put("executiveName", merchant.getExecutiveName());
					}else{
						merchantDetails.put("executiveName", "");
					}
					//logger.info("still putting merchant details");
					merchantDetails.put("serviceTaxNo", merchant.getServiceTaxNo());
					merchantDetails.put("bankMId", merchant.getBankMid());
					merchantDetails.put("verificationStatus", merchant.getVerificationStatus());
					merchantDetails.put("note", merchant.getNote());
					merchantDetails.put("phoneNo", merchant.getPhoneNo());
					merchantDetails.put("businessCode", merchant.getBusinessCode());
					merchantDetails.put("checkStatus", merchant.getAppCheckStatus());
					if(merchant.getDateCreated()!=null&&merchant.getDateCreated()!=""){
						
						 Date getDateCreated =sdfDestination1.parse(merchant.getDateCreated());
						 String getDateCreated1 = sdfSource1.format(getDateCreated);
						 merchantDetails.put("createdOn", getDateCreated1);
					}
					merchantDetails.put("lastUpdated", merchant.getDateUpdated());
					merchantDetails.put("swipeAmount", merchant.getSwipeAmount());
					if(merchant.getSwipeDate()!=null&&merchant.getSwipeDate()!=""){
						 Date fdate1 =sdfDestination1.parse(merchant.getSwipeDate());
						
						 String newFromDate2 = sdfSource1.format(fdate1);
						 merchantDetails.put("swipeDate", newFromDate2);
					}
					merchantDetails.put("swipeTerminal",merchant.getSwipeTerminal());
					if(Long.valueOf(merchant.getChequeNo())==0){
						    merchantDetails.put("chequeNo", "");
						}
						else{
							merchantDetails.put("chequeNo", merchant.getChequeNo());
						}
					
					merchantDetails.put("chequeAmount", merchant.getChequeAmount());
					if(merchant.getChequeDate()!=null&&merchant.getChequeDate()!=""){
						
						 Date chequeD =sdfDestination1.parse(merchant.getChequeDate());
						 String chequeDate = sdfSource1.format(chequeD);
						 merchantDetails.put("chequeDate", chequeDate);
					}
					if(merchant.getChequeDepositeDate()!=null&&merchant.getChequeDepositeDate()!=""){
						 Date chequeDDate =sdfDestination1.parse(merchant.getChequeDepositeDate());
						 String chequeDepositDate = sdfSource1.format(chequeDDate);
						 merchantDetails.put("chequeDepositDate", chequeDepositDate);
					}
						merchantDetails.put("chequeBank", merchant.getChequeBank());				
						merchantDetails.put("cashAmount", merchant.getCashAmount());
				   if(merchant.getCashDate()!=null&&merchant.getCashDate()!=""){
						Date cashD =sdfDestination1.parse(merchant.getCashDate());
						String cashDate = sdfSource1.format(cashD);
						merchantDetails.put("cashDate", cashDate);
					}
					
				   merchantDetails.put("neftAmount", merchant.getNeftAmount());
				if(merchant.getNeftDate()!=null&&merchant.getNeftDate()!=""){
					 Date neftDate1 =sdfDestination1.parse(merchant.getNeftDate());
					 String neftDate = sdfSource1.format(neftDate1);
					 merchantDetails.put("neftDate", neftDate);
				}
				
				// Other Details 
				
				if(merchant.getAppReceiptDate()!=null&&merchant.getAppReceiptDate()!=""){
					 Date getAppReceiptDate =sdfDestination1.parse(merchant.getAppReceiptDate());
					 String getAppReceiptDate1 = sdfSource1.format(getAppReceiptDate);
					 merchantDetails.put("appReceiptDate", getAppReceiptDate1);
				}
				if(merchant.getTypeOfSale()!=null&&merchant.getTypeOfSale()!=""){
					 merchantDetails.put("typeOfSale", merchant.getTypeOfSale());
				}else{
					merchantDetails.put("typeOfSale", "");
				}
				if(merchant.getAmName()!=null&&merchant.getAmName()!=""){
					 merchantDetails.put("amName", merchant.getAmName());
				}else{
					merchantDetails.put("amName", "");
				}
				if(merchant.getTsoName()!=null&&merchant.getTsoName()!=""){
					 merchantDetails.put("tsoName", merchant.getTsoName());
				}else{
					 merchantDetails.put("tsoName", "");
				}
				if(merchant.getOnBoardEmpName()==null||merchant.getOnBoardEmpName()==""||merchant.getOnBoardEmpName().equals("")){
					 merchantDetails.put("onBoardEmpName", "NA");
				}else{
					merchantDetails.put("onBoardEmpName", merchant.getOnBoardEmpName());
					  
				}
				if(merchant.getOnBoardingStatus()!=null&&merchant.getOnBoardingStatus()!=""){
					
					 merchantDetails.put("onBoardStatus", merchant.getOnBoardingStatus());
				}else{
					merchantDetails.put("onBoardStatus", merchant.getOnBoardingStatus());
				}
				if(merchant.getVerificationEntryDate()!=null&&merchant.getVerificationEntryDate()!=""){
					 Date getVerificationEntryDate =sdfDestination1.parse(merchant.getVerificationEntryDate());
					 String getVerificationEntryDate1 = sdfSource1.format(getVerificationEntryDate);
					 merchantDetails.put("verificationEntryDate", getVerificationEntryDate1);
				}
				if(merchant.getAgreementRcvdDate()!=null&&merchant.getAgreementRcvdDate()!=""){
					 Date getAgreementRcvdDate =sdfDestination1.parse(merchant.getAgreementRcvdDate());
					 String getAgreementRcvdDate1 = sdfSource1.format(getAgreementRcvdDate);
					 merchantDetails.put("agreementRcvdDate", getAgreementRcvdDate1);
				}
				
				// End
				
				if(Long.valueOf(merchant.getNeftchequeNo())==0){
				    merchantDetails.put("neftchequeNo", "");
				}else{
					merchantDetails.put("neftchequeNo", merchant.getNeftchequeNo());
				}
				if(Long.valueOf(merchant.getNeftRefNo())==0){
				    merchantDetails.put("neftRefNo", "");
				}else{
					merchantDetails.put("neftRefNo", merchant.getNeftRefNo());
				}					
					merchantDetails.put("modeOfPayment",merchant.getPaymentDetail());					
				//	logger.info("merchant details is populated........");
					Set<AcqOrganization> org = merchant.getOrgRecords();				
					Iterator<AcqOrganization> itr =org.iterator();
					//logger.info("org select");
					int i=1;
					TreeMap<String,Object> orgMap;
					while(itr.hasNext()){
					try	{
						orgMap = new TreeMap<String,Object>();
						AcqOrganization org1 = (AcqOrganization)itr.next();	
						System.out.println("inside while for org: "+org1.getOrgId());
						orgMap.put("orgId", org1.getOrgId());
						orgMap.put("orgName", org1.getName());
						orgMap.put("address1", org1.getAddress1());
						orgMap.put("address2", org1.getAddress2());
						orgMap.put("city", org1.getCity());
						orgMap.put("state", org1.getState());
						orgMap.put("country", org1.getCountry());
						orgMap.put("pincode", org1.getPincode());
						orgMap.put("empRole", emp1.getEmpRole());
						System.out.println("org seleccted");
						Set<AcqAppUser> userList = org1.getAppUsers();
						System.out.println("org seleccted11111111");
						//TreeSet<AcqAppUser> treeSet = new TreeSet<AcqAppUser>();
						Set<AcqAppUser> treeSet = new HashSet<AcqAppUser>();
						treeSet.addAll(userList);
						System.out.println("org seleccted1222222");
						Iterator<AcqAppUser> itr2=treeSet.iterator();
						int j=1;
						try{
							System.out.println("org seleccted113333333");
							AcqDeviceMapUser mapuser = null;
							LinkedHashMap<String,String> userDeviceMap;
							while(itr2.hasNext()){
								System.out.println("org seleccted144444");
								userDeviceMap = new LinkedHashMap<String,String>();
								AcqAppUser user = (AcqAppUser)itr2.next();
								System.out.println("inside while for org device: "+user.getOrganizationId());
								userDeviceMap.put("userId",""+user.getUserId());
								userDeviceMap.put("userName",""+user.getUserName());
								userDeviceMap.put("userEmail",""+user.getEmailId());
								userDeviceMap.put("userPhoneNo",""+user.getLoginId());
								userDeviceMap.put("rmn",""+user.getRmn());
								userDeviceMap.put("userStatus",""+user.getUserStatus());
								userDeviceMap.put("emprole2", emp1.getEmpRole()); 
								userDeviceMap.put("switchType", user.getSwitchType()); 
								userDeviceMap.put("rechargeService", user.getRechargeServiceEnable()); 
								userDeviceMap.put("ppcServiceEnable", user.getPpcServiceEnable()); 
								userDeviceMap.put("dmtServiceEnable", user.getDmtServiceEnable()); 
								userDeviceMap.put("dthMobileServiceEnable", user.getDthMobileServiceEnable()); 
					
								// device started
								mapuser =  user.getDeviceMapUser();	
								if(mapuser==null){}else{							
									if(mapuser.getSerialNo().equals("NA")){
										userDeviceMap.put("serialNo","");
									}else{
									   	userDeviceMap.put("serialNo",""+mapuser.getSerialNo());
									}	
									userDeviceMap.put("rechargeBal", ""+mapuser.getRechargeBal()); 
									userDeviceMap.put("rechargeIncentive", ""+mapuser.getRechargeIncentive()); 
									userDeviceMap.put("rechargeMonthlyRental", ""+mapuser.getRechargeMonthlyRental()); 
									
								if(mapuser.getBankTId().equals("NA")){
									userDeviceMap.put("bankTId","");
								}else{
									userDeviceMap.put("bankTId", mapuser.getBankTId());
								}
								userDeviceMap.put("settlementCharges",""+mapuser.getSettlementCharges());
								userDeviceMap.put("mdrZero",""+mapuser.getMdrDebit0());
								userDeviceMap.put("userType",""+mapuser.getUserType());
								userDeviceMap.put("mdrDebit0", ""+mapuser.getMdrDebit0());
								userDeviceMap.put("mdrDebit1", ""+mapuser.getMdrDebit1());
								userDeviceMap.put("mdrDebit2", ""+mapuser.getMdrDebit2());
								userDeviceMap.put("mdrCreditNpre", ""+mapuser.getMdrCreditNpre());
								userDeviceMap.put("mdrCreditPre", ""+mapuser.getMdrCreditPre());
								userDeviceMap.put("mdrMobiKwik", ""+mapuser.getMdrMobiKwik());
								userDeviceMap.put("mdrAmex",""+ mapuser.getMdrAmex());						
								userDeviceMap.put("other", ""+mapuser.getOther());
								userDeviceMap.put("mdrCashAtPos", ""+mapuser.getMdrCashAtPos());
								userDeviceMap.put("bankAccName", mapuser.getBankAccName());
								userDeviceMap.put("bankAccNo", mapuser.getBankAccNo());
								userDeviceMap.put("bankName", mapuser.getBankName());
								userDeviceMap.put("benefName", mapuser.getBenefName());
								userDeviceMap.put("bankBranch", mapuser.getBankBranch());
								userDeviceMap.put("bankIfsc", mapuser.getBankIfsc());
								userDeviceMap.put("bankMicr", mapuser.getBankMicr());
								userDeviceMap.put("rent", ""+mapuser.getRent());
								userDeviceMap.put("paymentMode", mapuser.getPaymentMode());
								userDeviceMap.put("amexActivated", mapuser.getUpdateAmexActivated());
								userDeviceMap.put("amexTID", mapuser.getUpdateAmexTID());
								userDeviceMap.put("amexMID", mapuser.getUpdateAmexMID());
								userDeviceMap.put("penaltyAmount",""+ mapuser.getPenaltyAmount());
								System.out.println("penaltyreason"+mapuser.getPenaltyReason());
								//System.out.println("discountReason"+mapuser.getDiscountReason());
								userDeviceMap.put("loyaltyStatus",""+user.getLoyaltyStatus());
							    userDeviceMap.put("closeWalletStatus",""+user.getCloseWalletStatus());
							    userDeviceMap.put("txnSmsStatus",""+user.getTxnSmsStatus());
							    if(mapuser.getIntegrationKey().equals("NA")){
									userDeviceMap.put("integrationKey","");
								}else{
									userDeviceMap.put("integrationKey", mapuser.getIntegrationKey());
								}
								userDeviceMap.put("penaltyReason", ""+mapuser.getPenaltyReason());
								userDeviceMap.put("discount", ""+mapuser.getDiscount());
								userDeviceMap.put("discountReason", ""+mapuser.getDiscountReason());
								Date fdate1 =sdfDestination1.parse(mapuser.getValidTil());
								String newFromDate2 = sdfSource1.format(fdate1);
								userDeviceMap.put("validTil", newFromDate2);
								userDeviceMap.put("pendingRent", ""+mapuser.getPendingRent());
								userDeviceMap.put("avgTxnAmount", ""+new DecimalFormat("#.##").format(mapuser.getAvgTxnAmount()));
								
								userDeviceMap.put("loanStatus", ""+mapuser.getLoanStatus());
								if(mapuser.getLoanType()==null){
									userDeviceMap.put("loanType", "");
								}else{
									userDeviceMap.put("loanType", ""+mapuser.getLoanType());
								}
								if(mapuser.getLoanDedAmount().equals("0.000")){
									userDeviceMap.put("loanDedAmount", "");
								}else{
									userDeviceMap.put("loanDedAmount", ""+mapuser.getLoanDedAmount());
								}
								AcqLoanDetails loanEnt = (AcqLoanDetails) session.createCriteria(AcqLoanDetails.class).add(Restrictions.eq("userId",mapuser.getUserId())).uniqueResult();
								if(loanEnt==null||loanEnt+""==""){
									System.out.println("Loan Details Not Found");
								}else{
									userDeviceMap.put("loanBankName", ""+loanEnt.getLoanBankName());	
									userDeviceMap.put("loanBankAcc", ""+loanEnt.getLoanBankAccNo());
									userDeviceMap.put("loanBankIfsc", ""+loanEnt.getLoanBankIfsc());
								}
								if(mapuser.getActivationDate()==null||mapuser.getActivationDate()==""||mapuser.getActivationDate().equals("NA")){
									userDeviceMap.put("activationDate","01/01/2016");
								}else{
									Date actDate = sdfDestination1.parse(mapuser.getActivationDate());
									String actDate2 = sdfSource1.format(actDate);
									userDeviceMap.put("activationDate",actDate2 );
								}
								userDeviceMap.put("planName", mapuser.getPlanName());
								userDeviceMap.put("feeMode", mapuser.getFeeMode());
								userDeviceMap.put("feeAmount", mapuser.getFeeAmount());
								userDeviceMap.put("feeDate", mapuser.getFeeDate());
								if(mapuser.getFeeDate()==null||mapuser.getActivationDate()==""||mapuser.getActivationDate().equals("NA")){
									userDeviceMap.put("feeDate","01/01/2016");
								}else{
									Date feeDate = sdfDestination1.parse(mapuser.getFeeDate());
									String feeDate2 = sdfSource1.format(feeDate);
									userDeviceMap.put("feeDate",feeDate2);
								}
								if(mapuser.getMidTidEntryDate()==null||mapuser.getMidTidEntryDate()==""||mapuser.getMidTidEntryDate().equals("NA")){
														userDeviceMap.put("midTidEntryDate","01/01/2016");
													}else{
														Date midTidEntryDate = sdfDestination1.parse(mapuser.getMidTidEntryDate());
														String midTidEntryDate2 = sdfSource1.format(midTidEntryDate);
														userDeviceMap.put("midTidEntryDate",midTidEntryDate2);
													}
													if(mapuser.getWlcmLtrSendDate()==null||mapuser.getWlcmLtrSendDate()==""||mapuser.getWlcmLtrSendDate().equals("NA")){
														userDeviceMap.put("wlcmLtrSendDate","01/01/2016");
													}else{
														Date wlcmLtrSendDate = sdfDestination1.parse(mapuser.getWlcmLtrSendDate());
														String wlcmLtrSendDate2 = sdfSource1.format(wlcmLtrSendDate);
														userDeviceMap.put("wlcmLtrSendDate",wlcmLtrSendDate2);
													}
								userDeviceMap.put("feeRemark", mapuser.getFeeRemark());						
								orgMap.put("device"+j, userDeviceMap);							
								}j++;
							}
						}catch(Exception e){
							logger.error("Error in fetch user and device :" +e);
						}
						
						orgMap.put("orgDeviceCount", j-1);
						merchantDetails.put("org"+i, orgMap);
					}catch(Exception e){
						logger.error("Error in fetch org :" +e);
					}i++;
					}	
					merchantDetails.put("merchantOrgCount", i-1);
				}
			
				logger.info("user list selected");
				return merchantDetails;
			}catch(Exception e){
				
				logger.error("Error in MerchantDetails : "+e);
				return null;
			}
		}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HashMap<String,String>> txnMerchantlist(AcqBillingModel modell) {
		try{
			Session s =  getSession();
			List<HashMap<String,String>> global = new ArrayList<HashMap<String,String>>();
			ProjectionList proList = Projections.projectionList();
		     proList.add(Projections.property("merchantId"));
		     proList.add(Projections.property("merchantName"));
		    proList.add(Projections.property("merchantType"));
			Criteria tx= s.createCriteria(AcqMerchant.class).setProjection(proList);				
			List list = tx.list();
			HashMap merchantMap=null;
			for(Object obj:list){
					merchantMap = new HashMap<String,String>();
			        Object[] ob=(Object[])obj;
			        merchantMap.put("merchantId",""+ob[0]);
			        merchantMap.put("merchantName",""+ob[1]); 
			       merchantMap.put("merchantType",""+ob[2]);
			        global.add(merchantMap);  
			}	
	logger.info("merchant successfully selected");
		return global;
	}catch(Exception e){
		logger.error("Error to "+e);
		return null;
	}
}   
	
	public List<HashMap<String,String>> txnOrgList(AcqBillingModel modell) {
		List<HashMap<String,String>> globalMap =new ArrayList<HashMap<String,String>>();
		try{
			if(""+modell.getMerchantId()!=null&&""+modell.getMerchantId()!=""&&!modell.getMerchantId().equals("null")){
				System.out.println("sssssssssssss"+modell.getMerchantId());
				Session s = getSession();
				 ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("orgId"));
			     proList.add(Projections.property("name"));	
				Criteria tx= s.createCriteria(AcqOrganization.class).setProjection(proList).add(Restrictions.eq("merchantId", Integer.valueOf(""+modell.getMerchantId())));				
				System.out.println("sgefwgwegewg"+tx);
				List list = tx.list();
				System.out.println("sgefwgw1111111111egewg"+list);
				HashMap userMap=null;
				for(Object obj:list){
					System.out.println("2222222222222"+obj);
						userMap = new HashMap<String,String>();
				        Object[] ob=(Object[])obj;
				        userMap.put("orgId",""+ob[0]);
				        userMap.put("orgName",""+ob[1]); 
				        globalMap.add(userMap);  
			}  }
				       
			logger.info("Org selected successfully::"+globalMap);
		return globalMap;
		}
		catch(Exception e){
			logger.error("Error in select org "+e);
			return null;
		}
	}
	
	@Override
	public List<HashMap<String,String>> txnTerminalList(AcqBillingModel modell) {
		List<HashMap<String,String>> globalMap =new ArrayList<HashMap<String,String>>();
		try	{
			if(""+modell.getOrgId()!=null&&""+modell.getOrgId()!=""&&!modell.getOrgId().equals("null")){				
				Session s = getSession();
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
				        globalMap.add(userMap);  
			}  }
			logger.info("user list successfully selected.");
		return globalMap;
		}
		catch(Exception e){
			logger.error("error select termainal "+e);
			return null;
		}
	}
		
	@Override
	public DbDto<List<String>> getSettingList() {
		DbDto<List<String>> response = new DbDto<List<String>>();
		ArrayList<String> responseList = new ArrayList<String>();
		try{
			Session s = getSession();
			Query query1=s.createQuery("select id,serviceTax,mdrDebit1,mdrDebit2,mdrCr,mdrCrpn,mdrAmex,other,mdrMoiKwik,mdrPayUmoney,mdrFreecharge,mdrCitrus,mdrAirtelMoney,mdrCashAtPos,walletPayoutAc,cardPayoutAc,beneficiaryEmail,payoutEmail,cashAtPosServiceTax,maintenanceMode,maintenanceReason,appVersion,mdrDebit0,neftFee,systemUtilityAmt,systemUtilityFee from AcqSettingEntity where id = :id");
			query1.setParameter("id", 1l);
			List list1 = query1.list();		
			for(Object obj:list1){
			    Object[] ob=(Object[])obj;
			    responseList.add(0,""+ob[0]);
			    responseList.add(1,""+ob[1]);
			    responseList.add(2,""+ob[2]); 
			    responseList.add(3,""+ob[3]);
			    responseList.add(4,""+ob[4]);
			    responseList.add(5,""+ob[5]);
			    responseList.add(6,""+ob[6]);
			    responseList.add(7,""+ob[7]);
			    responseList.add(8,""+ob[8]);
			    responseList.add(9,""+ob[9]);
			    responseList.add(10,""+ob[10]);
			    responseList.add(11,""+ob[11]);
			    responseList.add(12,""+ob[12]);
			    responseList.add(13,""+ob[13]);
			    responseList.add(14,""+ob[14]);
			    responseList.add(15,""+ob[15]);
			    responseList.add(16,""+ob[16]);
			    responseList.add(17,""+ob[17]);
			    responseList.add(18,""+ob[18]);
			    if("0".equals(""+ob[19])){
			    	responseList.add(19,"OFF");
			    }else{
			    	responseList.add(19,"ON");
			    }			    
			    responseList.add(20,""+ob[20]);
			    responseList.add(21,""+ob[21]);
			    responseList.add(22,""+ob[22]);
			    responseList.add(23,""+ob[23]);
			    responseList.add(24,""+ob[24]);
			    responseList.add(25,""+ob[25]);
			}
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(responseList);
		}catch(Exception e){
			logger.info("error to select settings "+e);
		}
		return response;
	}

	@Override
	public DbDto<List<String>> getSettingUpdateList(AcqSettingModel modell) {
		DbDto<List<String>> response= new DbDto<List<String>>();
		List<String> responseList= new ArrayList<String>();
		try{
			Session s = getSession();
			if(modell.getId()!=null&&AcqNumericValidator.checkId(modell.getId())){
				 response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				    response.setMessage(AcqStatusDefination.OK.getDetails());
				    response.setResult(responseList);
			}
		AcqSettingEntity entity = (AcqSettingEntity)s.createCriteria(AcqSettingEntity.class).add(Restrictions.eq("id",1l)).uniqueResult();
		if(entity!=null&&entity+""!=""){
			try{
			entity.setServiceTax(modell.getServiceTax());
			entity.setMdrDebit1(modell.getMdrDebit1());
			entity.setMdrDebit2(modell.getMdrDebit2());
			entity.setMdrCr(modell.getMdrCr());
			entity.setMdrCrpn(modell.getMdrCrpn());
			entity.setMdrAmex(modell.getMdrAmex());
			entity.setOther(modell.getOther());
			entity.setMdrCashAtPos(modell.getMdrCashAtPos());			
			entity.setCardPayoutAc(modell.getCardPayoutAc());
			entity.setPayoutEmail(modell.getPayoutEmail());
			entity.setCashAtPosServiceTax(modell.getCashAtPosServiceTax());
			if(modell.getMaintenanceMode().equals("ON")){
				entity.setMaintenanceMode("1");
		    }else{
		    	entity.setMaintenanceMode("0");
		    }
			entity.setMaintenanceReason(modell.getMaintenanceReason());
			entity.setAppVersion(modell.getAppVersion());
			entity.setMdrDebit0(modell.getMdrDebit0());
			entity.setNeftFee(modell.getNeftFees());
			entity.setSystemUtilityAmt(modell.getSystemUtilityAmount());
			entity.setSystemUtilityFee(modell.getSystemUtilityFees());
			//Transaction tx = s.beginTransaction();
			s.saveOrUpdate(entity);//saveOrupdate(entity);
			//tx.commit();
			responseList.add(0,""+entity.getId());
		    responseList.add(1,""+entity.getServiceTax());
		    responseList.add(2,""+entity.getMdrDebit1());
		    responseList.add(3,""+entity.getMdrDebit2());
		    responseList.add(4,""+entity.getMdrCr());
		    responseList.add(5,""+entity.getMdrCrpn());
		    responseList.add(6,""+entity.getMdrAmex());
		    responseList.add(7,""+entity.getOther());
		    responseList.add(8,""+entity.getMdrMoiKwik());
		    responseList.add(9,""+entity.getMdrPayUmoney());
		    responseList.add(10,""+entity.getMdrFreecharge());
		    responseList.add(11,""+entity.getMdrCitrus());
		    responseList.add(12,""+entity.getMdrAirtelMoney());
		    responseList.add(13,""+entity.getMdrCashAtPos());		   
		    responseList.add(14,""+entity.getWalletPayoutAc());
		    responseList.add(15,""+entity.getCardPayoutAc());
		    responseList.add(16,""+entity.getBeneficiaryEmail());
		    responseList.add(17,""+entity.getPayoutEmail());
		    responseList.add(18,""+entity.getCashAtPosServiceTax());		    
		    if(entity.getMaintenanceMode().equals("0")){
		    	responseList.add(19,"OFF");
		    }else{
		    	responseList.add(19,"ON");
		    }
		    responseList.add(20,""+entity.getMaintenanceReason());
		    responseList.add(21,""+entity.getAppVersion());
		    responseList.add(22,""+entity.getMdrDebit0());
		    responseList.add(23,""+entity.getNeftFee());
		    responseList.add(24,""+entity.getSystemUtilityAmt());
		    responseList.add(25,""+entity.getSystemUtilityFee());
		    logger.info("setting successfully updated");
		    response.setStatus(AcqStatusDefination.OK.getIdentifier());
		    response.setMessage(AcqStatusDefination.OK.getDetails());
		    response.setResult(responseList);
			}catch(Exception e){
				logger.info("error to update and put list setting dao");
			}
		}
		}catch(Exception e){
			logger.info("error to select settings "+e);
		}
		return response;
	}

	
	
	}




