package com.acq.web.dao.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
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
import java.util.UUID;
import java.util.WeakHashMap;

import javax.validation.ConstraintViolationException;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.acq.AcqBase;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.users.entity.AcqAddNewMerchantEntity;
import com.acq.users.entity.AcqDeviceAndUserEntity;
import com.acq.users.entity.AcqDsaEntity;
import com.acq.users.entity.AcqEmpPasswordEntity;
import com.acq.users.entity.AcqEmpRoleEntity;
import com.acq.users.entity.AcqGCMNotificationEntity;
import com.acq.users.entity.AcqInventoryDeviceEntity;
import com.acq.users.entity.AcqLoanDetails;
import com.acq.users.entity.AcqMobikwikEntity;
import com.acq.users.entity.AcqNewOrganizationEntity;
import com.acq.users.entity.AcqPrepaidInventoryDeviceEntity;
import com.acq.users.entity.AcqUserEntity;
import com.acq.users.entity.AcqWalletListEntity;
import com.acq.users.entity.PreBoardNewMerchantEntity;
import com.acq.users.model.AcqAppUser;
import com.acq.users.model.AcqDevice;
import com.acq.users.model.AcqDeviceMapUser;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization1;
import com.acq.users.model.AcqUser;
import com.acq.web.controller.model.AcqInventoryDeviceModel;
import com.acq.web.controller.model.AcqMerchantNewModel;
import com.acq.web.controller.model.AcqMerchantSearchModel;
import com.acq.web.controller.model.AcqNewDeviceDetailModel;
import com.acq.web.controller.model.AcqNewOrganization;
import com.acq.web.controller.model.AcqNewUpdateDeviceDetailModel;
import com.acq.web.controller.model.AcqNewUpdateMerchantModel;
import com.acq.web.controller.model.AcqNewUpdateOrgModel;
import com.acq.web.controller.model.AcqPrepaidInventoryDeviceModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.PreBoardNewMerchant;
import com.acq.web.dao.MerchantDaoInf;
import com.acq.web.dto.impl.DbDto;


@Repository
public class MerchantDao implements  MerchantDaoInf {
	
	
	@Autowired
	AcqMerchantDaoImpl AcqMerchantDaoImpl;
	
	final static Logger logger = Logger.getLogger(MerchantDao.class);
	
	@Value("#{AcqConfig['generateMerchant.location']}")
	private String mrchntDetails;
	public String getMrchntDetails(){
		return mrchntDetails;
	}
	@Transactional
	public DbDto<AcqPrepaidInventoryDeviceModel> addPrepaidInventory(AcqPrepaidInventoryDeviceModel model) {
		logger.info("Request landing in Add Prepaid inventory Device Dao");
		DbDto<AcqPrepaidInventoryDeviceModel> response = new DbDto<AcqPrepaidInventoryDeviceModel>();
		//Session session = null;
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			Transaction tx = session.beginTransaction();
			String dbCardNo=null;
			String banktid = null;			
			if (model.getCardNo() != null && model.getCardNo() != "") {
				dbCardNo = (String) session.createCriteria(AcqPrepaidInventoryDeviceEntity.class).setProjection(Projections.property("cardNo")).add(Restrictions.eq("cardNo",model.getCardNo())).uniqueResult();     
			}
			
			if ( (dbCardNo != null && dbCardNo != "")) {
				if (dbCardNo != null && dbCardNo != "") {
					logger.info("Card No. already in use with other account");
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage("Card No. Already Exist");
				}
			}else{
				AcqPrepaidInventoryDeviceEntity entity = new AcqPrepaidInventoryDeviceEntity();
				entity.setKitNo(model.getKitNo());
				entity.setCardNo(model.getCardNo());
				entity.setCardType(model.getCardType());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				entity.setDateTime(sdf.format(new Date()));
				entity.setStatus(model.getStatus());
				session.save(entity);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Prepaid Inventory Device Added Successfully");
			}   
		}catch (Exception e) {
		   response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		   response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   logger.error("error to add prepoaid inventory device"+e);
	   	}
		return response;
	}
	@Transactional
	public DbDto<List<HashMap<String, String>>> prepaidInventoryList(AcqSearchModel modell) {
		logger.info("Request is landing in dao for Inventory list");	
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();			
			Criteria tot = session.createCriteria(AcqPrepaidInventoryDeviceEntity.class);
			tot.setProjection(Projections.rowCount());
			Criteria tx=session.createCriteria(AcqPrepaidInventoryDeviceEntity.class);
			if(modell.getModelName()!=null&&modell.getModelName()!=""&&!(modell.getModelName()).equals("%41")){
				tx.add(Restrictions.eq("modelName", modell.getModelName()));
				tot.add(Restrictions.eq("modelName", modell.getModelName()));
			}if(modell.getSerialNo()!=null&&modell.getSerialNo()!=""&&!(modell.getSerialNo()).equals("%41")){
				tx.add(Restrictions.eq("inventorySerialNo", modell.getSerialNo()));
				tot.add(Restrictions.eq("inventorySerialNo", modell.getSerialNo()));
			}if(modell.getStatus()!=null&&modell.getStatus()!=""&&!(modell.getStatus()).equals("%41")){
				tx.add(Restrictions.eq("status", modell.getStatus()));
				tot.add(Restrictions.eq("status", modell.getStatus()));
			}
 			tx.addOrder(Order.desc("id"));
 			tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
			tx.setMaxResults(20);
			List criteriaList = tx.list();
			if(criteriaList.isEmpty()){
				map.put("1", "123");
				globalList.add(map);
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Inventory list is empty");
				return globleMap;			
			}
			System.out.println("modell.getWalletEmail()::"+modell.getWalletEmail());
			AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",modell.getWalletEmail())).uniqueResult();
			if(emp1==null){
				map.put("1", "123");
				globalList.add(map);
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("employee not found");
				return globleMap;
			}
			//System.out.println("modell.getWalletEmail()::"+modell.getWalletEmail());
			Iterator etr = criteriaList.iterator();	
			//Iterator<AcqInventoryDeviceEntity> itr2 = criteriaList.iterator();
			Iterator<AcqPrepaidInventoryDeviceEntity> itr = criteriaList.iterator();
			
			HashMap<String,String> singleMap=null;
			AcqPrepaidInventoryDeviceEntity entit = null;
			while(etr.hasNext()){
				entit = (AcqPrepaidInventoryDeviceEntity)etr.next();
				singleMap = new HashMap<String,String>();
				singleMap.put("id",""+entit.getId());
				if(entit.getCardType().equals("1")){
					singleMap.put("cardType","NFC/CHIP&MAG CARD");
					   
				}else if(entit.getCardType().equals("2")){
					singleMap.put("cardType","CHIP CARD");
					   
				}else if(entit.getCardType().equals("3")){
					singleMap.put("cardType","MAG CARD");
					   
				}else if(entit.getCardType().equals("4")){
					singleMap.put("cardType","OTHERS");
					   
				}
				singleMap.put("cardTypeNumber",entit.getCardType());
			     singleMap.put("cardNo",""+entit.getCardNo());
			    singleMap.put("kitNo",""+entit.getKitNo());
			    singleMap.put("status",""+entit.getStatus());
			    singleMap.put("empRole",""+emp1.getEmpRole());
			    globalList.add(singleMap);
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
			logger.info("Prepaid Inventory List selected successfully");
			return globleMap;			
		}catch(Exception e){
			logger.info("error to select Prepaid Inventory Device list"+e);
			return null;
		}
	}
	@Transactional
	public DbDto<AcqPrepaidInventoryDeviceModel> prepaidInventoryUpdateDevice(
			AcqPrepaidInventoryDeviceModel model) {
		DbDto<AcqPrepaidInventoryDeviceModel> response = new DbDto<AcqPrepaidInventoryDeviceModel>();
		logger.info("request landing in update Inventory Device Dao");		
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqPrepaidInventoryDeviceEntity AcqDevice = (AcqPrepaidInventoryDeviceEntity) session.createCriteria(AcqPrepaidInventoryDeviceEntity.class).add(Restrictions.eq("id",Long.valueOf(model.getId()))).uniqueResult();
			if (AcqDevice == null || AcqDevice + "" == "") {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Device not found for update");
			} else {
				AcqDevice.setCardNo(model.getCardNo());
				AcqDevice.setCardType(model.getCardType());
				AcqDevice.setKitNo(model.getKitNo());	
				AcqDevice.setStatus(model.getStatus());	
				DateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				AcqDevice.setDateTime(inputFormatter.format(new Date()));
				Transaction tx = session.beginTransaction();
				
				session.saveOrUpdate(AcqDevice);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Device successfully updated");   
			}   
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in Update Inventory Device " + e);
	 	}
		return response;
	 }
	
	@Transactional
	public DbDto<String> deletePreBoard(String id) {
		DbDto<String> response = new DbDto<String>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			PreBoardNewMerchantEntity AcqUser = (PreBoardNewMerchantEntity) session.get(PreBoardNewMerchantEntity.class,Integer.valueOf(id));
			if(AcqUser==null||AcqUser+""==""){
					logger.warn("device not found");
				}else{
				
				Transaction tx = session.beginTransaction();
				session.delete(AcqUser);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.error("Organization is successfully deleted");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
			logger.error("Error to delete pre board  and device :" + e);
		}
		return response;
	}
	
	
	@Transactional
		public DbDto<List<HashMap<String, String>>> merchantListPagination(String id) {
			logger.info("request in pre board mercCuhant list dao");
			DbDto<List<HashMap<String, String>>> response = new DbDto<List<HashMap<String,String>>>();
			List<HashMap<String,String>> merchantList = new ArrayList<HashMap<String,String>>();	
			try{
				Session session = AcqMerchantDaoImpl.getSession();
			Criteria tx=session.createCriteria(AcqWalletListEntity.class);
			Criteria tot=session.createCriteria(AcqWalletListEntity.class);	
			tx.addOrder(Order.desc("id"));
			tot.setProjection(Projections.rowCount());
			if(id==null){
				logger.info("Id is Null");
				tx.setFirstResult(Integer.valueOf(10));
			}if(id!=null){
				logger.info("Id is Not Null::"+id);
				tx.setFirstResult(Integer.parseInt(id));
			}
			List criteriaList = tx.list();
			tx.setMaxResults(10);
			tot.setMaxResults(10);
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
				Iterator<AcqWalletListEntity> itr2 = criteriaList.iterator();
				while(itr2.hasNext()){
					AcqWalletListEntity txEntity = (AcqWalletListEntity)itr2.next();
					merchantMap = new HashMap<String,String>();
					merchantMap.put("applicationNo",""+txEntity.getWalletId());
			        /*merchantMap.put("merchantName",""+txEntity.getMerchantName());
			        merchantMap.put("marketingName",""+txEntity.getMarketingName());
			        merchantMap.put("location",txEntity.getLocation());
			        merchantMap.put("executiveName",txEntity.getExecutiveName());
			        merchantMap.put("phoneNo",txEntity.getPhoneNo());
			        merchantMap.put("aquirerCode",txEntity.getAquirerCode());
			        //merchantMap.put("empRole",emp1.getEmpRole());
			        if(txEntity.getStatus().equalsIgnoreCase("oktoboard")){
			        	merchantMap.put("varificationStatus","Ok To Board");
			        }else{
			        	merchantMap.put("varificationStatus",txEntity.getStatus());
			        }*/
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
		
	
	
	@Transactional
	public DbDto<Object> preBoardNewMerchant(PreBoardNewMerchant model) {
		DbDto<Object> response = new DbDto<Object>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			 
				PreBoardNewMerchantEntity entity = new PreBoardNewMerchantEntity();
				entity.setMerchantName(model.getName());	
				entity.setKycCheck(model.getKycCheck());							
				entity.setMarketingName(model.getMarketingName());  
				entity.setPhoneNo(model.getPhoneNo());
				entity.setStatus(model.getStatus());
				entity.setLocation(model.getLocation());
				entity.setChequeNo(model.getChequeNo());
				entity.setAmount(model.getAmount());
				entity.setNote(model.getNote());	
				entity.setCubBranch(model.getCubBranch());
				entity.setNashNumber(model.getNashNumber());
				entity.setNashBankNAme(model.getNashBankNAme());
				entity.setSalesType(model.getSalesType());
				entity.setNachDate(model.getNachDate());
				if(model.getExecutiveName()!=null && model.getExecutiveName() != ""){
					entity.setExecutiveName(model.getExecutiveName());
				}else{
					entity.setExecutiveName("NA");
				}
				if(model.getEmployeeName()!=null && model.getEmployeeName() != ""){
					entity.setEmployeeName(model.getEmployeeName());
					
				}else{
					entity.setEmployeeName("NA");
				}
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				String date = sdfSource.format(new Date());
				entity.setCreated_on(date);
				entity.setAquirerCode("Acquiro");
				Transaction tx = session.beginTransaction();
				session.save(entity);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(entity.getId());
				logger.info("Pre b merchant added");
		} catch (NumberFormatException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem dao " + e);
		} catch (NullPointerException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in dao " + e);
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error "+ e);
			//System.out.println("error to Pre Boarded merchant"+e);
		}
		return response;
	}
	
	@Transactional
	public DbDto<Object> updatePreBoardMerchant(PreBoardNewMerchant model) {
		DbDto<Object> response = new DbDto<Object>();
		System.out.print("request landing in pre board merchant update dao");
		boolean update = false;
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			 
			PreBoardNewMerchantEntity entity = (PreBoardNewMerchantEntity) session.get(PreBoardNewMerchantEntity.class,Integer.parseInt(model.getId()));
			if (entity == null || entity + "" == "") {
				logger.info("mrchnt not found");
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
			} else {
				entity.setMerchantName(model.getName());	
				entity.setKycCheck(model.getKycCheck());							
				entity.setMarketingName(model.getMarketingName());  
				entity.setPhoneNo(model.getPhoneNo());
				entity.setStatus(model.getStatus());
				entity.setLocation(model.getLocation());
				entity.setChequeNo(model.getChequeNo());
				entity.setAmount(model.getAmount());
				entity.setNote(model.getNote());
				entity.setCubBranch(model.getCubBranch());
				entity.setSalesType(model.getSalesType());
				entity.setNashNumber(model.getNashNumber());
				entity.setNashBankNAme(model.getNashBankNAme());
				entity.setSalesType(model.getSalesType());
				entity.setNachDate(model.getNachDate());
				if(model.getEmployeeName()!=null && model.getEmployeeName() != ""){
					entity.setEmployeeName(model.getEmployeeName());
					
				}else{
					entity.setEmployeeName("NA");
				}
				if(model.getExecutiveName()!=null && model.getExecutiveName() != ""){
					entity.setExecutiveName(model.getExecutiveName());
				}else{
					entity.setExecutiveName("NA");
				}
				Transaction tx = session.beginTransaction();
				session.saveOrUpdate(entity);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(entity.getId());
				logger.info("pr mrchnt added");
			}
			} catch (NumberFormatException e) {
			logger.error("Wrong param value " + e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage("Number formate problem");
			response.setResult(""+update);
		} catch (Exception e){
			logger.error("Error in update pre brd mrchnt " + e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> downloadDeviceDetails(String fromDate,String toDate) {
		logger.info("request in download Device Details");
		DbDto<List<HashMap<String,String>>> response = new DbDto<List<HashMap<String,String>>>();
		List<HashMap<String, String>> globalMap= new ArrayList<HashMap<String, String>>();
		try{	
			Session session = AcqMerchantDaoImpl.getSession();
		   Criteria criteria = session.createCriteria(AcqInventoryDeviceEntity.class);
		   if(fromDate!=null&&fromDate!=""){
				SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				if(toDate!=null&&toDate!=""&&toDate.length()==10){	
					criteria.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00",sdfSource.format(sdfDestination.parse(toDate))+" 23:59:59"));
				}else{
					criteria.add(Restrictions.between("dateTime",sdfSource.format(sdfDestination.parse(fromDate))+" 00:00:00",sdfSource.format(new Date())+" 23:59:59"));
				}
			}
		    logger.info("date criteria puttd");
			List txList = criteria.list();
			if(txList.isEmpty()){
				response.setResult(globalMap);
				response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("there is no Device Details ");
			}else{
				logger.info("Device Details entity selected");
				Iterator<AcqInventoryDeviceEntity> itr1 = txList.iterator();
				Iterator<AcqInventoryDeviceEntity> itr2 = txList.iterator();
				HashMap<String,String> responseMap = null;
				
					while(itr1.hasNext()){
						responseMap = new HashMap<String,String>();
						AcqInventoryDeviceEntity txEntity = (AcqInventoryDeviceEntity)itr1.next();
						 responseMap.put("deviceId",""+txEntity.getInventoryDeviceId());
						 responseMap.put("serialNo",""+txEntity.getInventorySerialNo());
						 responseMap.put("modelName",""+txEntity.getModelName());
						 responseMap.put("status",""+txEntity.getStatus());
						 globalMap.add(responseMap);
					}
					
					response.setResult(globalMap);
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("list are selected");
			}	
		}catch (Exception e) {
			logger.error("error"+e);
			response.setResult(globalMap);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to download Device details report "+e);
		}
		return response;
	}

	
	
	@Transactional
	public DbDto<ArrayList<HashMap<String, String>>> downloadNonTxnMerchant(String noOfDays) {
		DbDto<ArrayList<HashMap<String, String>>> response = new DbDto<ArrayList<HashMap<String, String>>>();
		ArrayList<HashMap<String, String>> responseList = new ArrayList<HashMap<String, String>>();		
		logger.info("request in download non txn merchant");
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String fromDate = "";
		String toDate = "";
		Date date  = null;
		cal.add(Calendar.DATE,0);
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("one")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, 0);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("two")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -1);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("seven")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -6);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("ten")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -9);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("fifteen")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -14);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("thirty")){
				date = cal.getTime(); 
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -29);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("sixty")){
				date = cal.getTime(); 
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -59);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else if(noOfDays!=null&&noOfDays!=""&&noOfDays.equalsIgnoreCase("ninety")){
				date = cal.getTime();
				toDate = sdf.format(date)+ " 23:59:59";
				cal.add(Calendar.DATE, -89);
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
			}else{
				date = cal.getTime();
				fromDate = sdf.format(date)+ " 00:00:00";
				toDate = sdf.format(date)+ " 23:59:59";
			}
			Query query = session.createQuery("select userid,orgId,merchantId from AcqMobikwikEntity where status=505 and acquirer='Acquiro' and otpDateTime between :fromDate and :toDate").setParameter("fromDate", Timestamp.valueOf(fromDate)).setParameter("toDate", Timestamp.valueOf(toDate));
	        List myList = query.list();	        
	        Set<Long> userSet = new HashSet<Long>();
	        Set<Long> orgSet = new HashSet<Long>();
	        Set<Integer> merchantSet = new HashSet<Integer>();
	        for(Object obj : myList) {
	            Object[] row = (Object[]) obj;
	            System.out.println(row[0]+":a:"+row[1]+":b:"+row[2]);
	            userSet.add(Long.valueOf(""+row[0]));
	        }
	        System.out.println("userSet:"+userSet);
	       Query userQuery = null;	        
	        if(userSet.isEmpty()){
	        	 userQuery = session.createQuery("select u.userId,u.rmn,u.date,u.orgId,u.userStatus,e.bankTId from AcqUser u,AcqDevice e where u.userStatus='0' and u.aquirerCode='Acquiro' and u.userId=e.userId");
		    }else{
		    	userQuery = session.createQuery("select u.userId,u.rmn,u.date,u.orgId,u.userStatus,e.bankTId from AcqUser u,AcqDevice e where u.userStatus='0' and u.aquirerCode='Acquiro' and u.userId=e.userId and u.userId not in (:userIds)").setParameterList("userIds", userSet);
		    }	        
	        List<String> userList = userQuery.list();
	        HashMap<String,String> userIdOrgIdMap = new HashMap<String,String>();
	        HashMap<String,String> orgIdMerchantIdMap = new HashMap<String,String>();
	        HashMap<String,String> merchantIdNameMap = new HashMap<String,String>();
	        HashMap<String,String> orgIdNameMap = new HashMap<String,String>();
	        for(Object obj : userList) {
	        	Object[] row = (Object[])obj;
	        	userIdOrgIdMap.put("user"+row[0],""+row[3]);
	        	orgSet.add(Long.valueOf(""+row[3]));
	        }
	        if(userList.isEmpty()){
	        	 response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
	 	    	response.setMessage(AcqStatusDefination.NotFound.getDetails());
	 	    	response.setResult(responseList);
	 	    	return response;
	        }
	        logger.info("user/device selected");
	        Query orgQuery = session.createQuery("select orgId,name,merchantId from AcqOrganization1 where orgId in (:orgId)").setParameterList("orgId", orgSet);
	        List<String> orgList = orgQuery.list();
	        if(orgList.isEmpty()){
	        	 response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
	 	    	response.setMessage(AcqStatusDefination.NotFound.getDetails());
	 	    	response.setResult(responseList);
	 	    	return response;
	        }
	        for(Object obj : orgList) {
	        	Object[] row = (Object[])obj;
	        	merchantSet.add(Integer.valueOf(""+row[2]));
	        	orgIdMerchantIdMap.put(""+row[0],""+row[2]);
	        	orgIdNameMap.put("org"+row[0], ""+row[1]);
	        }
	        //logger.info("org selected");
	        Query merchantQuery = session.createQuery("select merchantId,merchantName from AcqMerchant where merchantId in (:merchantIds)").setParameterList("merchantIds", merchantSet);
	        List<String> merchantList = merchantQuery.list();
	        if(merchantList.isEmpty()){
	        	 response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
	 	    	response.setMessage(AcqStatusDefination.NotFound.getDetails());
	 	    	response.setResult(responseList);
	 	    	return response;
	        }
	        for(Object obj : merchantList) {
	        	Object[] row = (Object[])obj;
	        	merchantIdNameMap.put("merchantId"+row[0],""+row[1]);
	        }
	       HashMap<String, String> responseMap = null;
	        for(Object obj : userList) {
	        	Object[] row = (Object[])obj;
	        	responseMap = new HashMap<String, String>();
	        	if(merchantIdNameMap.get("merchantId"+orgIdMerchantIdMap.get(""+row[3]))!=null)
	        		responseMap.put("merchantName",merchantIdNameMap.get("merchantId"+orgIdMerchantIdMap.get(""+row[3])));
	        	else{
	        		responseMap.put("merchantName","NA");
	        	}        		
	        	if(orgIdNameMap.get("org"+row[3])!=null){
	        		responseMap.put("marketingName",orgIdNameMap.get("org"+row[3]));
	        	}else{
	        		responseMap.put("marketingName","NA");
	        	}
	        	responseMap.put("phoneNo",""+row[1]);
	        	responseMap.put("activationDate",(""+row[2]).substring(0,10));
	        	responseMap.put("bankTid",""+row[5]);
	        	responseList.add(responseMap);
	        }
	        logger.info("res from dao");
	        response.setStatus(AcqStatusDefination.OK.getIdentifier());
	    	response.setMessage(AcqStatusDefination.OK.getDetails());
	    	response.setResult(responseList);
	    	return response;
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
		    response.setMessage(AcqStatusDefination.NotFound.getDetails());
		    response.setResult(responseList);
		}
		return response;
	}
	
	
	
	
	
	@Transactional
	public DbDto<Object> downloadMerchantDtls(String merchantId) {
		DbDto<Object> response = new DbDto<Object>();
		try{ 
			Session session = AcqMerchantDaoImpl.getSession();
			if(merchantId!=null&&AcqNumericValidator.checkId(merchantId)){
				AcqMerchant entity = (AcqMerchant)session.get(AcqMerchant.class,Integer.valueOf(merchantId));
				if(entity!=null){
					XSSFWorkbook workbook = new XSSFWorkbook();
			        XSSFSheet sheet = workbook.createSheet("Merchant Data");			        
			        XSSFFont font = workbook.createFont();
			        font.setFontName(HSSFFont.FONT_ARIAL);
			        font.setUnderline((byte)1);
			        XSSFCellStyle style = workbook.createCellStyle();
			        style.setFont(font);
			        Row firstrow = sheet.createRow(0);
			        Cell cell1 = firstrow.createCell(0);
			        cell1.setCellValue("SCHEDULE1");
			        cell1.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A1:D1"));
			        
			        
			        Row row1 = sheet.createRow(1);
			        Row row2 = sheet.createRow(2);
			        Cell cell21 = row2.createCell(0);
			        cell21.setCellValue("MERCHANT INFORMATION");
			        cell21.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A3:D3"));			        
			        Row row3 = sheet.createRow(3);
			        Cell cell31 = row3.createCell(0);
			        Cell cell32 = row3.createCell(2);
			        cell31.setCellValue("Place");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A4:B4"));
			        if(entity.getDateCreated()==null)
			        	cell32.setCellValue("");
			        else
			        	cell32.setCellValue(entity.getBusinessState());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C4:D4"));
			        
			        Row row4 = sheet.createRow(4);
			        Cell cell41 = row4.createCell(0);
			        Cell cell42 = row4.createCell(2);
			        cell41.setCellValue("Date");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A5:B5"));
			        if(entity.getDateCreated()==null)
			        	cell42.setCellValue("");
			        else
			        	cell42.setCellValue(entity.getDateCreated());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C5:D5"));
			        
			        Row row5 = sheet.createRow(5);
			        Cell cell51 = row5.createCell(0);
			        Cell cell52 = row5.createCell(2);
			        cell51.setCellValue("Merchant Establishment Name");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A6:B6"));
			        if(entity.getMerchantName()==null)
			        	cell52.setCellValue("");
			        else
			        	cell52.setCellValue(entity.getMerchantName());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C6:D6"));
			        
			        Row row6 = sheet.createRow(6);
			        Cell cell61 = row6.createCell(0);
			        Cell cell62 = row6.createCell(2);
			        cell61.setCellValue("Name of Charge Slip");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A7:B7"));
			        if(entity.getMarketingName()==null)
			        	cell62.setCellValue("");
			        else
			        	cell62.setCellValue(entity.getMarketingName());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C7:D7"));
			        
			        Row row7 = sheet.createRow(7);
			        Cell cell71 = row7.createCell(0);
			        Cell cell72 = row7.createCell(2);
			        cell71.setCellValue("Nature of Business");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A8:B8"));
			        if(entity.getBusinessNature()==null)
			        	cell72.setCellValue("");
			        else			        	
			        	cell72.setCellValue(entity.getBusinessNature());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C8:D8"));
			        
			        Row row8 = sheet.createRow(8);
			        Cell cell81 = row8.createCell(0);
			        Cell cell82 = row8.createCell(2);
			        cell81.setCellValue("Merchant Business Type");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A9:B9"));
			        if(entity.getBusinessType()==null)
			        	cell82.setCellValue("");
			        else{
			        	if(entity.getBusinessType().equals("1")){
			        		cell82.setCellValue("Sole proprietor concern"); 
			        	}if(entity.getBusinessType().equals("2")){
			        		cell82.setCellValue("Government Controlled/Owned"); 
			        	}if(entity.getBusinessType().equals("3")){
			        		cell82.setCellValue("Partnership Concern"); 
			        	}if(entity.getBusinessType().equals("4")){
			        		cell82.setCellValue("private/public Ltd company"); 
			        	}if(entity.getBusinessType().equals("5")){
			        		cell82.setCellValue("HUF"); 
			        	}if(entity.getBusinessType().equals("6")){
			        		cell82.setCellValue("Others"); 
			        	}
			        }
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C9:D9"));
			        logger.info("sheet is going fill 1");
			        Row row10= sheet.createRow(9);
			        Cell cell101 = row10.createCell(0);
			        cell101.setCellValue("Legal Address(Com Register address)");
			        cell101.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A10:D10"));
			        
			        Row row11 = sheet.createRow(10);
			        Cell cell111 = row11.createCell(0);
			        Cell cell112 = row11.createCell(2);
			        cell111.setCellValue("Legal Name");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A11:B11"));
			        if(entity.getMerchantName()==null)
			        	cell112.setCellValue("");
			        else
			        	cell112.setCellValue(entity.getMerchantName());
			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C11:D11"));
			        Row row12 = sheet.createRow(11);
			        Cell cell121 = row12.createCell(0);
			        Cell cell122 = row12.createCell(2);
			        cell121.setCellValue("Street 1");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A12:B12"));
			        if(entity.getBusinessAddress1()==null)
			        	cell122.setCellValue("");
			        else
			        	cell122.setCellValue(entity.getBusinessAddress1());
			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C12:D12"));
			        
			        Row row13 = sheet.createRow(12);
			        Cell cell131 = row13.createCell(0);
			        Cell cell132 = row13.createCell(2);			        
			        cell131.setCellValue("Street 2");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A13:B13"));
			        if(entity.getBusinessAddress2()==null)
			        	cell132.setCellValue("");
			        else
			        	cell132.setCellValue(entity.getBusinessAddress2());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C13:D13"));
			        
			        Row row14 = sheet.createRow(13);
			        Cell cell141 = row14.createCell(0);
			        Cell cell142 = row14.createCell(2);
			        cell141.setCellValue("Locality");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A14:B14"));
			        if(entity.getBusinessCity()==null)
			        	cell142.setCellValue("");
			        else
			        	cell142.setCellValue(entity.getBusinessCity());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C14:D14"));
			        
			        Row row15 = sheet.createRow(14);
			        Cell cell151 = row15.createCell(0);
			        Cell cell152 = row15.createCell(2);
			        cell151.setCellValue("City");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A15:B15"));
			        if(entity.getBusinessCity()==null)
			        	cell152.setCellValue("");
			        else
			        	cell152.setCellValue(entity.getBusinessCity());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C15:D15"));
			      //  logger.info("sheet is going fill 3");
			        Row row16 = sheet.createRow(15);
			        Cell cell161 = row16.createCell(0);
			        Cell cell162 = row16.createCell(2);
			        cell161.setCellValue("PIN");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A16:B16"));
			        if(entity.getBusinessPincode()==null)
			        	cell162.setCellValue("");
			        else
			        	cell162.setCellValue(entity.getBusinessPincode().toString());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C16:D16"));
			        
			        Row row17= sheet.createRow(16);
			        Cell cell171 = row17.createCell(0);
			        cell171.setCellValue("DBA Address(Where Machine will be installed)");
			        cell171.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A17:D17"));
			        Row row18 = sheet.createRow(17);
			        Cell cell181 = row18.createCell(0);
			        Cell cell182 = row18.createCell(2);			        
			        cell181.setCellValue("DBA Name(On Chargeslip)");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A18:B18"));
			        if(entity.getMarketingName()==null)
			        	cell182.setCellValue("");
			        else
			        	cell182.setCellValue(entity.getMarketingName());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C18:D18"));
			        
			        Row row19 = sheet.createRow(18);
			        Cell cell191 = row19.createCell(0);
			        Cell cell192 = row19.createCell(2);
			        cell191.setCellValue("Street 1");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A19:B19"));
			        if(entity.getBusinessAddress1()==null)
			        	cell192.setCellValue("");
			        else
			        	cell192.setCellValue(entity.getBusinessAddress1());
			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C19:D19"));
			        
			        Row row20 = sheet.createRow(19);
			        Cell cell201 = row20.createCell(0);
			        Cell cell202 = row20.createCell(2);
			        cell201.setCellValue("Street 2");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A20:B20"));
			        if(entity.getBusinessAddress2()==null)
			        	cell202.setCellValue("");
			        else
			        	cell202.setCellValue(entity.getBusinessAddress2());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C20:D20"));
			       Row row21 = sheet.createRow(20);
			        Cell cell211 = row21.createCell(0);
			        Cell cell212 = row21.createCell(2);
			        cell211.setCellValue("Locality");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A21:B21"));
			        if(entity.getBusinessCity()==null)
			        	cell212.setCellValue("");
			        else
			        	cell212.setCellValue(entity.getBusinessCity());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C21:D21"));
			        
			        Row row22 = sheet.createRow(21);
			        Cell cell221 = row22.createCell(0);
			        Cell cell222 = row22.createCell(2);
			        cell221.setCellValue("City");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A22:B22"));
			        if(entity.getPersonalUserCity()==null)
			        	cell222.setCellValue("");
			        else
			        	cell222.setCellValue(entity.getPersonalUserCity());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C22:D22"));
			        
			        Row row23 = sheet.createRow(22);
			        Cell cell231 = row23.createCell(0);
			        Cell cell232 = row23.createCell(2);
			        cell231.setCellValue("PIN");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A23:B23"));
			        if(entity.getBusinessPincode()==null)
			        	cell232.setCellValue("");
			        else
			        	cell232.setCellValue(entity.getBusinessPincode().toString());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C23:D23"));
			        logger.info("sheet is going fill 6");
			        Row row24= sheet.createRow(23);
			        Cell cell241 = row24.createCell(0);
			        cell241.setCellValue("Name, Residental Address And Contact Information of Agreement Signatory");
			        cell241.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A24:D24"));
			        
			        Row row25 = sheet.createRow(24);
			        Cell cell251 = row25.createCell(0);
			        Cell cell252 = row25.createCell(2);
			        cell251.setCellValue("Authorised Signatory");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A25:B25"));
			        if(entity.getAuthorizedSignatory()==null)
			        	cell252.setCellValue("");
			        else
			        	cell252.setCellValue(entity.getAuthorizedSignatory());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C25:D25"));
			        
			        Row row26 = sheet.createRow(25);
			        Cell cell261 = row26.createCell(0);
			        Cell cell262 = row26.createCell(2);
			        cell261.setCellValue("Street 1");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A26:B26"));
			        if(entity.getPersonalUserAddress1()==null)
			        	cell262.setCellValue("");
			        else
			        	cell262.setCellValue(entity.getPersonalUserAddress1());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C26:D26"));
			        Row row27 = sheet.createRow(26);
			        Cell cell271 = row27.createCell(0);
			        Cell cell272 = row27.createCell(2);
			        cell271.setCellValue("Street 2");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A27:B27"));
			       // System.out.println("entity.getPersonalAddress2()::::"+entity.getPersonalAddress2());
			        if(entity.getPersonalUserAddress2()==null)
			        	cell272.setCellValue("");
			        else
			        	cell272.setCellValue(entity.getPersonalUserAddress2());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C27:D27"));
			        logger.info("sheet is fill 7");
			        Row row28 = sheet.createRow(27);
			        Cell cell281 = row28.createCell(0);
			        Cell cell282 = row28.createCell(2);
			        cell281.setCellValue("Locality");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A28:B28"));
			        if(entity.getPersonalUserCity()==null)
			        	cell282.setCellValue("");
			        else
			        	cell282.setCellValue(entity.getPersonalUserCity());
			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C28:D28"));
			        
			        Row row29 = sheet.createRow(28);
			        Cell cell291 = row29.createCell(0);
			        Cell cell292 = row29.createCell(2);
			        cell291.setCellValue("City");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A29:B29"));
			        if(entity.getPersonalUserCity()==null)
			        	cell292.setCellValue("");
			        else
			        	cell292.setCellValue(entity.getPersonalUserCity());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C29:D29"));
			        
			        Row row30 = sheet.createRow(29);
			        Cell cell301 = row30.createCell(0);
			        Cell cell302 = row30.createCell(2);
			        cell301.setCellValue("PIN");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A30:B30"));
			        if(entity.getBusinessPincode()==null)
			        	cell302.setCellValue("");
			        else
			        	cell302.setCellValue(entity.getBusinessPincode().toString());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C30:D30"));
			        logger.info("sheet is going fill 8");
			        Row row31= sheet.createRow(30);
			        Cell cell311 = row31.createCell(0);
			        cell311.setCellValue("SERVICE INFORMATION");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A31:D31"));			        
			        
			        Row row32 = sheet.createRow(31);
			        Cell cell321 = row32.createCell(0);
			        Cell cell322 = row32.createCell(2);
			        cell321.setCellValue("Type, Model");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A32:B32"));
			        cell322.setCellValue("MPOS , BB50");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C32:D32"));
			        
			        Row row33 = sheet.createRow(32);
			        Cell cell331 = row33.createCell(0);
			        Cell cell332 = row33.createCell(2);
			        cell331.setCellValue("Number Of Equipment(s)");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A33:B33"));
			        cell332.setCellValue("1");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C33:D33"));
			        logger.info("sheet is going fill 9");
			        Row row34 = sheet.createRow(33);
			        Cell cell341 = row34.createCell(0);
			        Cell cell342 = row34.createCell(2);
			        cell341.setCellValue("Serial Number of Equipment(s)");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A34:B34"));
			        cell342.setCellValue("");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C34:D34"));
			        
			        Row row35= sheet.createRow(34);
			        Cell cell351 = row35.createCell(0);
			        cell351.setCellValue("SUPER MERCHANT INFORMATION");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A35:D35"));
			        cell351.setCellStyle(style);
			        
			        Row row36 = sheet.createRow(35);
			        Cell cell361 = row36.createCell(0);
			        Cell cell362 = row36.createCell(2);
			        cell361.setCellValue("Name");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A36:B36"));
			        cell362.setCellValue("Acquiro Business Solutions Private Limited");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C36:D36"));
			        
			        Row row37 = sheet.createRow(36);
			        Cell cell371 = row37.createCell(0);
			        Cell cell372 = row37.createCell(2);
			        cell371.setCellValue("Landline");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A37:B37"));
			        cell372.setCellValue("91-124-4047613");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C37:D37"));
			        
			        Row row38 = sheet.createRow(37);
			        Cell cell381 = row38.createCell(0);
			        Cell cell382 = row38.createCell(2);
			        cell381.setCellValue("Mobile");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A38:B38"));
			        cell382.setCellValue("9899494604".toString());
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C38:D38"));
			        logger.info("sheet is going fill 10");
			        Row row39 = sheet.createRow(38);
			        Cell cell391 = row39.createCell(0);
			        Cell cell392 = row39.createCell(2);
			        cell391.setCellValue("Email");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A39:B39"));
			        cell392.setCellValue("operations@Acquiro.com");
			        sheet.addMergedRegion(CellRangeAddress.valueOf("C39:D39"));
			        
			        Row row40 = sheet.createRow(39);
			        Cell cell401 = row40.createCell(0);
			        Cell cell402 = row40.createCell(1);
			        Cell cell403 = row40.createCell(2);
			        Cell cell404 = row40.createCell(3);
			        cell401.setCellValue("Name of Bank");
			        cell402.setCellValue("RBL Bank Limited");
			        cell403.setCellValue("Branch");
			        cell404.setCellValue("Gurgaon");
			        
			        Row row41 = sheet.createRow(40);
			        Cell cell411 = row41.createCell(0);
			        Cell cell412 = row41.createCell(1);
			        Cell cell413 = row41.createCell(2);
			        Cell cell414 = row41.createCell(3);
			        cell411.setCellValue("IFSC Code");
			        cell412.setCellValue("RATN0000116");
			        cell413.setCellValue("Account Number");
			        cell414.setCellValue("409000450880");
			        
			        Row row42= sheet.createRow(41);
			        Cell cell421 = row42.createCell(0);
			        cell421.setCellValue("OTHER INFORMATION");
			        cell421.setCellStyle(style);
			        sheet.addMergedRegion(CellRangeAddress.valueOf("A42:D42"));
			        
			        Row row43 = sheet.createRow(42);
			        Cell cell431 = row43.createCell(0);
			        Cell cell432 = row43.createCell(1);
			        cell431.setCellValue("Acquiro ERP Application No");			       
			        cell432.setCellValue(entity.getMerchantId().toString());			        
			        sheet.addMergedRegion(CellRangeAddress.valueOf("B43:D43"));
			        
			        try{
			           FileOutputStream out = new FileOutputStream(new File(mrchntDetails+File.separator+"SCHEDULE Prop.xlsx"));
			            workbook.write(out);
			            out.close();
			        }catch (Exception e){
			            logger.error("error to generate excle file "+e);
			        }
			        response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("created, going return");
				}else{
					logger.info("not exist");
					response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					response.setResult(null);
				}
			}else{
				logger.info("Wrong dets");
				response.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				response.setMessage("Wrong details");
				response.setResult(null);
			}
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			response.setResult(null);
			logger.error("error "+e);
		}
		return response;
	}
	
	
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> executivesList() {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			 
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		    Criteria tx= session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("empRole", "5"));				
			List list = tx.list();
			Iterator etr = list.iterator();	
			HashMap merchantMap=null;
			while(etr.hasNext()){
				merchantMap = new HashMap<String, String>();
				AcqEmpRoleEntity txEntity = (AcqEmpRoleEntity)etr.next();
				merchantMap.put("executiveEmail",""+txEntity.getEmailId()); 
				merchantMap.put("executiveName",""+txEntity.getName()); 
				merchantMap.put("executiveId",""+txEntity.getId()); 
				globalList.add(merchantMap);  
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
	public DbDto<List<HashMap<String, String>>> empexecutivesList() {
		DbDto<List<HashMap<String,String>>> global = new DbDto<List<HashMap<String,String>>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			 
			List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		    Criteria tx= session.createCriteria(AcqDsaEntity.class);				
			List list = tx.list();
			Iterator etr = list.iterator();	
			HashMap merchantMap=null;
			while(etr.hasNext()){
				merchantMap = new HashMap<String, String>();
				AcqDsaEntity txEntity = (AcqDsaEntity)etr.next();
				merchantMap.put("executiveName",""+txEntity.getName()); 
				merchantMap.put("executiveId",""+txEntity.getId());
				globalList.add(merchantMap);  
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
	public DbDto<Object> getBankTid(String serialNo) {
		DbDto<Object> response = new DbDto<Object>();
		HashMap<String,String> singleMap=null;
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			AcqInventoryDeviceEntity bankTid = (AcqInventoryDeviceEntity)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo",serialNo)).uniqueResult();
			if(bankTid.equals("")&&bankTid.equals(null)){
				logger.info("Tid not found");
			}else{
				singleMap= new HashMap<String,String>();
				singleMap.put("bankTid","");
				logger.info("tid selected");
			}
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(singleMap);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error :" + e);
		}
		return response;
	}
	
	
	
	
	
	@Transactional
	public DbDto<Object> deviceList(String deviceId){
		DbDto<Object> response = new DbDto<Object>();
		List<String> list =  new ArrayList<String>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			List<AcqInventoryDeviceEntity> AcqDevice = (List<AcqInventoryDeviceEntity>)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("status","Available")).list();
			if(AcqDevice.isEmpty()){
				logger.info("device not found");
			}else{
				for(AcqInventoryDeviceEntity entity : AcqDevice){
					list.add(entity.getInventorySerialNo());
				}
				logger.info("available dv list selected");
			}
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(list);
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in tid list :" + e);
		}
		return response;
	}
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> selectTidAndMerchant(AcqMerchantSearchModel model) {
		DbDto<List<HashMap<String, String>>> response = new DbDto<List<HashMap<String, String>>>();
		List<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			//logger.info("request in select tid and merchant dao.");
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			cal.set(Calendar.MILLISECOND, 0);
			cal.add(Calendar.DAY_OF_YEAR,-1);
			Timestamp oneDayBefore = new Timestamp(cal.getTime().getTime());
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			cal.add(Calendar.MONTH,-3);
			Timestamp threeMonthBefore = new Timestamp(cal.getTime().getTime());
			List<String> txnTypeList = new ArrayList<String>();
			txnTypeList.add("CARD");txnTypeList.add("VOID");txnTypeList.add("CASHATPOS");txnTypeList.add("CVOID");
			List<AcqMobikwikEntity> entity = (List<AcqMobikwikEntity>)session.createCriteria(AcqMobikwikEntity.class).add(Restrictions.between("otpDateTime", threeMonthBefore, oneDayBefore)).add(Restrictions.eq("status",505)).add(Restrictions.eq("payoutStatus",700)).add(Restrictions.in("txnType", txnTypeList)).list();
			HashMap<String, String> userIdMerchantIdMap = new HashMap<String,String>();
			HashSet<Integer> merhantIdSet = new HashSet<Integer>();
			HashSet<Long> userSet = new HashSet<Long>();
			for(AcqMobikwikEntity ent:entity){
				merhantIdSet.add(Integer.valueOf(""+ent.getMerchantId()));
				userSet.add(Long.valueOf(""+ent.getUserid()));
				userIdMerchantIdMap.put(""+ent.getUserid(),""+ ent.getMerchantId());
			}
			ProjectionList p1=Projections.projectionList();
	        p1.add(Projections.property("merchantId"));
	        p1.add(Projections.property("merchantName"));
			Criteria mchntCreteria = (Criteria)session.createCriteria(AcqMerchant.class).setProjection(p1);
			if(model.getMerchantName()!=null&&model.getMerchantName()!=""&&model.getMerchantName().length()>0){
				mchntCreteria.add(Restrictions.like("merchantName",model.getMerchantName()+"%"));
			}else{
				mchntCreteria.add(Restrictions.in("merchantId",merhantIdSet));
			}
			List list = mchntCreteria.list();
			HashMap<String,String> merchantMap = new HashMap<String,String>();
			for(Object obj:list){
				Object[] ob=(Object[]) obj;
				//System.out.println(ob[0]+":=merchant==:"+ob[1]);
				merchantMap.put(""+ob[0],""+ob[1]);
			}
			//System.out.println("merchantMap: "+merchantMap);
			
			Criteria usrCreteria = (Criteria)session.createCriteria(AcqDeviceAndUserEntity.class);
			if(model.getBankTid()!=null&&model.getBankTid()!=""&&model.getBankTid().length()>0){
				usrCreteria.add(Restrictions.eq("bankTid",model.getBankTid()));
			}else{
				usrCreteria.add(Restrictions.in("userId",userSet));
			}
			logger.info("list is selected");
			List list1 = usrCreteria.list();
			//System.out.println("list1 list1:"+list1.size());
			HashMap<String,String> map = null;
			Iterator<AcqDeviceAndUserEntity> itr = list1.iterator();
			while(itr.hasNext()){
				map = new HashMap<String,String>();				
				AcqDeviceAndUserEntity ent = (AcqDeviceAndUserEntity)itr.next();
				if(merchantMap.get(""+userIdMerchantIdMap.get(""+ent.getUserId()))==null||merchantMap.get(""+userIdMerchantIdMap.get(""+ent.getUserId()))==""){
					//System.out.println("merchant not for this tid");
				}else{
					map.put("merchantName", merchantMap.get(""+userIdMerchantIdMap.get(""+ent.getUserId())));
					map.put("tid", ""+ent.getBankTid());
					AcqUserEntity enti = ent.getAcqUserEntity();
					map.put("rmn", ""+enti.getRmn());
					//System.out.println("enti::::::::"+enti.getRmn());
					result.add(map);
				}
			}
			//System.out.println("result: "+result);
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(result);
			return response;
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			response.setResult(result);
			return response;
		}
	}
	
	@Transactional
	public DbDto<Object> updatedevicedetail(AcqNewUpdateDeviceDetailModel model) {
		DbDto<Object> response = new DbDto<Object>();
		SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
		Date midTidDate = null;
		Date wlcmSendLtrDate = null;


		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqAppUser AcqUser = (AcqAppUser) session.get(AcqAppUser.class,
					Long.valueOf(model.getDeviceID()));
			AcqDeviceMapUser device = AcqUser.getDeviceMapUser();
			if (AcqUser == null || AcqUser + "" == "") {
				response.setMessage(AcqStatusDefination.NotFound
						.getDetails());
				return response;
			} else {
				Date validdate = sdfSource1.parse(device.getValidTil());
				List<String> detailsList = new ArrayList<String>(); 
				detailsList.add(0,""+device.getRent());
				detailsList.add(1,device.getPaymentMode());
				detailsList.add(2,""+device.getPendingRent());
				detailsList.add(3,""+device.getPenaltyAmount());
				detailsList.add(4,""+device.getPenaltyReason());
				detailsList.add(5,""+device.getDiscount());
				detailsList.add(6,""+device.getDiscountReason());
				detailsList.add(7,""+device.getAvgTxnAmount());
				detailsList.add(8,""+device.getMdrDebit1());
				detailsList.add(9,""+device.getMdrDebit2());
				detailsList.add(10,""+device.getMdrCreditPre());
				detailsList.add(11,""+device.getMdrCreditNpre());
				detailsList.add(12,""+device.getMdrMobiKwik());
				detailsList.add(13,""+device.getMdrCashAtPos());
				detailsList.add(14,""+device.getOther());
				detailsList.add(15,""+device.getBankAccName());
				detailsList.add(16,""+device.getBankAccNo());
				detailsList.add(17,""+device.getBankName());
				detailsList.add(18,""+device.getBenefName());
				detailsList.add(19,""+device.getBankBranch());
				detailsList.add(20,""+device.getBankMicr());
				detailsList.add(21,""+device.getBankIfsc());
				detailsList.add(22,""+device.getMdrAmex());
				detailsList.add(23,""+device.getUpdateAmexTID());	
				detailsList.add(24,sdfSource1.format(validdate));
				detailsList.add(25,""+device.getMdrDebit0());
				if (model.getLoginId().equals("" + AcqUser .getLoginId())) {
					logger.info("Users Id is not changed");
				} else {
					Long updateloginid = (Long) session
							.createCriteria(AcqAppUser.class)
							.setProjection(Projections.property("loginId"))
							.add(Restrictions.eq("loginId",Long.valueOf(model.getLoginId())))
							.uniqueResult();
					if (updateloginid != null && updateloginid > 0) {
						response.setStatus(AcqStatusDefination.RollBackError
								.getIdentifier());
						response.setMessage("Users Id Already Exist");
						return response;
					} else {
						AcqUser.setLoginId(Long.valueOf(model.getLoginId()));
					}
				}
				if(model.getUserType().equalsIgnoreCase("wallet")){				
					String serialNo = device.getSerialNo();
				       if(!serialNo.equals(null)&&!serialNo.equals("NA")){
				             AcqInventoryDeviceEntity ent2 = (AcqInventoryDeviceEntity)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo",device.getSerialNo())).uniqueResult();
				           if(ent2!=null&&ent2+""!=""){
				          ent2.setStatus("Available");
				             session.saveOrUpdate(ent2); 
				           }else{
				            logger.info("Device Not Found");
				           }
				        }
					device.setSerialNo("NA");					
				}else{
				if (model.getSerialNo().equals("" + device.getSerialNo())) {

					logger.info("Serial is not changed");
				} else {
					String dbserialNo = (String) session.createCriteria(AcqDeviceMapUser.class).setProjection(Projections.property("serialNo")).add(Restrictions.eq("serialNo",model.getSerialNo())).uniqueResult();
					if (dbserialNo != null && dbserialNo != "") {
						response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
						response.setMessage("Device Serial No. Already Exist");
						return response;
					} else {						
						if(model.getUserType().equalsIgnoreCase("credit")|| model.getUserType().equalsIgnoreCase("wallet/credit")){
						       AcqInventoryDeviceEntity ent = (AcqInventoryDeviceEntity)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo",model.getSerialNo())).uniqueResult();
						       ent.setStatus("Inuse");
						      session. saveOrUpdate(ent);
						       String serialNo = device.getSerialNo();
					           if(!serialNo.equals(null)&&!serialNo.equals("NA")){
							       AcqInventoryDeviceEntity ent1 = (AcqInventoryDeviceEntity)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo",device.getSerialNo())).uniqueResult();
							      if(ent1 != null && ent1 +"" != ""){
							    	  ent1.setStatus("Available");
							    	 session. saveOrUpdate(ent1);
							      }else{
							    	  logger.info("Device not available for update");
							      }
					           }						
							}
							device.setSerialNo(model.getSerialNo());
						}				
					}
				}
				if(!(model.getUserType()).equals("wallet")){
					if (model.getBankTid().equals("" + device.getBankTId())) {
					} else {
						String banktid = (String) session
								.createCriteria(AcqDeviceMapUser.class)
								.setProjection(Projections.property("bankTId"))
								.add(Restrictions.eq("bankTId",
										model.getBankTid())).uniqueResult();
						if (banktid != null && banktid != "") {
							response.setStatus(AcqStatusDefination.RollBackError
									.getIdentifier());
							response.setMessage("Bank Tid Already Exist");
							return response;
						} else {
							device.setBankTId(model.getBankTid());
						}
					}
				}else{
					device.setBankTId("NA");
				}

				AcqUser.setRmn(Long.valueOf(model.getRmn()));
				AcqUser.setUserName(model.getName());
				AcqUser.setEmailId(model.getEmailId());
				if(model.getSwitchType()!=null){
					AcqUser.setSwitchType(model.getSwitchType());
				}
				if(model.getUserStatus()==null||model.getUserStatus()==""||model.getUserStatus().equals("0")){
					AcqUser.setUserStatus("0");
				}else{
					AcqUser.setUserStatus(model.getUserStatus());
				}
				if(model.getLoyaltyStatus()==null||model.getLoyaltyStatus()==""||model.getLoyaltyStatus().equals("0")){
					AcqUser.setLoyaltyStatus("0");
				}else{
					AcqUser.setLoyaltyStatus(model.getLoyaltyStatus());
				}
				if(model.getCloseWalletStatus()==null||model.getCloseWalletStatus()==""||model.getCloseWalletStatus().equals("0")){
					AcqUser.setCloseWalletStatus("0");
				}else{
					AcqUser.setCloseWalletStatus(model.getCloseWalletStatus());
				}
				if(model.getTxnSmsStatus()==null||model.getTxnSmsStatus()==""||model.getTxnSmsStatus().equals("0")){
					AcqUser.setTxnSmsStatus("0");
				}else{
					AcqUser.setTxnSmsStatus(model.getTxnSmsStatus());
				}
				AcqUser.setPpcServiceEnable(model.getPpcServiceEnable());
				AcqUser.setDmtServiceEnable(model.getDmtServiceEnable());
				AcqUser.setDthMobileServiceEnable(model.getDthMobileServiceEnable());
				device.setRent(new BigDecimal(model.getRent()));
				device.setPaymentMode(model.getPaymentMode());
				device.setUserType(model.getUserType());
				if (model.getMdrDebit0() == null || model.getMdrDebit0() == "") {
					device.setMdrDebit0(new BigDecimal("0"));
				} else {
					device.setMdrDebit0(new BigDecimal(model.getMdrDebit0()));
				}
				if (model.getMdrDebit1() == null || model.getMdrDebit1() == "") {
					device.setMdrDebit1(new BigDecimal("0"));
				} else {
					device.setMdrDebit1(new BigDecimal(model.getMdrDebit1()));
				}
				if (model.getMdrDebit2() == null || model.getMdrDebit2() == "") {
					device.setMdrDebit2(new BigDecimal("0"));
				} else {
					device.setMdrDebit2(new BigDecimal(model.getMdrDebit2()));
				}
				if (model.getMdrCreditNpre() == null
						|| model.getMdrCreditNpre() == "") {
					device.setMdrCreditNpre(new BigDecimal("0"));
				} else {
					device.setMdrCreditNpre(new BigDecimal(model
							.getMdrCreditNpre()));
				}
				if (model.getMdrCreditPre() == null
						|| model.getMdrCreditPre() == "") {
					device.setMdrCreditPre(new BigDecimal("0"));

				} else {
					device.setMdrCreditPre(new BigDecimal(model
							.getMdrCreditPre()));
				}
				if (model.getMdrMobiKwik() == null
						|| model.getMdrMobiKwik() == "") {
					device.setMdrMobiKwik(new BigDecimal("0"));

				} else {
					device.setMdrMobiKwik(new BigDecimal(model.getMdrMobiKwik()));
				}
				if (model.getMdrAmex() == null || model.getMdrAmex() == "") {
					device.setMdrAmex(new BigDecimal("0"));
				} else {
					device.setMdrAmex(new BigDecimal(model.getMdrAmex()));
				}
				if (model.getOther() == null || model.getOther() == "") {
					device.setOther(new BigDecimal("0"));
				} else {
					device.setOther(new BigDecimal(model.getOther()));
				}
				if (model.getIntegrationKey() == null || model.getIntegrationKey() == ""|| model.getIntegrationKey().length()<1) {
					device.setIntegrationKey("NA");
				} else {
					device.setIntegrationKey(model.getIntegrationKey());
				}
				device.setMdrDebit0(new BigDecimal(model.getMdrZero()));
				device.setBankName(model.getBankName());
				device.setBenefName(model.getBenefName());
				device.setBankBranch(model.getBranchName());
				device.setBankAccNo(model.getBankAccountNo());
				device.setBankIfsc(model.getBankIfsc());
				device.setBankMicr(model.getBankMicr());
				device.setBankAccName(model.getBankAccountType());
				
				Date validTilDate = sdfDestination1.parse(model.getValidTil());
				
				String validTil = sdfSource1.format(validTilDate);
				device.setValidTil("" + validTil);
				device.setPendingRent(new BigDecimal(model.getPendingRent()));
				if(model.getDiscount().equals(null)||model.getDiscount().equals("")){
					device.setDiscount(new BigDecimal("0.000"));
				}else{
					device.setDiscount(new BigDecimal(model.getDiscount()));					
				}
				if(model.getDiscountReason()==null||model.getDiscountReason()==""){
					device.setDiscountReason("NA");
				}else{
					device.setDiscountReason(model.getDiscountReason());
				}				
				if (model.getSettlementCharges() == null || model.getSettlementCharges() == "") {
					device.setSettlementCharges(new BigDecimal("0"));
				} else {
					device.setSettlementCharges(new BigDecimal(model
							.getSettlementCharges()));
				}
				if(model.getPenaltyAmount().equals(null)||model.getPenaltyAmount().equals("")){
					device.setPenaltyAmount(new BigDecimal("0.000"));
				}else{
					device.setPenaltyAmount(new BigDecimal(model.getPenaltyAmount()));				
				}if(model.getPenaltyReason()==null||model.getPenaltyReason()==""){
					device.setPenaltyReason("NA");
				}else{
					device.setPenaltyReason(model.getPenaltyReason());
				}
				
				if(model.getAvgTxnAmount().equals(null)|| model.getAvgTxnAmount().equals("")){
				     device.setAvgTxnAmount(new BigDecimal("0.000"));
				}else{
				     device.setAvgTxnAmount(new BigDecimal(model.getAvgTxnAmount()));    
				}
				
				if (model.getMdrAmex() == null || model.getMdrAmex() == "") {
					device.setMdrAmex(new BigDecimal("0"));
				} else {
					device.setMdrAmex(new BigDecimal(model.getMdrAmex()));
				}
				if (model.getUpdateAmexActivated().equals("NO")
						|| model.getUpdateAmexActivated().equals("YES")) {
					device.setUpdateAmexActivated(model
							.getUpdateAmexActivated());
				}
				if (model.getUpdateAmexTID() != null
						&& model.getUpdateAmexTID() != "") {
					device.setUpdateAmexTID(model.getUpdateAmexTID());
				} else {
					device.setUpdateAmexTID("NA");
				}
				if (model.getUpdateAmexMID() != null
						&& model.getUpdateAmexMID() != "") {
					device.setUpdateAmexMID(model.getUpdateAmexMID());
				} else {
					device.setUpdateAmexMID("NA");
				}if (model.getMdrCashAtPos() == null || model.getMdrCashAtPos() == "") {
					device.setMdrCashAtPos(new BigDecimal("0"));
				} else {
					device.setMdrCashAtPos(new BigDecimal(model.getMdrCashAtPos()));
				}
				/* loan details	started */
				device.setLoanStatus(model.getLoanStatus());
				device.setActivationDate(sdfSource1.format(new Date()));
				if(model.getLoanStatus().equals("1")){
					device.setLoanType(model.getLoanType());
					device.setLoanDedAmount(model.getLoanDedAmount());
					AcqLoanDetails loanEnt = (AcqLoanDetails) session.createCriteria(AcqLoanDetails.class).add(Restrictions.eq("userId",AcqUser.getUserId())).uniqueResult();
					if(loanEnt==null||loanEnt+""==""){
						AcqLoanDetails ent = new AcqLoanDetails();
						ent.setBankTid(device.getBankTId());
						ent.setLoanBankAccNo(model.getLoanBankAccNo());
						ent.setLoanBankIfsc(model.getLoanBankIfsc());
						ent.setLoanBankName(model.getLoanBankName());
						ent.setUserId(AcqUser.getUserId());
						ent.setOrgId(AcqUser.getOrganizationId());
						ent.setMerchantId(Long.parseLong(""+AcqUser.getOrganization().getMerchant().getMerchantId()));
						SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						ent.setDateTime(Timestamp.valueOf(sdfm.format(new Date())));
						ent.setUpdatedOn(Timestamp.valueOf(sdfm.format(new Date())));
						session.save(ent);
					}else{
						loanEnt.setBankTid(device.getBankTId());
						loanEnt.setLoanBankAccNo(model.getLoanBankAccNo());
						loanEnt.setLoanBankIfsc(model.getLoanBankIfsc());
						loanEnt.setLoanBankName(model.getLoanBankName());
						loanEnt.setUserId(AcqUser.getUserId());
						loanEnt.setOrgId(AcqUser.getOrganizationId());
						loanEnt.setMerchantId(Long.parseLong(""+AcqUser.getOrganization().getMerchant().getMerchantId()));
						SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						loanEnt.setUpdatedOn(Timestamp.valueOf(sdfm.format(new Date())));
						session.save(loanEnt);
					}					
				}
				/*loan details ended */
				if (model.getActivationDate() != null
						&& model.getActivationDate() != ""&& model.getActivationDate().length()==10){
					Date actDate = sdfDestination1.parse(model.getActivationDate());
					System.out.println("actDate model:" + actDate);
					device.setActivationDate(""+sdfSource1.format(actDate));
				}if(model.getPlanName()!=null&&model.getPlanName()!=""&&model.getPlanName().length()>1){
					device.setPlanName(model.getPlanName());
				}if(model.getFeeModel()!=null&&model.getFeeModel()!=""&&model.getFeeModel().length()>1){
					device.setFeeMode(model.getFeeModel());
				}if(model.getFeeAmount()!=null&&model.getFeeAmount()!=""&&model.getFeeAmount().length()>1){
					device.setFeeAmount(model.getFeeAmount());
				}if (model.getFeeDate()!= null&& model.getFeeDate() != ""&& model.getFeeDate().length()==10){
					Date feeDate = sdfDestination1.parse(model.getFeeDate());
					device.setFeeDate(sdfSource1.format(feeDate));
				}if(model.getFeeRemarks()!=null&&model.getFeeRemarks()!=""&&model.getFeeRemarks().length()>1){
					device.setFeeRemark(model.getFeeRemarks());
				}
				if (model.getRechargeBal() == null || model.getRechargeBal() == ""|| model.getRechargeBal().length()<1) {
					device.setRechargeBal(new BigDecimal(0));
				} else {
					device.setRechargeBal(new BigDecimal(model.getRechargeBal()));
				}
				if (model.getRechargeIncentive() == null || model.getRechargeIncentive() == ""|| model.getRechargeIncentive().length()<1) {
					device.setRechargeIncentive(new BigDecimal(0));
				} else {
					device.setRechargeIncentive(new BigDecimal(model.getRechargeIncentive()));
				}
				if (model.getRechargeMonthlyRental() == null || model.getRechargeMonthlyRental() == ""|| model.getRechargeMonthlyRental().length()<1) {
					device.setRechargeMonthlyRental(new BigDecimal(0));
				} else {
					device.setRechargeMonthlyRental(new BigDecimal(model.getRechargeMonthlyRental()));
				}
						if(model.getMidTidEntryDate()==null||model.getMidTidEntryDate()==""||model.getMidTidEntryDate().length()!=10){
							device.setMidTidEntryDate("2018-01-01");
						}else{
							midTidDate = sdfDestination1.parse(model.getMidTidEntryDate());
							device.setMidTidEntryDate(""+sdfSource1.format(midTidDate));
						}
						if(model.getWlcmLtrSendDate()==null||model.getWlcmLtrSendDate()==""||model.getWlcmLtrSendDate().length()!=10){
							device.setWlcmLtrSendDate("2018-01-01");
						}else{
							wlcmSendLtrDate = sdfDestination1.parse(model.getWlcmLtrSendDate());
							device.setWlcmLtrSendDate(""+sdfSource1.format(wlcmSendLtrDate));
						}
				Transaction tx = session.beginTransaction();
				AcqUser.setDeviceMapUser(device);
				session.saveOrUpdate(AcqUser); // Updating user table records
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(detailsList);
			}
		} catch (NumberFormatException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in update merchant " + e);
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
			logger.error("error to create hibernate session in add merchant dao "
					+ e);
		}
		return response;
	}
	
	
	
	@Transactional
	public DbDto<AcqNewUpdateOrgModel> updateOrg(AcqNewUpdateOrgModel model) {
		DbDto<AcqNewUpdateOrgModel> response = new DbDto<AcqNewUpdateOrgModel>();
		logger.info("request landing in update Organization Dao");		
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqNewOrganizationEntity AcqOrg = (AcqNewOrganizationEntity) session
					.get(AcqNewOrganizationEntity.class,
							Long.valueOf(model.getUpdOrgId()));
			if (AcqOrg == null || AcqOrg + "" == "") {
				response.setMessage(AcqStatusDefination.NotFound
						.getDetails());
				logger.info("Organization not found for update");
			} else {
				logger.info("organization updating");
				AcqOrg.setName(model.getUpdOrgName());
				AcqOrg.setAddress1(model.getUpdOrgAddress1());
				AcqOrg.setAddress2(model.getUpdOrgAddress2());
				AcqOrg.setCity(model.getUpdOrgCity());
				AcqOrg.setState(model.getUpdOrgState());
				AcqOrg.setCountry(model.getUpdOrgCountry());
				AcqOrg.setPincode(model.getUpdOrgPinCode());
				Transaction tx = session.beginTransaction();
				session.saveOrUpdate(AcqOrg);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Organization successfully updated");

			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
			logger.error("Error in Update Organization " + e);
		}
		return response;
	}
	
	@Transactional
	public DbDto<Object> updateMerchant(AcqNewUpdateMerchantModel model) {
		DbDto<Object> response = new DbDto<Object>();
		logger.info("request lending in merchant update dao");
		boolean update = false;
		try {
			SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
			
			Session session = AcqMerchantDaoImpl.getSession();
			AcqAddNewMerchantEntity AcqMerchant = (AcqAddNewMerchantEntity) session
					.get(AcqAddNewMerchantEntity.class,
							Long.valueOf(model.getMerId()));
			if (AcqMerchant == null || AcqMerchant + "" == "") {
				logger.info("Merchant not found for update");
				response.setMessage(AcqStatusDefination.NotFound
						.getDetails());
			} else {
				if (model.getEmailId() != null && model.getEmailId() != "" && !model.getEmailId().equals("NA")&&!model.getEmailId().equals("")) {
				if (model.getEmailId().equals("" + AcqMerchant .getEmailId())) {
				     logger.info("Email Id is not changed, no action taken");
				    } else {
				     String updateEmail = (String) session.createCriteria(AcqAddNewMerchantEntity.class)
				       .setProjection(Projections.property("emailId")).add(Restrictions.eq("emailId",model.getEmailId()))
				       .uniqueResult();
				     if (updateEmail != null && updateEmail.length() > 0) {
				      logger.info("Email Id already in use with other account");
				      response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				      response.setMessage("Email Id Already Exist With Other Merchant");
				      return response;
				     } else {
				      AcqMerchant.setEmailId(model.getEmailId());
				     }
				    }
				}else{
					AcqMerchant.setEmailId(model.getEmailId());
				}
				List<String> detailsList = new ArrayList<String>(); 
				detailsList.add(0,AcqMerchant.getPaymentDetail());
				detailsList.add(1,AcqMerchant.getSwipeAmount());
				detailsList.add(2,AcqMerchant.getSwipeTerminal());
				detailsList.add(3,AcqMerchant.getCashAmount());
				detailsList.add(4,AcqMerchant.getChequeAmount());
				detailsList.add(5,AcqMerchant.getChequeBank());
				detailsList.add(6,AcqMerchant.getChequeNo());
				detailsList.add(7,AcqMerchant.getNeftAmount());
				detailsList.add(8,AcqMerchant.getNeftchequeNo());
				detailsList.add(9,AcqMerchant.getNeftRefNo());
				detailsList.add(10,AcqMerchant.getSwipeDate());
				detailsList.add(11,AcqMerchant.getCashDate());
				detailsList.add(12,AcqMerchant.getChequeDate());
				detailsList.add(13,AcqMerchant.getChequeDepositeDate());
				detailsList.add(14,AcqMerchant.getNeftDate());
				
				if (model.getName() != null && model.getName() != ""
						&& model.getName().length() > 0) {
					AcqMerchant.setMerchantName(model.getName());
				}
				if (model.getBusinessType() != null
						&& model.getBusinessType() != ""
						&& model.getBusinessType().length() > 0) {
					AcqMerchant.setBusinessType(model.getBusinessType());
				}
				if (model.getMerchantType() != null
						&& model.getMerchantType() != ""
						&& model.getMerchantType().length() > 0) {
					AcqMerchant.setMerchantType(model.getMerchantType());
				}
				if (model.getDirectorsName() != null
						&& model.getDirectorsName() != ""
						&& model.getDirectorsName().length() > 0) {
					AcqMerchant.setDirectorsName(model.getDirectorsName());
				}
				if (model.getAuthorizedSignatory() != null
						&& model.getAuthorizedSignatory() != ""
						&& model.getAuthorizedSignatory().length() > 0) {
					AcqMerchant.setAuthorizedSignatory(model
							.getAuthorizedSignatory());
				}
				if (model.getBusinessNature() != null
						&& model.getBusinessNature() != ""
						&& model.getBusinessNature().length() > 0) {
					AcqMerchant.setBusinessNature(model.getBusinessNature());
				}
				if (model.getBusinessCode() != null
						&& model.getBusinessCode() != ""
						&& model.getBusinessCode().length() > 0) {
					AcqMerchant.setBusinessCode(model.getBusinessCode());
				}
				if (model.getMarketingName() != null
						&& model.getMarketingName() != ""
						&& model.getMarketingName().length() > 0) {
					AcqMerchant.setMarketingName(model.getMarketingName());
				}
				if (model.getBusinessAddress1() != null
						&& model.getBusinessAddress1() != ""
						&& model.getBusinessAddress1().length() > 0) {
					AcqMerchant.setBusinessAddress1(model.getBusinessAddress1());
				}
				if (model.getBusinessAddress2() != null
						&& model.getBusinessAddress2() != ""
						&& model.getBusinessAddress2().length() > 0) {
					AcqMerchant.setBusinessAddress2(model.getBusinessAddress2());
				}
				if (model.getBusinessCity() != null
						&& model.getBusinessCity() != ""
						&& model.getBusinessCity().length() > 0) {
					AcqMerchant.setBusinessCity(model.getBusinessCity());
				}
				if (model.getBusinessState() != null
						&& model.getBusinessState() != ""
						&& model.getBusinessState().length() > 0) {
					AcqMerchant.setBusinessState(model.getBusinessState());
				}
				if (model.getBusinessPincode() != null
						&& model.getBusinessPincode() != ""
						&& model.getBusinessPincode().length() > 0) {
					AcqMerchant.setBusinessPincode(model.getBusinessPincode());
				}
				if (model.getCountry() != null && model.getCountry() != ""
						&& model.getCountry().length() > 0) {
					AcqMerchant.setCountry(model.getCountry());
				}
				if (model.getPersonalUserAddress1() != null
						&& model.getPersonalUserAddress1() != ""
						&& model.getPersonalUserAddress1().length() > 0) {
					AcqMerchant.setPersonalUserAddress1(model
							.getPersonalUserAddress1());
				}
				if (model.getPersonalUserAddress2() != null
						&& model.getPersonalUserAddress2() != ""
						&& model.getPersonalUserAddress2().length() > 0) {
					AcqMerchant.setPersonalUserAddress2(model.getPersonalUserAddress2());
				}
				if (model.getPersonalUserCity() != null
						&& model.getPersonalUserCity() != ""
						&& model.getPersonalUserCity().length() > 0) {
					AcqMerchant.setPersonalUserCity(model.getPersonalUserCity());
				}
				if (model.getPersonalUserState() != null
						&& model.getPersonalUserState() != ""
						&& model.getPersonalUserState().length() > 0) {
					AcqMerchant.setPersonalUserState(model
							.getPersonalUserState());
				}
				if (model.getPersonalUserPincode() != null
						&& model.getPersonalUserPincode() != ""
						&& model.getPersonalUserPincode().length() > 0) {
					AcqMerchant.setPersonalUserPincode(model
							.getPersonalUserPincode());
				}
				if (model.getPhoneNo() != null && model.getPhoneNo() != ""
						&& model.getPhoneNo().length() > 0) {
					AcqMerchant.setPhoneNo(model.getPhoneNo());
				}				
				if (model.getWebsiteUrl() != null && model.getWebsiteUrl() != "" && model.getWebsiteUrl().length() > 0) {
					AcqMerchant.setWebsiteUrl(model.getWebsiteUrl());
				}
			/*	if (model.getEmailId() != null && model.getEmailId() != "" && model.getEmailId().length() > 0) {
					AcqMerchant.setEmailId(model.getEmailId());
				}   */
				if (model.getModeofpayment() != null && model.getModeofpayment() != "" && model.getModeofpayment().length() > 0) {
					AcqMerchant.setPaymentDetail(model.getModeofpayment());
				}
				if (model.getSwipeAmount() != null && model.getSwipeAmount() != "" && model.getSwipeAmount().length() > 0) {
					AcqMerchant.setSwipeAmount(model.getSwipeAmount());
				}
				if (model.getSwipeDate() != null && model.getSwipeDate() != "" && model.getSwipeDate().length() > 0) {
					AcqMerchant.setSwipeDate("" + sdfSource1.format(sdfDestination1.parse(model.getSwipeDate())));
				}
				AcqMerchant.setOnBoardUpdateEmpName(model.getOnBoardUpdateExeName());
				if (model.getSwipeTerminal() != null && model.getSwipeTerminal() != "" && model.getSwipeTerminal().length() > 0) {
					AcqMerchant.setSwipeTerminal(model.getSwipeTerminal());
				}if (model.getChequeAmount() != null && model.getChequeAmount() != "" && model.getChequeAmount().length() > 0) {
					AcqMerchant.setChequeAmount((model.getChequeAmount()));
				}
				if(model.getChequeNo() != null && model.getChequeNo() != "" && model.getChequeNo().length() > 0) {
					AcqMerchant.setChequeNo(model.getChequeNo());
				}
				if(model.getChequeDate() != null && model.getChequeDate() != "" && model.getChequeDate().length() > 1) {
					AcqMerchant.setChequeDate("" + sdfSource1.format(sdfDestination1.parse(model.getChequeDate())));
				}
				if (model.getChequeDepositDate() != null && model.getChequeDepositDate() != "" && model.getChequeDepositDate().length() > 1) {
					AcqMerchant.setChequeDepositeDate("" + sdfSource1.format(sdfDestination1.parse(model.getChequeDepositDate())));
				}
				if (model.getChequeBank() != null
						&& model.getChequeBank() != ""
						&& model.getChequeBank().length() > 0) {
					AcqMerchant.setChequeBank(model.getChequeBank());
				}
				if (model.getCashAmount() != null && model.getCashAmount() != "" && model.getCashAmount().length() > 0) {
					AcqMerchant.setCashAmount((model.getCashAmount()));
				}
				if (model.getCashDate() != null && model.getCashDate() != "" && model.getCashDate().length() > 1) {
					AcqMerchant.setCashDate("" + sdfSource1.format(sdfDestination1.parse(model.getCashDate())));
				}
				if (model.getNeftAmount() != null && model.getNeftAmount() != "" && model.getNeftAmount().length() > 0) {
					AcqMerchant.setNeftAmount((model.getNeftAmount()));
				}
				if (model.getNeftDate() != null && model.getNeftDate() != "" && model.getNeftDate().length() > 1) {
					AcqMerchant.setNeftDate("" + sdfSource1.format(sdfDestination1.parse(model.getNeftDate())));
				}
				if (model.getNeftchequeNo() == null || model.getNeftchequeNo() == "" || model.getNeftchequeNo().length() < 1) {
					AcqMerchant.setNeftchequeNo("0");
				} else {
					AcqMerchant.setNeftchequeNo(model.getNeftchequeNo());
				}
				if (model.getNeftRefNo() == null && model.getNeftRefNo() == "" || model.getNeftRefNo().length() < 1) {
					AcqMerchant.setNeftRefNo("0");
				} else {
					AcqMerchant.setNeftRefNo(model.getNeftRefNo());
				}
				if (model.getTinNo() != null && model.getTinNo() != "" && model.getTinNo().length() == 11) {
					AcqMerchant.setTinNo(model.getTinNo());
				}else{
				     AcqMerchant.setTinNo("0");
			    }
				AcqMerchant.setServiceTaxNo(model.getServiceTaxNo());				
				if(model.getMerchantType().equals("wallet")){
					AcqMerchant.setBankMid("NA");
				}else{
					if (model.getBankMid().equals("" + AcqMerchant.getBankMid())) {	
						logger.info("Bank Mid is not changed, no action taken");
					} else {
						String merchantBankMid = (String) session.createCriteria(AcqAddNewMerchantEntity.class).setProjection(Projections.property("bankMid")).add(Restrictions.eq("bankMid",model.getBankMid())).uniqueResult();
						if (merchantBankMid != null && merchantBankMid != "") {
							logger.info("Bank Mid already in use with other account");
							response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
							response.setMessage("Bank Mid Already Exist");
							return response;
						} else {
							AcqMerchant.setBankMid(model.getBankMid());
						}
					}
				}
				if (model.getVerificatonStatus() != null
						&& model.getVerificatonStatus() != ""
						&& model.getVerificatonStatus().length() > 0) {
					AcqMerchant.setVerificationStatus(model
							.getVerificatonStatus());
				}
				if (model.getExecutiveEmail() != null && model.getExecutiveEmail() != "" && model.getExecutiveEmail().length() > 0) {
					AcqMerchant.setExecutiveName(model.getExecutiveEmail());
				}else{
					AcqMerchant.setExecutiveName("NA");
				}
				if (model.getCubMerchant() != null && model.getCubMerchant() != ""
						&& model.getCubMerchant().length() > 0) {
					AcqMerchant.setCubMerchant(model.getCubMerchant());
				} else {
					AcqMerchant.setCubMerchant("0");
				}
				
				
				if(model.getAppReceiptDate().length()>1&&model.getAppReceiptDate()!=null&&model.getAppReceiptDate()!=""){
					AcqMerchant.setAppReceiptDate(sdfSource1.format(sdfDestination1.parse(model.getAppReceiptDate())));
				}else{
					AcqMerchant.setAppReceiptDate("2018-01-01");
				}if(model.getTypeOfSale()!=null){
					AcqMerchant.setTypeOfSale(model.getTypeOfSale());
				}else{
					AcqMerchant.setTypeOfSale("Distributor");
				}if(model.getAmName()!=null){
					AcqMerchant.setAmName(model.getAmName());
				}else{
					AcqMerchant.setAmName("NA");
				}if(model.getTsoName()!=null){
					AcqMerchant.setTsoName(model.getTsoName());
				}else{
					AcqMerchant.setTsoName("NA");
				}if(model.getOnBoardEmpName()!=null){
					AcqMerchant.setOnBoardEmpName(model.getOnBoardEmpName());
				}else{
					AcqMerchant.setOnBoardEmpName("NA");
				}if(model.getOnBoardingStatus()!=null){
					AcqMerchant.setOnBoardingStatus(model.getOnBoardingStatus());
				}else{
					AcqMerchant.setOnBoardingStatus("Pending");
				}if(model.getVerificationEntryDate()!=null){
					AcqMerchant.setVerificationEntryDate(sdfSource1.format(sdfDestination1.parse(model.getVerificationEntryDate())));
				}else{
					AcqMerchant.setVerificationEntryDate("2018-01-01");
				}if(model.getAgreementRcvdDate().length()>1&&model.getAgreementRcvdDate()!=null&&model.getAgreementRcvdDate()!=""){
					AcqMerchant.setAgreementRcvdDate(sdfSource1.format(sdfDestination1.parse(model.getAgreementRcvdDate())));
				}else{
					AcqMerchant.setAgreementRcvdDate("2018-01-01");
				}	
				AcqMerchant.setAppCheckStatus(model.getAppCheckStatus());
				AcqMerchant.setNote(model.getNote());
				SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				AcqMerchant.setDateUpdated(sdfm.format(new Date()));
				Transaction tx = session.beginTransaction();
				session.saveOrUpdate(AcqMerchant);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(detailsList);
				logger.info("Merchant successfully updated");
			}
		} catch (NumberFormatException e) {
			logger.error("Wrong param value in model " + e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage("Number formate problem");
			response.setResult(""+update);
		} catch (Exception e) {
			logger.error("Error in update merchant " + e);
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
		}
		return response;
	}
	
	@Transactional
	public DbDto<String> merchantDelete(String merchantId) {
		DbDto<String> response = new DbDto<String>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			if (merchantId != null && merchantId != "") {
				Set<Long> orgSet = new HashSet<Long>();
				Set<Long> userSet = new HashSet<Long>();
				Set<String> banktidset = new HashSet<String>();
				AcqAddNewMerchantEntity AcqMerchant = (AcqAddNewMerchantEntity) session.get(AcqAddNewMerchantEntity.class,Long.valueOf(merchantId));
				if (AcqMerchant != null && AcqMerchant + "" != "") {
					List<AcqOrganization1> orgList = (List<AcqOrganization1>)session.createCriteria(AcqOrganization1.class).add(Restrictions.eq("merchantId", Integer.parseInt(merchantId))).list();
					if(orgList.isEmpty()){
						logger.info("org not found");
					}else{
						Iterator<AcqOrganization1> itr2=orgList.iterator();
						Iterator<AcqOrganization1> orgItr=orgList.iterator();
							while(itr2.hasNext()){	
								AcqOrganization1 ent = (AcqOrganization1)itr2.next();
								orgSet.add(ent.getOrgId());
							}
							List<AcqAppUser> userList = (List<AcqAppUser>)session.createCriteria(AcqAppUser.class).add(Restrictions.in("organizationId", orgSet)).list();
							if(userList.isEmpty()){
								logger.info("Users not found");
							}else{
								Iterator<AcqAppUser> itr3=userList.iterator();
								Iterator<AcqAppUser> deviceItr=userList.iterator();
									while(itr3.hasNext()){	
										AcqAppUser ent = (AcqAppUser)itr3.next();
										AcqDeviceMapUser device = ent.getDeviceMapUser();
										banktidset.add(device.getBankTId());
										userSet.add(ent.getUserId());
									}
									List<AcqInventoryDeviceEntity> AcqDeviceList = (List<AcqInventoryDeviceEntity>) session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.in("inventoryTid", banktidset)).list();
									List<AcqGCMNotificationEntity> gcmEntity = (List<AcqGCMNotificationEntity>) session.createCriteria(AcqGCMNotificationEntity.class).add(Restrictions.in("userId", userSet)).list();
									if(AcqDeviceList.isEmpty()){
										logger.info("Device Details Not Found");
									}else{
										Iterator<AcqGCMNotificationEntity> itr4=gcmEntity.iterator();
										while(itr4.hasNext()){	
											AcqGCMNotificationEntity ent = (AcqGCMNotificationEntity)itr4.next();
											session.delete(ent);
										}	
										List<AcqLoanDetails> loanDetails = (List<AcqLoanDetails>) session.createCriteria(AcqLoanDetails.class).add(Restrictions.in("userId", userSet)).list();
								          if(loanDetails.isEmpty()){
								           logger.info("loanDetails Not Found");
								          }else{
								          Iterator<AcqLoanDetails> itr5=loanDetails.iterator();
								          while(itr5.hasNext()){ 
								           AcqLoanDetails ent = (AcqLoanDetails)itr5.next();
								           session.delete(ent);
								          } 
								         }
										Iterator<AcqInventoryDeviceEntity> itr=AcqDeviceList.iterator();
										while(itr.hasNext()){	
											AcqInventoryDeviceEntity ent = (AcqInventoryDeviceEntity)itr.next();
											ent.setStatus("Available");
											session.saveOrUpdate(ent);
										}										
									}
									while(deviceItr.hasNext()){	
										AcqAppUser ent = (AcqAppUser)deviceItr.next();
										session.delete(ent);
									}	
							}							
							while(orgItr.hasNext()){	
								AcqOrganization1 ent = (AcqOrganization1)orgItr.next();
								session.delete(ent);
							}								
					}
					Transaction tx = session.beginTransaction();
					session.delete(AcqMerchant);
					tx.commit();
					response.setStatus(AcqStatusDefination.OK.getIdentifier());
					response.setMessage(AcqStatusDefination.OK.getDetails());
					logger.info("Merchant is successfully deleted");
				} else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("merchant not found");
				}
			} else {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("merchant is not available");
			}

		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete merchant :" + e);
		}
		return response;
	}


	@Transactional
	public DbDto<String> deleteorg(String orgId) {
		DbDto<String> response = new DbDto<String>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			Set<Long> userSet = new HashSet<Long>();
			Set<String> banktidset = new HashSet<String>();
			AcqNewOrganizationEntity Acqorg = (AcqNewOrganizationEntity) session.get(AcqNewOrganizationEntity.class, Long.valueOf(orgId));
			if (Acqorg == null || Acqorg + "" == "") {
				logger.info("Organization not found");
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
			} else {
				List<AcqAppUser> userList = (List<AcqAppUser>)session.createCriteria(AcqAppUser.class).add(Restrictions.eq("organizationId", Long.valueOf(orgId))).list();
				if(userList.isEmpty()){
					logger.info("Users not found");
				}else{
					Iterator<AcqAppUser> itr3=userList.iterator();
						while(itr3.hasNext()){	
							AcqAppUser ent = (AcqAppUser)itr3.next();
							AcqDeviceMapUser device = ent.getDeviceMapUser();
							banktidset.add(device.getBankTId());
							userSet.add(ent.getUserId());
							if(ent.getDeviceMapUser().getLoanStatus().equals("1")){
								AcqLoanDetails loanEntity = (AcqLoanDetails) session.createCriteria(AcqLoanDetails.class).add(Restrictions.eq("bankTid", ent.getDeviceMapUser().getBankTId())).add(Restrictions.eq("userId", ent.getUserId())).uniqueResult();
								if(loanEntity!=null&&loanEntity+""!=""){
									session.delete(loanEntity);
									logger.info("loan details deleted");
								}else{
									logger.info("Loan Details Not Found");
								}
							}
						}
						List<AcqInventoryDeviceEntity> AcqDeviceList = (List<AcqInventoryDeviceEntity>) session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.in("inventoryTid", banktidset)).list();
						List<AcqGCMNotificationEntity> gcmEntity = (List<AcqGCMNotificationEntity>) session.createCriteria(AcqGCMNotificationEntity.class).add(Restrictions.in("userId", userSet)).list();
					//	List<AcqLoanDetails> loanDetails = (List<AcqLoanDetails>) session.createCriteria(AcqLoanDetails.class).add(Restrictions.in("userId", userSet)).list();
						if(AcqDeviceList.isEmpty()){
							logger.info("Device Details Not Found");
						}else{
							Iterator<AcqGCMNotificationEntity> itr4=gcmEntity.iterator();
							while(itr4.hasNext()){	
								AcqGCMNotificationEntity ent = (AcqGCMNotificationEntity)itr4.next();
								session.delete(ent);
							}	
							Iterator<AcqInventoryDeviceEntity> itr=AcqDeviceList.iterator();
							while(itr.hasNext()){	
								AcqInventoryDeviceEntity ent = (AcqInventoryDeviceEntity)itr.next();
								ent.setStatus("Available");
								session.saveOrUpdate(ent);
							}
							
						}
						Iterator<AcqAppUser> deleteItr=userList.iterator();
						while(deleteItr.hasNext()){	
							AcqAppUser ent = (AcqAppUser)deleteItr.next();
							System.out.println("Users is deleting");
							session.delete(ent);							
						}
				}
				System.out.println("org is deleting");
				Transaction tx = session.beginTransaction();
				session.delete(Acqorg);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.error("Organization is successfully deleted");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete user and device :" + e);
		}
		return response;
	}
	


@Transactional
	public DbDto<String> devicedelete(String userId, String orgId) {
		DbDto<String> response = new DbDto<String>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqAppUser AcqUser = (AcqAppUser) session.get(AcqAppUser.class,Long.valueOf(userId));
			if (orgId.equalsIgnoreCase("" + AcqUser.getOrganizationId())) {
				logger.info("device deleting");
				AcqGCMNotificationEntity gcmEntity = (AcqGCMNotificationEntity) session.createCriteria(AcqGCMNotificationEntity.class).add(Restrictions.eq("userId", AcqUser.getUserId())).uniqueResult();
				AcqInventoryDeviceEntity AcqDevice = (AcqInventoryDeviceEntity) session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo", AcqUser.getDeviceMapUser().getSerialNo())).uniqueResult();
				if(AcqDevice==null||AcqDevice+""==""){
					logger.warn("device not found");
				}else{
					AcqDevice.setStatus("Available");
					session.saveOrUpdate(AcqDevice);
				}
				if(gcmEntity!=null&&gcmEntity+""!=""){
				    session.delete(gcmEntity);
				    logger.info("gcm entity deleted");
				}
				if(AcqUser.getDeviceMapUser().getLoanStatus().equals("1")){
					AcqLoanDetails loanEntity = (AcqLoanDetails) session.createCriteria(AcqLoanDetails.class).add(Restrictions.eq("bankTid", AcqUser.getDeviceMapUser().getBankTId())).add(Restrictions.eq("userId", AcqUser.getUserId())).uniqueResult();
					if(loanEntity!=null&&loanEntity+""!=""){
						session.delete(loanEntity);
						logger.info("loan details deleted");
					}else{
						logger.info("Loan Details Not Found");
					}
				}
				Transaction tx = session.beginTransaction();
				session.delete(AcqUser);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.error("Organization is successfully deleted");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
			logger.error("Error to delete user and device :" + e);
		}
		return response;
	}
	
	
	@Transactional
	public DbDto<Object> addDeviceDetail(AcqNewDeviceDetailModel model) {
		logger.info("request landing in Device dao");
		DbDto<Object> response = new DbDto<Object>();
		try {
			logger.info("session object is created");
			AcqDevice device = new AcqDevice();
			AcqUser AcqUser = new AcqUser();
			String banktid = null;
			String dbserialNo  = null;		
			Date feeDate = null;
			Date midTidDate = null;
			Date wlcmSendLtrDate = null;
			Session session = AcqMerchantDaoImpl.getSession();
			AcqInventoryDeviceEntity ent = null;
			SimpleDateFormat sdfDestination1 = null;
			SimpleDateFormat sdfSource1 = null;
			if (model.getLoginId() != null && model.getLoginId() != ""){
				try {
					Long loginid = (Long) session.createCriteria(AcqAppUser.class).setProjection(Projections.property("loginId"))
							.add(Restrictions.eq("loginId",Long.valueOf(model.getLoginId()))).uniqueResult();					
					if (model.getSerialNo() != null && model.getSerialNo() != "") {
						 dbserialNo = (String) session.createCriteria(AcqDeviceMapUser.class).setProjection(Projections.property("serialNo")).add(Restrictions.eq("serialNo",model.getSerialNo())).uniqueResult();
					}if (model.getBankTid() != null && model.getBankTid() != "") {
						banktid = (String) session
								.createCriteria(AcqDeviceMapUser.class)
								.setProjection(Projections.property("bankTId"))
								.add(Restrictions.eq("bankTId",model.getBankTid())).uniqueResult();
					}if ((loginid != null && loginid > 0) || (dbserialNo != null && dbserialNo != "") || (banktid != null && banktid != "")) {
						if (loginid != null && loginid > 0) {
							logger.info("Users Id already in use with other account");
							response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
							response.setMessage("Users Id Already Exist");
						} else if (dbserialNo != null && dbserialNo != "") {
							logger.info("Device Serial No. already in use with other account");
							response.setStatus(AcqStatusDefination.RollBackError
									.getIdentifier());
							response.setMessage("Device Serial No. Already Exist");
						} else if (banktid != null && banktid != "") {
							logger.info("Bank Tid already in use with other account");
							response.setStatus(AcqStatusDefination.RollBackError
									.getIdentifier());
							response.setMessage("Bank Tid Already Exist");
						}
					} else {
						if(model.getUserType().equalsIgnoreCase("credit")||model.getUserType().equalsIgnoreCase("wallet/credit")){
							ent = (AcqInventoryDeviceEntity)session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventorySerialNo",model.getSerialNo())).uniqueResult();
							ent.setStatus("Inuse");
							//saveOrUpdate(ent);
						}
						AcqUser.setRechargeServiceEnable(model.getRechargeServiceEnable());
						AcqUser.setPpcServiceEnable(model.getPpcServiceEnable());
						AcqUser.setDmtServiceEnable(model.getDmtServiceEnable());
						AcqUser.setDthMobileServiceEnable(model.getDthMobileServiceEnable());
						AcqUser.setLoginId(Long.valueOf(model.getLoginId()));
						AcqUser.setRmn(Long.valueOf(model.getRmn()));
						AcqUser.setUserName(model.getName());
						AcqUser.setPassword(AcqBase.generateSHA("Acquiro123"));
						AcqUser.setEmailId(model.getEmailId());
						AcqUser.setUserStatus("0");
						AcqUser.setOrgId(Long.valueOf(model.getOrgId()));
							AcqUser.setSwitchType("ACQ");
						}
						
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						String date = df.format(new Date());
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						AcqUser.setDate(format.parse(date));
						AcqUser.setAquirerCode("Acquiro");						
						// saving user table records
						if(model.getSerialNo()==null || model.getSerialNo()=="" || model.getSerialNo().length()<1){
							device.setSerialNo("NA");
						}else{
							device.setSerialNo(model.getSerialNo());
						}						
						device.setUserType(model.getUserType());
						if (model.getBankTid() != null&& model.getBankTid() != ""&&model.getBankTid().length()>1) {
							device.setBankTId(model.getBankTid());
						} else {
							device.setBankTId("NA");
						}	
						if (model.getSettlementCharges() != null && model.getSettlementCharges() != ""&&model.getSettlementCharges().length()>0) {
							device.setSettlementCharges(new BigDecimal(model
									.getSettlementCharges()));
						} else {
							device.setSettlementCharges(new BigDecimal("0"));
							
						}
						if (model.getMdrDebit0() != null && model.getMdrDebit0() != ""&& model.getMdrDebit0().length()>0 ) {
							
							device.setMdrZero(new BigDecimal(model.getMdrDebit0()));
						} else {
							device.setMdrZero(new BigDecimal("0"));
						}
						if (model.getMdrDebit1() != null && model.getMdrDebit1() != "" && model.getMdrDebit1().length()>0 ) {
							device.setMdrDebit1(new BigDecimal(model
									.getMdrDebit1()));
						} else {
							device.setMdrDebit1(new BigDecimal("0"));
							
						}
						if (model.getMdrDebit2() != null && model.getMdrDebit2() != "" && model.getMdrDebit2().length()>0) {
							device.setMdrDebit2(new BigDecimal(model
									.getMdrDebit2()));
						} else {
							device.setMdrDebit2(new BigDecimal("0"));
							
						}
						if (model.getMdrCreditNpre() != null
								&& model.getMdrCreditNpre() != "" && model.getMdrCreditNpre().length()>0) {
							device.setMdrCreditNpre(new BigDecimal(model
									.getMdrCreditNpre()));
						} else {
							device.setMdrCreditNpre(new BigDecimal("0"));
							
						}
						if (model.getMdrCreditPre() != null
								&& model.getMdrCreditPre() != "" && model.getMdrCreditPre().length()>0)  {
							
							device.setMdrCreditPre(new BigDecimal(model
									.getMdrCreditPre()));
							
						} else {
							device.setMdrCreditPre(new BigDecimal("0"));
						}
						if (model.getMdrMobiKwik() != null
								&& model.getMdrMobiKwik() != ""  && model.getMdrMobiKwik().length()>0) {
							device.setMdrMobikwik(new BigDecimal(model
									.getMdrMobiKwik()));
							

						} else {
							device.setMdrMobikwik(new BigDecimal("0"));
						}
						if (model.getMdrAmex() != null && model.getMdrAmex() != ""&&model.getMdrAmex().length()>1) {
							device.setMdrAmex(new BigDecimal(model.getMdrAmex()));
							
						} else {
							device.setMdrAmex(new BigDecimal("0"));
						}
						if (model.getOther() != null && model.getOther() != "" && model.getOther().length()>0) {
							device.setOther(new BigDecimal(model.getOther()));
							
						} else {
							device.setOther(new BigDecimal("0"));
						}if (model.getMdrCashAtPos() != null && model.getMdrCashAtPos() != "" && model.getMdrCashAtPos().length()>0) {
							device.setMdrCashAtPos(new BigDecimal(model.getMdrCashAtPos()));
							
						} else {
							device.setMdrCashAtPos(new BigDecimal("0"));
						}
						if (model.getRechargeBal() != null && model.getRechargeBal() != ""&& model.getRechargeBal().length()>1) {
							device.setRechargeBal(new BigDecimal(model.getRechargeBal()));
							
						} else {
							device.setRechargeBal(new BigDecimal(0));
						}
						if (model.getRechargeIncentive() != null && model.getRechargeIncentive() != ""&& model.getRechargeIncentive().length()>1) {
							device.setRechargeIncentive(new BigDecimal(model.getRechargeIncentive()));
							
						} else {
							device.setRechargeIncentive(new BigDecimal("0"));
						}
						if (model.getRechargeMonthlyRental() != null && model.getRechargeMonthlyRental() != ""&& model.getRechargeMonthlyRental().length()>1) {
							device.setRechargeMonthlyRental(new BigDecimal(model.getRechargeMonthlyRental()));
							
						} else {
							device.setRechargeMonthlyRental(new BigDecimal("0"));
						}
						
						device.setLoanStatus("0");
						device.setLoanDedAmount("0.000");
						//device.setMdrZero(new BigDecimal("0"));
						device.setBankAccName(model.getAccountType());
						device.setBankAccNo(model.getAccountNo());
						device.setBankIfsc(model.getBankIfsc());
						device.setBankMicr(model.getBankMicr());
						device.setBankName(model.getBankName());
						device.setBenefName(model.getBenefName());
						device.setBankBranch(model.getBranchName());
						device.setRent(new BigDecimal(model.getRent()));
						device.setPaymentMode(model.getPaymentMode());
						device.setAmexActivated(model.getAmexActivated());
						if (model.getAmexTID() != null && model.getAmexTID() != ""&& model.getAmexTID().length()>1) {
							device.setAmexTID(model.getAmexTID());
							
						} else {
							device.setAmexTID("NA");
						}
						if (model.getAmexMID() != null && model.getAmexMID() != ""&& model.getAmexMID().length()>1) {
							device.setAmexMID(model.getAmexMID());
							
						} else {
							device.setAmexMID("NA");
						}
						
						sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
						sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
						device.setValidTil("" + sdfSource1.format(sdfDestination1.parse(model.getValidTil())));
						device.setPendingRent(new BigDecimal(model.getPendingRent()));
						if(model.getDiscount().equals(null)&&model.getDiscount().equals("")){
							device.setDiscount(new BigDecimal("0.000"));
						}else{
							device.setDiscount(new BigDecimal(model.getDiscount()));
						}if(model.getDiscountReason()!=null&&model.getDiscountReason()!=""){
							device.setDiscountReason("NA");
						}else{
							device.setDiscountReason(model.getDiscountReason());
						}		
						if (model.getIntegrationKey() != null && model.getIntegrationKey() != ""&& model.getIntegrationKey().length()>1) {
							device.setIntegrationKey(model.getIntegrationKey());
							
						} else {
							device.setIntegrationKey("NA");
						}
						if(model.getPenaltyAmount().equals(null)&&model.getPenaltyAmount().equals("")){
							device.setPenaltyAmount(new BigDecimal("0.000"));
						}else{
							device.setPenaltyAmount(new BigDecimal(model.getPenaltyAmount()));
						}if(model.getPenaltyReason()!=null&&model.getPenaltyReason()!=""){
							device.setPenaltyReason("NA");
						}else{
							device.setPenaltyReason(model.getPenaltyReason());
						}
						if(model.getAvgTxnAmount().equals(null)&&model.getAvgTxnAmount().equals("")){
							device.setAvgTxnAmount(new BigDecimal("0.000"));
						}else{
							device.setAvgTxnAmount(new BigDecimal(model.getAvgTxnAmount()));
						}
						device.setAcquirerCode("Acquiro");	
						device.setActivationDate("2018-01-01");
						if(model.getPlanName()!=null&&model.getPlanName()!=""){
							device.setPlanName("NA");
						}else{
							device.setPlanName(model.getPlanName());
						}if(model.getFeeModel()!=null&&model.getFeeModel()!=""){
							device.setFeeMode("NA");
						}else{
							device.setFeeMode(model.getFeeModel());
						}if(model.getFeeAmount()!=null&&model.getFeeAmount()!=""){
							device.setFeeAmount("0.0");
						}else{
							device.setFeeAmount(model.getFeeAmount());
						}if(model.getFeeDate()!=null&&model.getFeeDate()!=""&&model.getFeeDate().length()!=10){
							device.setFeeDate("2018-01-01");
						}else{
							device.setFeeDate(""+sdfSource1.format(sdfDestination1.parse(model.getFeeDate())));
						}if(model.getFeeRemarks()!=null&&model.getFeeRemarks()!=""){
							device.setFeeRemarks("NA");
						}else{
							device.setFeeRemarks(model.getFeeRemarks());
						}

						if(model.getMidTidEntryDate()!=null&&model.getMidTidEntryDate()!=""&&model.getMidTidEntryDate().length()!=10){
							device.setMidTidEntryDate(""+sdfSource1.format(sdfDestination1.parse(model.getMidTidEntryDate())));
						}else{
							device.setMidTidEntryDate("2018-01-01");
							
						}
						if(model.getWlcmLtrSendDate()!=null&&model.getWlcmLtrSendDate()!=""&&model.getWlcmLtrSendDate().length()!=10){
							device.setWlcmLtrSendDate(""+sdfSource1.format(sdfDestination1.parse(model.getWlcmLtrSendDate())));
							
						}else{
							device.setWlcmLtrSendDate("2018-01-01");
						}
						Transaction tx = session.beginTransaction();
						session.saveOrUpdate(AcqUser);
						device.setUserId(AcqUser.getUserId());
						session.saveOrUpdate(device); // saving device table records
						if (banktid != null && banktid != ""){
							session.saveOrUpdate(ent);
						}
						tx.commit();
						logger.info("user successfully created");
						response.setStatus(AcqStatusDefination.OK.getIdentifier());
						response.setMessage(AcqStatusDefination.OK.getDetails());
						response.setResult(model.getLoginId());
					
				} catch (ConstraintViolationException cvx) {
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError.getDetails());
					logger.error("Error to create user1 :" + cvx);
				} catch (NumberFormatException e) {
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError
							.getDetails());
					logger.error("number format problem in add Device dao " + e);
				} catch (NullPointerException e) {
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError
							.getDetails());
					logger.error("there is some value is null in add Device dao "
							+ e);
				} catch (Exception e) {
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError
							.getDetails());
					logger.error("error to create hibernate session in add Device dao "
							+ e);
				}
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError
					.getDetails());
		}
		return response;
	}
	
	@Transactional
	public DbDto<Object> addOrganization(AcqNewOrganization model) {
		logger.info("request landing in Organization dao");
		DbDto<Object> response = new DbDto<Object>();
		try {	
			Session session = AcqMerchantDaoImpl.getSession();
			logger.info("session object is created");
			AcqNewOrganizationEntity org = new AcqNewOrganizationEntity();
			org.setName(model.getAddOrgName());
			org.setAddress1(model.getAddOrgAddress1());
			org.setAddress2(model.getAddOrgAddress2());
			org.setCity(model.getAddOrgCity());
			org.setCountry(model.getAddOrgCountry());
			org.setName(model.getAddOrgName());
			org.setPincode(model.getAddOrgPinCode());
			org.setState(model.getAddOrgState());
			org.setMerchantId(Long.valueOf(model.getAddOrgMid()));
			org.setAcquirerCode("Acquiro");
			Transaction tx = session.beginTransaction();
			session.save(org);
			tx.commit();
			response.setStatus(AcqStatusDefination.OK.getIdentifier());
			response.setMessage(AcqStatusDefination.OK.getDetails());
			response.setResult(org.getOrgId());
			logger.info("Organization added successfully");
		} catch (NumberFormatException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem in add Organization dao " + e);
		} catch (NullPointerException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in add Organization dao "+ e);
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to create hibernate session in add Organization dao "+ e);
		}
		return response;
	}

	
	
	@Transactional
	public DbDto<Object> addMerchant(AcqMerchantNewModel model) {
		logger.info("request landing in merchant dao");
		DbDto<Object> response = new DbDto<Object>();
		try {
			SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
			
			Session session = AcqMerchantDaoImpl.getSession();
			String email=null;
			System.out.println("email id is "+model.getEmailId());
			if (model.getEmailId() != null && model.getEmailId() != "" && !model.getEmailId().equals("NA")&&!model.getEmailId().equals("")) {
				email = (String) session.createCriteria(AcqAddNewMerchantEntity.class).add(Restrictions.eq("aquirerCode","Acquiro")).setProjection(Projections.property("emailId")).add(Restrictions.eq("emailId",model.getEmailId())).uniqueResult();
			}
			if(email!=null&&email.length()>4){
			    response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			    response.setMessage("EmailId mapped with other merchant");
			    return response;
			}else{
				logger.info("");
				AcqAddNewMerchantEntity entity = new AcqAddNewMerchantEntity();
				entity.setMerchantName(model.getName());
				entity.setBusinessType(model.getBusinessType());
				entity.setMerchantType(model.getMerchantType());
				entity.setDirectorsName(model.getDirectorsName());
				entity.setAuthorizedSignatory(model.getAuthorizedSignatory());
				entity.setBusinessNature(model.getBusinessNature());
				entity.setBusinessCode(model.getBusinessCode());
				entity.setMarketingName(model.getMarketingName());
				entity.setBusinessAddress1(model.getBusinessAddress1());
				entity.setBusinessAddress2(model.getBusinessAddress2());
				entity.setBusinessState(model.getBusinessState());
				entity.setBusinessCity(model.getBusinessCity());
				entity.setBusinessPincode(model.getBusinessPincode());
				entity.setPersonalUserAddress1(model.getPersonalUserAddress1());
				entity.setPersonalUserAddress2(model.getPersonalUserAddress2());
				entity.setPersonalUserState(model.getPersonalUserState());
				entity.setPersonalUserCity(model.getPersonalUserCity());
				entity.setPersonalUserPincode(model.getPersonalUserPincode());
				entity.setCountry(model.getCountry());
				entity.setPhoneNo(model.getPhoneNo());
				entity.setWebsiteUrl(model.getWebsiteUrl());
				entity.setPaymentDetail(model.getModeofpayment());
				//entity.setCubMerchant(model.getCubMerchant());
				if (model.getCubMerchant() != null && model.getCubMerchant() != ""
						&& model.getCubMerchant().length() > 0) {
					entity.setCubMerchant(model.getCubMerchant());
				} else {
					entity.setCubMerchant("0");
				}
				if (model.getSwipeAmount() != null && model.getSwipeAmount() != ""
						&& model.getSwipeAmount().length() > 0) {
					entity.setSwipeAmount(model.getSwipeAmount());
				} else {
					entity.setSwipeAmount("0.00");
				}
				if (model.getSwipeDate() != null && model.getSwipeDate() != ""&& model.getSwipeDate().length() > 1) {
					entity.setSwipeDate("" + sdfSource1.format(sdfDestination1.parse(model.getSwipeDate())));
				}
				entity.setSwipeTerminal(model.getSwipeTerminal());
				if (model.getChequeAmount() != null
						&& model.getChequeAmount() != ""
						&& model.getChequeAmount().length() > 0) {
					entity.setChequeAmount((model.getChequeAmount()));
				} else {
					entity.setChequeAmount("0.00");
				}
				if (model.getChequeNo() != null && model.getChequeNo() != ""
						&& model.getChequeNo().length() > 0) {
					entity.setChequeNo(model.getChequeNo());
				} else {
					entity.setChequeNo("0");
				}
				if (model.getChequeDate() != null && model.getChequeDate() != ""
						&& model.getChequeDate().length() > 1) {
					entity.setChequeDate("" + sdfSource1.format(sdfDestination1.parse(model.getChequeDate())));
				}
				if (model.getChequeDepositDate() != null&& model.getChequeDepositDate() != ""&& model.getChequeDepositDate().length() > 1) {
					entity.setChequeDepositeDate("" + sdfSource1.format(sdfDestination1.parse(model.getChequeDepositDate())));
				}
				entity.setChequeBank(model.getChequeBank());
				if (model.getCashAmount() != null && model.getCashAmount() != ""&& model.getCashAmount().length() > 0) {
					entity.setCashAmount((model.getCashAmount()));
				} else {
					entity.setCashAmount("0.00");
				}
				if (model.getCashDate() != null && model.getCashDate() != ""&& model.getCashDate().length() > 1) {
					entity.setCashDate("" + sdfSource1.format(sdfDestination1.parse(model.getCashDate())));
				}
				if (model.getNeftAmount() != null && model.getNeftAmount() != ""&& model.getNeftAmount().length() > 0) {
					entity.setNeftAmount((model.getNeftAmount()));
				} else {
					entity.setNeftAmount("0.00");
				}
				if (model.getNeftDate() != null && model.getNeftDate() != ""&& model.getNeftDate().length() > 1) {					
					entity.setNeftDate("" + sdfSource1.format(sdfDestination1.parse(model.getNeftDate())));
				}
				if (model.getNeftchequeNo() != null
						&& model.getNeftchequeNo() != ""
						&& model.getNeftchequeNo().length() > 0) {
					entity.setNeftchequeNo(model.getNeftchequeNo());
				} else {
					entity.setNeftchequeNo("0");
				}
				if (model.getNeftRefNo() != null && model.getNeftRefNo() != ""
						&& model.getNeftRefNo().length() > 0) {
					entity.setNeftRefNo(model.getNeftRefNo());
				} else {
					entity.setNeftRefNo("0");
				}
				entity.setEmailId(model.getEmailId());
				if (model.getTinNo() != null && model.getTinNo() != ""
						&& model.getTinNo().length() > 0) {
					entity.setTinNo(model.getTinNo());
				} else {
					entity.setTinNo("0");
				}
				entity.setServiceTaxNo(model.getServiceTaxNo());
				entity.setOnBoardUpdateEmpName("NA");
				entity.setBankMid("NA");
				entity.setPassword(AcqBase.generateSHA("Acquiro@123"));
				//entity.setDeviceSerialNo(model.getDeviceSerialNo());
				entity.setNote(model.getNote());
				System.out.println("model.getVerificatonStatus():"+model.getVerificatonStatus());
				entity.setVerificationStatus(model.getVerificatonStatus());
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				entity.setDateCreated(formatter.format(new Date()));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				entity.setDateUpdated(sdf.format(new Date()));
				if(model.getExecutiveEmail()!=null && model.getExecutiveEmail() != ""){
					entity.setExecutiveName(model.getExecutiveEmail());
				}else{
					entity.setExecutiveName("NA");
				}
				logger.info("params value putted in entity");
				entity.setAquirerCode("Acquiro");
				
				entity.setAppCheckStatus(model.getAppCheckStatus());
				
				if(model.getAppReceiptDate().length()>1&&model.getAppReceiptDate()!=null&&model.getAppReceiptDate()!=""){
					Date appdate = sdfDestination1.parse(model.getAppReceiptDate());
					entity.setAppReceiptDate(formatter.format(appdate));
				}else{
					entity.setAppReceiptDate("2018-01-01");
				}if(model.getTypeOfSale()!=null){
					entity.setTypeOfSale(model.getTypeOfSale());
				}else{
					entity.setTypeOfSale("Distributor");
				}if(model.getAmName()!=null){
					entity.setAmName(model.getAmName());
				}else{
					entity.setAmName("NA");
				}if(model.getTsoName()!=null){
					entity.setTsoName(model.getTsoName());
				}else{
					entity.setTsoName("NA");
				}if(model.getOnBoardEmpName()!=null){
					entity.setOnBoardEmpName(model.getOnBoardEmpName());
				}else{
					entity.setOnBoardEmpName("NA");
				}if(model.getOnBoardingStatus()!=null){
					entity.setOnBoardingStatus(model.getOnBoardingStatus());
				}else{
					entity.setOnBoardingStatus("Pending");
				}if(model.getVerificationEntryDate()!=null&&model.getVerificationEntryDate()!=""&&model.getVerificationEntryDate().length()>1){
					entity.setVerificationEntryDate(formatter.format(sdfDestination1.parse(model.getVerificationEntryDate())));
				}else{
					entity.setVerificationEntryDate("2018-01-01");
				}if(model.getAgreementRcvdDate().length()>1&&model.getAgreementRcvdDate()!=null&&model.getAgreementRcvdDate()!=""){
					entity.setAgreementRcvdDate(formatter.format(sdfDestination1.parse(model.getAgreementRcvdDate())));
				}else{
					entity.setAgreementRcvdDate("2018-01-01");
				}
				session.save(entity);
				try{
					logger.info("default organization id creating");
					AcqNewOrganizationEntity org = new AcqNewOrganizationEntity();
					org.setName(model.getMarketingName());
					org.setAddress1(model.getBusinessAddress1());
					org.setAddress2(model.getBusinessAddress2());
					org.setCity(model.getBusinessCity());				
					org.setPincode(model.getBusinessPincode());
					org.setState(model.getBusinessState());
					org.setMerchantId(Long.valueOf(entity.getMerchantId()));
					org.setCountry(model.getCountry());
					org.setAcquirerCode("Acquiro");
					logger.info("default organization is created");
					session.save(org);
					Transaction tx = session.beginTransaction();
					tx.commit();
					
				}
				
				catch (Exception e) {
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage(AcqStatusDefination.RollBackError.getDetails());
					logger.error("Error in Default Organization Creation " + e);
				}
				Transaction tx = session.beginTransaction();
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				response.setResult(entity.getMerchantId());
				logger.info("merchant added successfully");
			}
		} catch (NumberFormatException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("number format problem in add merchant dao " + e);
		} catch (NullPointerException e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("there is some value is null in add merchant dao " + e);
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("error to create hibernate session in add merchant dao "+ e);
			System.out.println("error to add merchant"+e);
		}
		return response;
	}

	
	@Transactional
	public DbDto<String> inventoryDeviceDelete(String deviceId) {
		DbDto<String> response = new DbDto<String>();
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			if (deviceId != null && deviceId != "") {
				AcqInventoryDeviceEntity AcqDevice = (AcqInventoryDeviceEntity) session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventoryDeviceId",Long.valueOf(deviceId))).uniqueResult();
				if (AcqDevice != null && AcqDevice + "" != "") {
					if(!AcqDevice.getStatus().equals("Inuse")){
						Transaction tx = session.beginTransaction();
						
						session.delete(AcqDevice);
						tx.commit();
						response.setStatus(AcqStatusDefination.OK.getIdentifier());
						response.setMessage(AcqStatusDefination.OK.getDetails());
						logger.info("Device is successfully deleted");
						return response;
					}
				} else {
					response.setMessage(AcqStatusDefination.NotFound.getDetails());
					logger.info("Device not found");
				}
			} else {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Device is not available");
			}
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error to delete Device :" + e);
		}
		return response;
	}
	
	@Transactional
	public DbDto<AcqInventoryDeviceModel> inventoryUpdateDevice(
			AcqInventoryDeviceModel model) {
		DbDto<AcqInventoryDeviceModel> response = new DbDto<AcqInventoryDeviceModel>();
		logger.info("request landing in update Inventory Device Dao");		
		try {
			Session session = AcqMerchantDaoImpl.getSession();
			AcqInventoryDeviceEntity AcqDevice = (AcqInventoryDeviceEntity) session.createCriteria(AcqInventoryDeviceEntity.class).add(Restrictions.eq("inventoryDeviceId",Long.valueOf(model.getInventoryDeviceId()))).uniqueResult();
			if (AcqDevice == null || AcqDevice + "" == "") {
				response.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Device not found for update");
			} else {
				if (model.getInventorySerialNo().equals("" + AcqDevice.getInventorySerialNo())) {
					logger.info("Serial is not changed, no action taken");
				} else {
					String dbserialNo = (String) session.createCriteria(AcqInventoryDeviceEntity.class).setProjection(Projections.property("inventorySerialNo")).add(Restrictions.eq("inventorySerialNo",model.getInventorySerialNo())).uniqueResult();
					if (dbserialNo != null && dbserialNo != "") {
						logger.info("Device Serial No. already in use with other account");
						response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
						response.setMessage("Device Serial No. Already Exist");
						return response;
					} else {
						AcqDevice.setInventorySerialNo(model.getInventorySerialNo());
					}
				} 
				if(model.getBatterySerialNo()!=null&&model.getBatterySerialNo()!=""){
					AcqDevice.setBatterySerialNo(model.getBatterySerialNo());
					
				}else{
					AcqDevice.setBatterySerialNo("NA");
					
				}
				if(model.getAdapterSerialNo()!=null&&model.getAdapterSerialNo()!=""&&model.getAdapterSerialNo().length()>1){
					AcqDevice.setAdapterSerialNo(model.getAdapterSerialNo());
					
				}else{
					AcqDevice.setAdapterSerialNo("NA");
					
				}
				
				AcqDevice.setDsaList(model.getDsaList());
				AcqDevice.setModelName(model.getModelName());
				AcqDevice.setInventorySerialNo(model.getInventorySerialNo());
				AcqDevice.setStatus(model.getStatus());	
				Transaction tx = session.beginTransaction();
				
				session.saveOrUpdate(AcqDevice);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Device successfully updated");   
			}   
		} catch (Exception e) {
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			logger.error("Error in Update Inventory Device " + e);
	 	}
		return response;
	 }
	
	@Transactional
	public DbDto<List<HashMap<String, String>>> InventoryDeviceList(AcqSearchModel modell) {
		logger.info("Request is landing in dao for Inventory list");	
		List<HashMap<String,String>> globalList = new ArrayList<HashMap<String,String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			DbDto<List<HashMap<String,String>>> globleMap = new DbDto<List<HashMap<String,String>>>();			
			Criteria tot = session.createCriteria(AcqInventoryDeviceEntity.class);
			tot.setProjection(Projections.rowCount());
			Criteria tx=session.createCriteria(AcqInventoryDeviceEntity.class);
			if(modell.getModelName()!=null&&modell.getModelName()!=""&&!(modell.getModelName()).equals("%41")){
				tx.add(Restrictions.eq("modelName", modell.getModelName()));
				tot.add(Restrictions.eq("modelName", modell.getModelName()));
			}if(modell.getSerialNo()!=null&&modell.getSerialNo()!=""&&!(modell.getSerialNo()).equals("%41")){
				tx.add(Restrictions.eq("inventorySerialNo", modell.getSerialNo()));
				tot.add(Restrictions.eq("inventorySerialNo", modell.getSerialNo()));
			}if(modell.getStatus()!=null&&modell.getStatus()!=""&&!(modell.getStatus()).equals("%41")){
				tx.add(Restrictions.eq("status", modell.getStatus()));
				tot.add(Restrictions.eq("status", modell.getStatus()));
			}
 			tx.addOrder(Order.desc("inventoryDeviceId"));
 			tx.setFirstResult((Integer.valueOf(modell.getPage()) - 1) * 20);
			tx.setMaxResults(20);
			List criteriaList = tx.list();
			if(criteriaList.isEmpty()){
				map.put("1", "123");
				globalList.add(map);
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Inventory list is empty");
				return globleMap;			
			}
			System.out.println("modell.getWalletEmail()::"+modell.getWalletEmail());
			AcqEmpRoleEntity emp1 = (AcqEmpRoleEntity)session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("emailId",modell.getWalletEmail())).uniqueResult();
			if(emp1==null){
				map.put("1", "123");
				globalList.add(map);
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("employee not found");
				return globleMap;
			}
			Iterator etr = criteriaList.iterator();	
			Iterator<AcqInventoryDeviceEntity> itr = criteriaList.iterator();
			
			HashMap<String,String> singleMap=null;
			HashMap<String,String> orgmap=null;
			HashMap<String,String> usermap=null;
			HashMap<String,String> deviceMap=null;
			HashMap<String,String> merchantMap=null;
			Set<String> deviceSet = new HashSet<String>();
			Set<Long> userSet = new HashSet<Long>();
			Set<Long> orgSet = new HashSet<Long>();
			Set<Integer> merchantSet = new HashSet<Integer>();
			try{
				AcqInventoryDeviceEntity txEntity = null;
				while(itr.hasNext()){
					 txEntity = (AcqInventoryDeviceEntity)itr.next();
					deviceSet.add(txEntity.getInventorySerialNo());
				}
			}catch(Exception e){
				logger.error("error iterate txn entity or add user/org id in set", e);
			}if(deviceSet.isEmpty()){
				logger.info("user Not Found");
				map.put("1", "123");
				globalList.add(map);
				globleMap.setResult(globalList);
				globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
				globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
				logger.info("Inventory Device List selected successfully");
				return globleMap;			
			}else{				
			try{
				Criteria user =session.createCriteria(AcqDeviceMapUser.class);
			    ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("serialNo"));
			     proList.add(Projections.property("userId"));
			     user.setProjection(proList);
			     user.add((Restrictions.in("serialNo", deviceSet)));
			    List list1 = user.list();
			    deviceMap= new HashMap<String,String>();
			    for(Object obj:list1){
			        Object[] ob=(Object[])obj;
			        deviceMap.put("userId"+ob[0],""+ob[1]);
			        userSet.add(Long.valueOf(""+ob[1]));
			    }
			}catch(Exception e){
				logger.error("error in select user in wallet report "+e);
			}
			if(userSet.isEmpty()){
				logger.info("user Not Found");	
			}else{
			try{
				Criteria user =session.createCriteria(AcqUser.class);
			    ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("userId"));
			     proList.add(Projections.property("loginId"));
			     proList.add(Projections.property("orgId"));
			     user.setProjection(proList);
			     user.add((Restrictions.in("userId", userSet)));
			    List list1 = user.list();
			    usermap= new HashMap<String,String>();
			    for(Object obj:list1){
			        Object[] ob=(Object[])obj;
			        usermap.put("loginId"+ob[0],""+ob[2]);
			        orgSet.add(Long.valueOf(""+ob[2]));
			    }
			}catch(Exception e){
				logger.error("error in select user in wallet report "+e);
			}
			try{
				Criteria org =session.createCriteria(AcqOrganization1.class);
			    ProjectionList proList = Projections.projectionList();
			     proList.add(Projections.property("orgId"));
			     proList.add(Projections.property("name"));
			     proList.add(Projections.property("merchantId"));
			     org.setProjection(proList).add((Restrictions.in("orgId", orgSet)));
			    List list1 = org.list();
			    orgmap= new HashMap<String,String>();
			    for(Object obj:list1){
			        Object[] ob=(Object[])obj;
			        orgmap.put("orgName"+ob[0],""+ob[2]);	
			        merchantSet.add(Integer.parseInt(""+ob[2]));
			    }
			}catch(Exception e){
				logger.error("error to select organization "+e);
			}try{
				merchantMap= new HashMap<String,String>();
				 if(merchantSet.isEmpty()){
				    logger.info("merchant set is empty");		
				    merchantMap.put("merchantName0","NA");
			        merchantMap.put("mid0","0");
				 }else{
					 Criteria merchant =session.createCriteria(AcqMerchant.class);
					 ProjectionList proList = Projections.projectionList();
				     proList.add(Projections.property("merchantId"));
				     proList.add(Projections.property("merchantName"));
				     merchant.setProjection(proList).add((Restrictions.in("merchantId", merchantSet)));
				     List merchantList = merchant.list();
				     if(merchantList.isEmpty()){
				    	logger.info("user Not Found");					
						map.put("1", "123");
						globalList.add(map);
						globleMap.setResult(globalList);
						globleMap.setStatus(AcqStatusDefination.NotFound.getIdentifier());
						globleMap.setMessage(AcqStatusDefination.NotFound.getDetails());
						logger.info("Inventory Device List selected successfully");
						return globleMap;	
				     }				     
				     for(Object obj:merchantList){
				        Object[] ob=(Object[])obj;
				        merchantMap.put("merchantName"+ob[0],""+ob[1]);
				        merchantMap.put("mid"+ob[0],""+ob[0]);
				     }
				 }
			}catch(Exception e){
				logger.error("error to select merchant "+e);
			}
			}
			}
			AcqInventoryDeviceEntity entit = null;
			while(etr.hasNext()){
				entit = (AcqInventoryDeviceEntity)etr.next();
				singleMap = new HashMap<String,String>();
				singleMap.put("id",""+entit.getInventoryDeviceId());
			    singleMap.put("modelName",""+entit.getModelName());
			    singleMap.put("serialNo",""+entit.getInventorySerialNo());
			    singleMap.put("status",""+entit.getStatus());
			    singleMap.put("batrySerialNo",""+entit.getBatterySerialNo());
			    singleMap.put("adapterSerialNo",""+entit.getAdapterSerialNo());
			    singleMap.put("dsaList",""+entit.getDsaList());
			    singleMap.put("empRole",""+emp1.getEmpRole());
			    if(userSet.isEmpty()){
			    	singleMap.put("merchantName","NA");
			    	singleMap.put("mid","0");
			    }else{
			    	String str = merchantMap.get("merchantName"+orgmap.get("orgName"+usermap.get("loginId"+deviceMap.get("userId"+entit.getInventorySerialNo()))));
			    	System.out.println("str::::"+str);
			    	if(str==null||str==""){
			    		singleMap.put("merchantName","NA");
			    		singleMap.put("mid","0");
			    	}else{
			    		singleMap.put("merchantName",""+merchantMap.get("merchantName"+orgmap.get("orgName"+usermap.get("loginId"+deviceMap.get("userId"+entit.getInventorySerialNo())))));
			    		singleMap.put("mid",""+merchantMap.get("mid"+orgmap.get("orgName"+usermap.get("loginId"+deviceMap.get("userId"+entit.getInventorySerialNo())))));
			    	}
			    }
			    singleMap.put("acquirerCode",""+entit.getAcquirer());
			    globalList.add(singleMap);
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
			logger.info("Inventory Device List selected successfully");
			return globleMap;			
		}catch(Exception e){
			logger.info("error to select Inventory Device list"+e);
			return null;
		}
	}
	

	
	
	@Transactional
	public DbDto<AcqInventoryDeviceModel> inventoryAddDevice(AcqInventoryDeviceModel model) {
		logger.info("Request landing in Add inventory Device Dao");
		DbDto<AcqInventoryDeviceModel> response = new DbDto<AcqInventoryDeviceModel>();
		//Session session = null;
		try{
			Session session = AcqMerchantDaoImpl.getSession();
			Transaction tx = session.beginTransaction();
			String dbserialNo=null;
			String banktid = null;			
			if (model.getInventorySerialNo() != null && model.getInventorySerialNo() != "") {
				dbserialNo = (String) session.createCriteria(AcqInventoryDeviceEntity.class).setProjection(Projections.property("inventorySerialNo")).add(Restrictions.eq("inventorySerialNo",model.getInventorySerialNo())).uniqueResult();     
			}
			
			if ( (dbserialNo != null && dbserialNo != "")|| (banktid != null && banktid != "")) {
				if (banktid != null && banktid!="") {
					logger.info("TID already in use with other account");
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage("TID Already Exist");
				} else if (dbserialNo != null && dbserialNo != "") {
					logger.info("Device Serial No. already in use with other account");
					response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
					response.setMessage("Device Serial No. Already Exist");
				}
			}else{
				AcqInventoryDeviceEntity entity = new AcqInventoryDeviceEntity();
				entity.setModelName(model.getModelName());
				entity.setInventorySerialNo(model.getInventorySerialNo());
				entity.setStatus(model.getStatus());
				if(model.getBatterySerialNo()!=null&&model.getBatterySerialNo()!=""){
					entity.setBatterySerialNo(model.getBatterySerialNo());
					
				}else{
					entity.setBatterySerialNo("NA");
					
				}
				if(model.getAdapterSerialNo()!=null&&model.getAdapterSerialNo()!=""&&model.getAdapterSerialNo().length()>1){
					entity.setAdapterSerialNo(model.getAdapterSerialNo());
					
				}else{
					entity.setAdapterSerialNo("NA");
					
				}
				
				entity.setDsaList(model.getDsaList());
				entity.setAcquirer("Acquiro");
				session.save(entity);
				tx.commit();
				response.setStatus(AcqStatusDefination.OK.getIdentifier());
				response.setMessage(AcqStatusDefination.OK.getDetails());
				logger.info("Inventory Device Added Successfully");
			}   
		}catch (Exception e) {
		   response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
		   response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   logger.error("error to add inventory device"+e);
	   	}
		return response;
	}


	
	
		
}
	

