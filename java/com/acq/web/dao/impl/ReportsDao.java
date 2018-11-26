package com.acq.web.dao.impl;

import java.io.BufferedWriter;
import java.io.FileWriter;
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

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.acq.AcqStatusDefination;
import com.acq.users.entity.AcqBankItTransactionEntity;
import com.acq.users.entity.AcqCardDetails;
import com.acq.users.entity.AcqRechargeListEntity;
import com.acq.users.entity.AcqRiskManagement;
import com.acq.users.entity.AcqTempCommisionRptEntity;
import com.acq.users.entity.AcqWalletListEntity;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization;
import com.acq.users.model.AcqOrganization1;
import com.acq.users.model.AcqUser;
import com.acq.web.dto.impl.DbDto;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.web.dao.ReportsDaoInf;

@Repository
public class ReportsDao implements ReportsDaoInf {

	final static Logger logger = Logger.getLogger(ReportsDao.class);  
	@Value("#{AcqConfig['commisionRpt.location']}")
	private String commisionFileLocation;
	public String getCommisionFileLocation() {
		return commisionFileLocation;
	}
	@Autowired
	AcqMerchantDaoImpl AcqMerchantDaoImpl;
	@Transactional
	public DbDto<Object> downloadcardCommisionProcedureFromAndToDate(String acquirerCode,String empId,String merchantId, String orgId, String userId, String fromDate,
			String toDate,String transactionType,String payoutStatus) {
		DbDto<Object> response = new DbDto<Object>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			StringBuffer conditions;
			conditions = new StringBuffer();
			if(merchantId!=null&&merchantId!=""){
				conditions.append("and acq_transaction_summary.merchantid="+merchantId);
			}if(orgId!=null&&orgId!=""){
				conditions.append(" and acq_transaction_summary.orgid="+orgId);
			}if(userId!=null&&userId!=""){
				conditions.append(" and acq_transaction_summary.userid="+userId);
			}
			if(transactionType!=null&&transactionType!=""){
				conditions.append(" and acq_transaction_summary.txntype in('"+transactionType+"')");
			}else{
				conditions.append(" and acq_transaction_summary.txntype in('CARD','CASHATPOS','CVOID','VOID')");
			}
			if(payoutStatus!=null&&payoutStatus!=""){
				if(payoutStatus.equalsIgnoreCase("unsettled")){
					conditions.append(" and acq_transaction_summary.payoutstatus="+700);
				}else {
					conditions.append(" and acq_transaction_summary.payoutstatus="+701);
				}
			}	
			if(fromDate!=null&&fromDate!=""){
				Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			Date fdate =sdfDestination.parse(fromDate);
			
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
			String newFromDate1 = sdfSource.format(fdate);
			String newToDate=null;
		    String newFromDate = newFromDate1+" 00:00:00";
		    cal.setTime(fdate);
			cal.add(Calendar.YEAR,+1);
			Date dateBefore1yaer= cal.getTime();
			//System.out.println("sssssssssssss:::::::::::::::"+dateBefore1yaer);
			if(toDate!=null&&toDate!=""){ 
				Date tdate =sdfDestination.parse(toDate);
				 if(tdate.after(dateBefore1yaer)){
					System.out.println("you can not select more than one year date");  
					return response;
				 }else{
				String newToDate1 = sdfSource.format(tdate);
			    newToDate= newToDate1+" 23:59:59";
			    conditions.append(" and acq_transaction_summary.otpdatetime>= '"+newFromDate+"'");
			    conditions.append(" and acq_transaction_summary.otpdatetime<= '"+newToDate+"'");
			    }
			}else{
				Date tDate = new Date();
				 String stringToDate = sdfSource.format(tDate)+" 23:59:59";
				 if(tDate.after(dateBefore1yaer)){
						System.out.println("you can not select more than one year date"); 
						response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
						response.setMessage("Please Select to Date, You can not download more than one year data");
						response.setResult(null);
						return response;
					 }else{
						 conditions.append(" and acq_transaction_summary.otpdatetime>= '"+newFromDate+"'");
						 conditions.append(" and acq_transaction_summary.otpdatetime<= '"+newToDate+"'");
					 }
		    }
		}
			if(acquirerCode.equalsIgnoreCase("Acquiro")){
				conditions.append(" and acq_transaction_summary.aquirer_code= 'Acquiro'");
			}else{
				conditions.append(" and acq_transaction_summary.aquirer_code= '"+acquirerCode+"'");
			}
			
			Date date = new Date();
			String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		    String rndchars = RandomStringUtils.randomAlphanumeric(6);
	        String  fileName =  "commisionReport_"+timeStamp.toString()+rndchars;
			String fileLocation = commisionFileLocation+"/"+fileName+".csv";
			/*Session session = null;
			session = getOpenSession();*/
			System.out.println("tttttttttt:"+conditions);
			
			if(acquirerCode.equalsIgnoreCase("Acquiro")){
				System.out.println("Acquiro");
				int query = session.createSQLQuery("CALL generatecommissionreport(:employeeid,:acquirername,:conditions,:lmt)")
						.setParameter("employeeid", empId).setParameter("acquirername", "Acquiro").setParameter("conditions", conditions.toString())
						.setParameter("lmt", "limit 500000")
						.executeUpdate();
				session.flush();
				session.close();
			 	
			}else{
				System.out.println("Acquirer");
				int query = session.createSQLQuery("CALL generateacquirercommissionreport(:employeeid,:acquirername,:conditions,:lmt)")
						.setParameter("employeeid", empId).setParameter("acquirername", "Acquiro").setParameter("conditions", conditions.toString())
						.setParameter("lmt", "limit 500000")
						.executeUpdate();
				session.flush();
				session.close();
				System.out.println("qUERY::"+query);	
			}
						
			
		 		BufferedWriter commisionRpt = new BufferedWriter(new FileWriter(fileLocation));
		 		String header ="Invoiceno,"+"DateTime,"+"TxnType,"+"MerchantName,"+"State,"+"Tid,"+"RRNo,"+"CardPanNo,"+"TxnAmount,"
		 				+"TotalDeduction,"+"TotalIncentive,"+"NetAmount,"+"BankMdr,"+"BankMdrCharged,"+"GST(%),"+"GST,"+"BankIncentive,"
		 				+"TDS(%),"+"TDS,"+"AcqMdr,"+"AcqMdrCharged,"+"AcqGST(%),"+"AcqGST,"+"AcqIncentive,"+"AcqTDS(%),"+"AcqTDS,"
		 				+"acquiroShare,"+"PayoutStatus,"+"PayoutDateTime\n";
		 				commisionRpt.write(header);
		 				commisionRpt.close();	
		 				int count = 0;
		 				int rowStart = 0;
		 			    int rowLimit = 2000;
		 			    Boolean hasMoreRow = true;
		 			    List<AcqTempCommisionRptEntity> entityList = null;		 			    
		 			    while (hasMoreRow) {
		 			    	/*session = getOpenSession();*/
		 			    	try{
		 			    	BufferedWriter commisionRptLoop = new BufferedWriter(new FileWriter(fileLocation,true));
		 			        entityList = (List<AcqTempCommisionRptEntity>) session.createCriteria(AcqTempCommisionRptEntity.class).add(Restrictions.eq("empID", empId)).setFirstResult(rowStart).setMaxResults(rowLimit).list();
		 			    	
		 			    	//logger.info("Succesfuly Loop :");
		 			    	
		 			    	for(AcqTempCommisionRptEntity ent : entityList){	  
		 			    		commisionRptLoop.append("\""+ent.getInvoiceNo()+"\","+"\""+ent.getDateTime()+"\","+"\""+ent.getTxnType()+"\","
		 					    		+"\""+(ent.getMerchantName()== null ? "Unknown" : ent.getMerchantName())+"\","+"\""+(ent.getState()== null ? "Unknown" : ent.getState())+"\","+"\""+ent.getTid()+"\","+"\""+ent.getRrNo()+"\","+"\""+ent.getCardPanNo()+"\","
		 								+"\""+ent.getTxnAmount()+"\","+"\""+ent.getTotalDeduction()+"\","+"\""+ent.getTotalIncentive()+"\","+"\""+ent.getNetAmount()
		 								+"\","+"\""+ent.getBankMDR()+"\","+"\""+ent.getBankMDRCharged()+"\","+"\""+ent.getGst()+"\","+"\""+ent.getGstCharged()+"\","
		 								+"\""+ent.getBankIncentive()+"\","+"\""+ent.getTds()+"\","+"\""+ent.getTdsCharged()+"\","+"\""+ent.getAcqMDR()+"\","
		 								+"\""+ent.getAcqMDRCharged()+"\","+"\""+ent.getAcqGST()+"\","+"\""+ent.getAcqGSTCharged()+"\","+"\""+ent.getAcqIncentive()+"\","
		 								+"\""+ent.getAcqTDS()+"\","+"\""+ent.getAcqTDSCharged()+"\","+"\""+ent.getacquiroShare()+"\","+"\""+ent.getPayoutStatus()+"\","
		 								+"\""+ent.getPayoutDateTime()+"\"\n");									
		 			    		count++;
		 			    	}
		 			    //	logger.info("Succesfuly Loop end :"+count);
		 			    	
		 			    	
		 			    	if(entityList.size()<rowLimit){
		 			    		hasMoreRow = false ; 
		 			    	}else{
		 			    		rowStart = rowStart+rowLimit;
		 			    	}
		 			    
		 			    	commisionRptLoop.close();
		 				}finally{
		 					entityList.clear();
		 			    	 session.flush();
		 					 session.close();
		 				}
			}
		    
			logger.info("Succesfuly Selected ::");
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(fileName);
			}catch (Exception e) {
			logger.info("error in commision report dao "+e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			response.setResult(null);
		} 
		return response;
	}
	
	
	@Override
	public DbDto<List<HashMap<String, String>>> downloadCardTxnReport(String merchantId,String orgId, String userId,String fromDate,String toDate,String txnType) {
		DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String,String>> global = new ArrayList<HashMap<String,String>>();
		try{	
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");			
			Session s = AcqMerchantDaoImpl.getSession();
			Set<String> txnList = new HashSet<String>();
			txnList.add("CARD");txnList.add("VOID");txnList.add("CASHATPOS");txnList.add("CVOID");
			Criteria criteria = s.createCriteria(AcqWalletListEntity.class);
			criteria.add(Restrictions.eq("walletStatus","505")).add(Restrictions.in("txnType",txnList));
			Set<Long> riskListt = new HashSet<Long>();
			if(merchantId!=null&&merchantId!=""&&merchantId.length()>0){
				criteria.add(Restrictions.eq("merchantId", Long.valueOf(merchantId)));
			}if(orgId!=null&&orgId!=""&&orgId.length()>0){
				criteria.add(Restrictions.eq("orgId", Long.valueOf(orgId)));
			}if(userId!=null&&userId!=""&&userId.length()>0){
				criteria.add(Restrictions.eq("userId", Long.valueOf(userId)));
			}if(fromDate!=null&&fromDate!=""){
			    String newFromDate = sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00";
			    if(toDate!=null&&toDate!=""){ 
					String newToDate= sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59";
				    criteria.add(Restrictions.between("walletDateTime",newFromDate,newToDate));
				}else{
					String stringToDate = sdfSource.format(new Date())+" 23:59:59";
				    criteria.add(Restrictions.between("walletDateTime",newFromDate,stringToDate));
			    }
			}
			if(txnType!=null&&txnType!=""){
				if(txnType.equalsIgnoreCase("CARD")||txnType.equalsIgnoreCase("CASHATPOS")||txnType.equalsIgnoreCase("VOID")){
			    	criteria.add(Restrictions.eq("txnType", txnType));
				}
				else if(txnType.equalsIgnoreCase("risk")){
					List<AcqRiskManagement> risklist = (List<AcqRiskManagement> )s.createCriteria(AcqRiskManagement.class).add(Restrictions.eq("status","1")).list();
					for(AcqRiskManagement ent : risklist){
						riskListt.add(Long.parseLong(""+ent.getTxnId()));
					}
				if(!riskListt.isEmpty()){
					 	criteria.add(Restrictions.in("walletId",riskListt));
					  }else{
						  logger.info("Risk Transaction not found");
					  }
				}
			}
			criteria.addOrder(Order.desc("walletId"));
				List txList = criteria.list();
				Iterator etr1 = txList.iterator();	
					if(txList.isEmpty()){
						logger.info("there is no wallet transaction");
					}else{
						Iterator<AcqWalletListEntity> itr1 = txList.iterator();
						Iterator<AcqWalletListEntity> itr2 = txList.iterator();
						HashMap<String,String> responseMap = null;
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
							Criteria org =s.createCriteria(AcqOrganization1.class);
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
							Criteria user =s.createCriteria(AcqUser.class);
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
							Criteria merchant =s.createCriteria(AcqMerchant.class);
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
						while(etr1.hasNext()){
							AcqWalletListEntity entit = (AcqWalletListEntity)etr1.next();
							transactionSet.add(Integer.valueOf(""+entit.getWalletId()));
						}
						if(transactionSet.isEmpty()){
						     logger.info("Transaction not found");
						     responseMap = new HashMap<String,String>();
						     responseMap.put("123", "133");
						     global.add(responseMap);
						     globleMap.setResult(global);
						     return globleMap;
						     
						    }else{
						System.out.println("transactionSet :   "+transactionSet);
						List<AcqCardDetails> cardDetails = s.createCriteria(AcqCardDetails.class).add(Restrictions.in("transactionId", transactionSet)).list();
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
						try{
						while(itr1.hasNext()){
							responseMap = new HashMap<String,String>();
							AcqWalletListEntity txEntity = (AcqWalletListEntity)itr1.next();
							SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						    SimpleDateFormat sdfSourceDb = new SimpleDateFormat("dd/MM/YYYY HH:mm:ss");
						   responseMap.put("walletId",""+txEntity.getWalletId());
							responseMap.put("dateTime", ""+sdfSourceDb.format(sdfDestinationDb.parse(txEntity.getWalletDateTime())));
							responseMap.put("wallettxnAmount",txEntity.getWalletAmount());
							if(txEntity.getWalletMobileNo().equals("0000")){
						        responseMap.put("customerPhone", "NA");
						       }else{
						        responseMap.put("customerPhone", txEntity.getWalletMobileNo());
						       }
							
							if(txEntity.getTxnType().equalsIgnoreCase("void")|| txEntity.getTxnType().equalsIgnoreCase("card")|| txEntity.getTxnType().equalsIgnoreCase("cashatpos")){
						        if(txEntity.getCardPanNo().equals("0000")|| txEntity.getCardPanNo().equals("0")) {
						        	responseMap.put("walletMobileNo","Not Available"); 
						        }else{
						        	responseMap.put("walletMobileNo",txEntity.getCardPanNo()); 
						        }
						    }else{
						    if(txEntity.getWalletMobileNo().equals("0000")){
						        	responseMap.put("walletMobileNo","Not Available"); 
						       }else{
						        	responseMap.put("walletMobileNo",txEntity.getWalletMobileNo()); 
						       }
						    }							
							if(merchantMap.get("merchantName"+txEntity.getMerchantId())==null||merchantMap.get("merchantName"+txEntity.getMerchantId())==""){
								responseMap.put("merchantName", "Not Available");
							}else{
								responseMap.put("merchantName", ""+merchantMap.get("merchantName"+txEntity.getMerchantId()));
							}
							if(usermap.get("loginId"+txEntity.getUserId())==null||usermap.get("loginId"+txEntity.getUserId())==""){
								responseMap.put("userName", "Not Available");
							}else{
								responseMap.put("userName", ""+usermap.get("loginId"+txEntity.getUserId()));
							}	
							if(orgmap.get("orgName"+txEntity.getOrgId())==null||orgmap.get("orgName"+txEntity.getOrgId())==""){
								responseMap.put("orgName", "Not Available");
							}else{
								responseMap.put("orgName", ""+orgmap.get("orgName"+txEntity.getOrgId()));	
							}
							
							if(txEntity.getWalletEmail()==null||txEntity.getWalletEmail()==""){
								responseMap.put("custEmail", "Not Available");
							}else{
								responseMap.put("custEmail", txEntity.getWalletEmail());
							}
							responseMap.put("walletName", ""+txEntity.getTxnType());
							responseMap.put("cardHolderName","Not Available");
							responseMap.put("rrNo","Not Available");
							responseMap.put("batchNo","Not Available");
							responseMap.put("authCode","Not Available");
							responseMap.put("cardType","Not Available");
							responseMap.put("imeiNo","Not Available");
							responseMap.put("terminalId","Not Available");
							 if(cardDetailMap.containsKey(""+txEntity.getWalletId())){
							    	Map<String,String> cardDetail = cardDetailMap.get(""+txEntity.getWalletId());
							    	responseMap.put("cardHolderName",cardDetail.get("cardHolderName"));
							    	if(txEntity.getCardPanNo().equals("0000")||txEntity.getCardPanNo().equals("0")) {
							    		responseMap.put("cardPanNo","Not Available"); 
							        }else{
							        	responseMap.put("cardPanNo",txEntity.getCardPanNo()); 
							        }
							    	responseMap.put("terminalId",cardDetail.get("terminalId"));
							    	
							    	if(cardDetail.get("rrNo")==null||cardDetail.get("rrNo")==""){
							    		responseMap.put("rrNo","Not Available");
							    	}else{
							    		if(cardDetail.get("rrNo").startsWith("-")){
							    			responseMap.put("rrNo",cardDetail.get("rrNo").substring(1));
								    	}else{
								    		responseMap.put("  ",cardDetail.get("rrNo"));
								    	}				    		
							    	}		    					    	
							    	responseMap.put("batchNo",cardDetail.get("batchNo"));
							    	responseMap.put("authCode",cardDetail.get("authCode"));
							    	responseMap.put("issuerAuthCode","");
							    	responseMap.put("cardExpDate","");
							    	responseMap.put("cardType",cardDetail.get("cardType"));
							    	responseMap.put("referenceNo","");
							    	responseMap.put("imeiNo",cardDetail.get("imeiNo"));
							    	responseMap.put("ipAddress",cardDetail.get("ipAddress"));				    	
							    	responseMap.put("latitude",cardDetail.get("latitude"));
							    	responseMap.put("longitude",cardDetail.get("longitude"));	
							    	responseMap.put("stan",cardDetail.get("stan"));							    	
							     }
							global.add(responseMap);
						}
						globleMap.setResult(global);
						globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
						globleMap.setMessage(AcqStatusDefination.OK.getDetails());
						logger.info("Card transaction are selected");		
						}catch(Exception e){
							logger.info("error to set Card transaction report "+e);
						}
					}
				}
				logger.info("Card transaction successfully selected.");
			}catch(Exception e){
				logger.info("error to select merchant list in Card transaction report "+e);
			}
			return globleMap;
		}
	
	
	@Override
	public DbDto<List<HashMap<String, String>>> downloadRechargeReport(String merchantId,String orgId, String userId,String fromDate,String toDate,String txnType) {
		DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
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
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
			Session s = AcqMerchantDaoImpl.getSession();
			Criteria criteria = s.createCriteria(AcqRechargeListEntity.class);
			criteria.add(Restrictions.eq("status","Success"));
			Set<Long> orgset = new HashSet<Long>();
			Set<String> userset = new HashSet<String>();
			if(merchantId!=null&&merchantId!=""&&merchantId.length()>0){
				List<AcqOrganization> orgList = (List<AcqOrganization>)s.createCriteria(AcqOrganization.class).add(Restrictions.eq("merchantId", Integer.valueOf(merchantId))).list();
				for(AcqOrganization org :orgList){
					orgset.add(org.getOrgId());
				}if(!orgset.isEmpty()){
				List<AcqUser> userList = (List<AcqUser>)s.createCriteria(AcqUser.class).add(Restrictions.in("orgId", orgset)).list();
				for(AcqUser user :userList){
					userset.add(user.getUserId().toString());
				}
				criteria.add(Restrictions.in("sessionId", userset));
				}
			}
			if(orgId!=null&&orgId!=""&&orgId.length()>0){
				List<AcqUser> userList = (List<AcqUser>)s.createCriteria(AcqUser.class).add(Restrictions.eq("orgId", orgId)).list();
				for(AcqUser user :userList){
					userset.add(user.getUserId().toString());
				}
				criteria.add(Restrictions.in("sessionId", userset));
			}
			if(userId!=null&&userId!=""&&userId.length()>0){
				criteria.add(Restrictions.eq("sessionId", Long.valueOf(userId)));
			}if(txnType!=null&&txnType!=""&&txnType.length()>0){
				criteria.add(Restrictions.eq("serviceType", txnType));
			}if(fromDate!=null&&fromDate!=""&&fromDate.length()>1){
				String newFromDate = sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00";
			    if(toDate!=null&&toDate!=""){ 
			    	String newToDate= sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59";
				    criteria.add(Restrictions.between("dateTime",newFromDate,newToDate));
				}else{
					 String stringToDate = sdfSource.format(new Date())+" 23:59:59";
				    criteria.add(Restrictions.between("dateTime",newFromDate,stringToDate));
			    }
			}
				List criteriaList = criteria.list();
				Iterator etr1 = criteriaList.iterator();	
				Iterator etr = criteriaList.iterator();	
				Iterator<AcqRechargeListEntity> itr2 = criteriaList.iterator();
				List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
				HashMap<String,String> singleMap=null;				
				Set<Integer> merchantSet = new HashSet<Integer>();
				HashMap<String,String> orgmap = null;
				HashMap<String,String> usermap = null;
				HashMap<String,String> merchantMap = null;
				Set<Long> userSet = new HashSet<Long>();
				System.out.println("CriteriaList"+criteriaList);				
					while(itr2.hasNext()){
						AcqRechargeListEntity txEntity = (AcqRechargeListEntity)itr2.next();
						userSet.add(Long.valueOf(txEntity.getSessionId()));
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
						Criteria user =s.createCriteria(AcqUser.class);
					    ProjectionList proList = Projections.projectionList();
					     proList.add(Projections.property("userId"));
					     proList.add(Projections.property("loginId"));
					     user.setProjection(proList);
					     user.add((Restrictions.in("userId", userSet)));
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
				while(etr.hasNext()){
					AcqRechargeListEntity entit = (AcqRechargeListEntity)etr.next();
					AcqUser user = (AcqUser) s.createCriteria(AcqUser.class).add(Restrictions.eq("userId", Long.valueOf(entit.getSessionId()))).uniqueResult();
					singleMap = new HashMap<String,String>();
					singleMap = new HashMap<String,String>();
				    singleMap.put("id",""+entit.getId());
					singleMap.put("amount",""+entit.getAmount());
					singleMap.put("serviceType",""+entit.getServiceType());
					singleMap.put("operator",operatorMap.get(entit.getOperator()));
					SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				    singleMap.put("dateTime",""+sdfSourceDb.format(sdfDestinationDb.parse(entit.getDateTime())));
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
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Recharge list selected successfully");
				return globleMap;	
				
			}catch(Exception e){
				logger.info("error to select Recharge list"+e);
				return null;
			}		
		}
	
	@Override
	public DbDto<List<HashMap<String, String>>> downloadDmtReport(String merchantId,String orgId, String userId,String fromDate,String toDate,String txnType) {
		DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();
		try{	
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
			Session s = AcqMerchantDaoImpl.getSession();
			Criteria criteria = s.createCriteria(AcqBankItTransactionEntity.class);
			criteria.add(Restrictions.eq("status","0"));
			if(merchantId!=null&&merchantId!=""&&merchantId.length()>0){
				criteria.add(Restrictions.eq("merchantId", Long.valueOf(merchantId)));
			}if(userId!=null&&userId!=""&&userId.length()>0){
				criteria.add(Restrictions.eq("userId", Long.valueOf(userId)));
			}if(fromDate!=null&&fromDate!=""){
			    String newFromDate = sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00";
			    if(toDate!=null&&toDate!=""){ 
					String newToDate= sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59";
				    criteria.add(Restrictions.between("dateTime",newFromDate,newToDate));
				}else{
					String stringToDate = sdfSource.format(new Date())+" 23:59:59";
				    criteria.add(Restrictions.between("dateTime",newFromDate,stringToDate));
			    }
			}
			criteria.addOrder(Order.desc("id"));
			List criteriaList = criteria.list();
			Iterator etr1 = criteriaList.iterator();	
			Iterator etr = criteriaList.iterator();	
			Iterator<AcqRechargeListEntity> itr2 = criteriaList.iterator();
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> singleMap=null;				
			Set<Integer> merchantSet = new HashSet<Integer>();
			HashMap<String,String> orgmap = null;
			HashMap<String,String> usermap = null;
			HashMap<String,String> merchantMap = null;
			Set<Long> userSet = new HashSet<Long>();
			System.out.println("CriteriaList"+criteriaList);				
				while(itr2.hasNext()){
					AcqRechargeListEntity txEntity = (AcqRechargeListEntity)itr2.next();
					userSet.add(Long.valueOf(txEntity.getSessionId()));
				}			
			if(userSet.isEmpty()){
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
					Criteria user =s.createCriteria(AcqUser.class);
				    ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("userId"));
				     proList.add(Projections.property("loginId"));
				     user.setProjection(proList);
				     user.add((Restrictions.in("userId", userSet)));
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
			while(etr.hasNext()){
				AcqBankItTransactionEntity entit = (AcqBankItTransactionEntity)etr.next();
				AcqUser user = (AcqUser) s.createCriteria(AcqUser.class).add(Restrictions.eq("userId", Long.valueOf(entit.getSessionId()))).uniqueResult();
				singleMap = new HashMap<String,String>();
				singleMap = new HashMap<String,String>();
			    singleMap.put("id",""+entit.getId());
				singleMap.put("amount",""+entit.getAmount());
				//singleMap.put("serviceType",""+entit.getServiceType());
				SimpleDateFormat sdfSourceDb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    SimpleDateFormat sdfDestinationDb = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			    singleMap.put("dateTime",""+sdfSourceDb.format(sdfDestinationDb.parse(entit.getDateTime())));
			    singleMap.put("userName", ""+user.getLoginId());
			   // singleMap.put("rechargeType", entit.getRechargeType());
			    singleMap.put("status", entit.getStatus());
			    singleMap.put("message", entit.getMessage());	
			    singleMap.put("subscriberId", entit.getMobileNo());	
			    globalList.add(singleMap);				    
			    System.out.println("singleMap:: "+singleMap);			 
			}			    
			logger.info("records are putted in map");
			globleMap.setResult(globalList);
			globleMap.setStatus(AcqStatusDefination.OK.getIdentifier());
			globleMap.setMessage(AcqStatusDefination.OK.getDetails());
			logger.info("Recharge list selected successfully");
			return globleMap;	
			
		}catch(Exception e){
			logger.info("error to select Recharge list"+e);
			return null;
		}
	
	}
	}

