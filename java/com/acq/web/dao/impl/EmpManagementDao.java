package com.acq.web.dao.impl;

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

import com.acq.AcqBase;
import com.acq.AcqStatusDefination;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.users.entity.AcqEmpPasswordEntity;
import com.acq.users.entity.AcqEmpRoleEntity;
import com.acq.users.model.AcqMerchant;
import com.acq.users.model.AcqOrganization1;
import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dao.EmpManagementDaoInf;
import com.acq.web.dto.impl.DbDto;

@Repository
public class EmpManagementDao implements EmpManagementDaoInf {

	final static Logger logger = Logger.getLogger(EmpManagementDao.class);  

	@Autowired
	AcqMerchantDaoImpl AcqMerchantDaoImpl;
	
	
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
				        if(""+ob[4].equals("1") != null){
				        	 empMap.put("enabled","Active"); 
				        }else{
				        	 empMap.put("enabled","DeActive"); 
				        }
				        if(""+ob[6].equals("2") != null){
							empMap.put("empRole", "Boarding");
						}else if(""+ob[6].equals("6") != null){
							empMap.put("empRole", "PreBoarding");
						}else if(""+ob[6].equals("5") != null){
							empMap.put("empRole", "Sales");
						}else if(""+ob[6].equals("3") != null){
							empMap.put("empRole", "Billing");
						}else if(""+ob[6].equals("4") != null){
							empMap.put("empRole", "Support");
						}else if(""+ob[6].equals("1") != null){
							empMap.put("empRole", "Admin");
						}else if(""+ob[6].equals("7") != null){
							empMap.put("empRole", "SeniorSupport");
						}else if(""+ob[6].equals("8") != null){
							empMap.put("empRole", "HR");
						}else if(""+ob[6].equals("9") != null){
							empMap.put("empRole", "Sales Coordinator ");
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
			AcqEmpRoleEntity emp = (AcqEmpRoleEntity) session.createCriteria(AcqEmpRoleEntity.class).add(Restrictions.eq("id", Long.valueOf(empId))).uniqueResult();
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

