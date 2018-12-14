package com.acq.web.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acq.AcqAuthToken;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqDSAModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqTeleCallerModel;
import com.acq.web.dto.ResponseInf;
import com.acq.web.dto.impl.ControllerResponse;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.EmpManagementHandlerInf;
import com.acq.web.handler.ListHandlerInf;

@Controller
public class EmpController {

	final static Logger logger = Logger.getLogger(EmpController.class);
	@Autowired
	ListHandlerInf walletHandler;
	@Autowired
	EmpManagementHandlerInf empManagementHandler;
	
	@RequestMapping(value = { "/updateTeleCustomer" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> updateTeleCustomer(@ModelAttribute AcqTeleCallerModel modell,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		ControllerResponse<Object> response = new ControllerResponse<Object>();
	if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				modell.setUser(AcqAuthToken.getAuthToken().getName());
				ServiceDto<String> handerResponse = empManagementHandler.updateTeleCustomer(modell);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
				logger.info("createTeleCustomer in controller:"+handerResponse.getStatus());
			}catch(Exception e){
				logger.error("error to createTeleCustomer in controller:"+e); 
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   }
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }		
	   return response;
	 }
	
	
	@RequestMapping(value = { "/callerDetails" }, method = RequestMethod.GET)
	public ModelAndView callerDetails(AcqBillingModel modell,HttpServletRequest request) {
		logger.info("request for emp profile home");
		HashMap<String,String> custprofile = null; 
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null; 
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		String  callerId = modell.getCallerId();
	    		ServiceDto<HashMap<String,String>> globleMap = empManagementHandler.callerDetails(callerId);
	    		custprofile = globleMap.getResult();
	    		ServiceDto<List<HashMap<String,String>>> merchantList= walletHandler.txnMerchantlist(modell);
				list = merchantList.getResult();
				model.addObject("merchantList", list);
	    		model.addObject("id",custprofile.get("id"));
				model.addObject("callerName",custprofile.get("callerName"));	
				model.addObject("callPurpose",custprofile.get("callPurpose"));
				model.addObject("dateTime",""+custprofile.get("dateTime"));
				model.addObject("userName",custprofile.get("userName"));
				model.addObject("merchantName",custprofile.get("merchantName"));
				model.addObject("commentsList",custprofile.get("comments"));
				model.addObject("callType",custprofile.get("callType"));
				model.addObject("callbackNo",custprofile.get("callbackNo"));
				model.setViewName("callerDetails");
				logger.info("response returned from emp profile controller:::::::"+custprofile);
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	
	
	@RequestMapping(value = { "/teleCustomerList" }, method = RequestMethod.GET)
	public ModelAndView teleCustomerList(@ModelAttribute AcqSearchModel modell,HttpServletRequest request) {
		logger.info("request landing on request create createTeleCustomer");
		ModelAndView model = new ModelAndView();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ) 
	    {
	    	 if(AcqNumericValidator.checkId(modell.getPage())!=true){
		    	  modell.setPage("1");
		      }else
		    	  modell.setPage(modell.getPage());	
	    	 HttpSession session = request.getSession();		
	     modell.setUserId((String)session.getAttribute("empRole"));
		 ServiceDto<List<HashMap<String,String>>> handlerResponse = empManagementHandler.teleCustomerList(modell);
		 List<HashMap<String,String>> merchantList = handlerResponse.getResult();
	  	 HashMap<String,String> map = merchantList.get(0);
	  	 model.addObject("totalRows", map.get("rows"));       
	  	 merchantList.remove(0);
	  	 model.addObject("basicMerchantDetails", merchantList);
	  	 model.addObject("page",modell.getPage());   
	  	model.addObject("empRole",modell.getUserId());   
	     System.out.println("modell.getPage()modell.getPage()modell.getPage():"+modell.getPage());
	     model.setViewName("customerListForm");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = { "/createTeleCustomer" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> createTeleCustomerr(@ModelAttribute AcqTeleCallerModel modell,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		ControllerResponse<Object> response = new ControllerResponse<Object>();
	if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				modell.setUser(AcqAuthToken.getAuthToken().getName());
				ServiceDto<String> handerResponse = empManagementHandler.createTeleCustomer(modell);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
				logger.info("createTeleCustomer in controller:"+handerResponse.getStatus());
			}catch(Exception e){
				logger.error("error to createTeleCustomer in controller:"+e); 
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   }
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }		
	   return response;
	 }
	@RequestMapping(value = { "/createTeleCustomer" }, method = RequestMethod.GET)
	public ModelAndView createTeleCustomer(AcqBillingModel modell,HttpServletRequest request) {
		logger.info("request landing on request create createTeleCustomer");
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null; 
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String,String>>> merchantList= walletHandler.txnMerchantlist(modell);
			list = merchantList.getResult();
			model.addObject("merchantList", list);
		model.setViewName("createCustomerForm");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value = { "/deleteTeleCaller" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> deleteTeleCaller(@RequestParam String dummyUser ,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		ControllerResponse<Object> response = new ControllerResponse<Object>();
	if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				ServiceDto<String> handerResponse = empManagementHandler.deleteTeleCaller(dummyUser);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
				logger.info("delete Employee in controller:"+handerResponse.getStatus());
			}catch(Exception e){
				logger.error("error to delete Employee in controller:"+e); 
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   }
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }		
	   return response;
	 }
	
	
	
	@RequestMapping(value = {"/updateDSA" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updateDSA(@ModelAttribute AcqDSAModel modell,HttpServletRequest request)  {
		logger.info("request landing in update DSA ::");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqDSAModel>> inputErrSet= validator.validate(modell);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqDSAModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqDSAModel> validate = (ConstraintViolation<AcqDSAModel>)itr.next();
					String vErrors = validate.getPropertyPath() + "-" + validate.getMessage()+ "-"+ validate.getInvalidValue();
					logger.info("request landing in update DSA ::"+vErrors);
					
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}				
			}else{
				ServiceDto<AcqDSAModel> handerResponse = empManagementHandler.updateDSA(modell);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
			}
		}catch(Exception e){
			logger.error("error to update DSA  in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	
	
	@RequestMapping(value = { "/dsaManagement" }, method = RequestMethod.GET)
	public ModelAndView dsaManagement(HttpServletRequest request) {
		logger.info("request for DSA lockunlock List");
		List<HashMap<String,String>> list = null; 
		ModelAndView model = new ModelAndView();
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		ServiceDto<List<HashMap<String,String>>> globleMap = empManagementHandler.dsaManagement();
	    		list = globleMap.getResult();
	    		model.addObject("empList", list);
	    		model.addObject("");
	    		model.setViewName("dsaList");
	    		logger.info("response returned from Dsa List controller");
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    		
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	
	@RequestMapping(value = {"/addDsaDetails" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> addDSA(@ModelAttribute AcqDSAModel modell,HttpServletRequest request)  {
		logger.info("request landing in add DSA details");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqDSAModel>> inputErrSet= validator.validate(modell);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqDSAModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqDSAModel> validate = (ConstraintViolation<AcqDSAModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}				
			}else{
				ServiceDto<AcqDSAModel> handerResponse = empManagementHandler.addDsa(modell);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
			}
		}catch(Exception e){
			logger.error("error to dsa details in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	
	
	
	@RequestMapping(value = { "/addDSA" }, method = RequestMethod.GET)
	public ModelAndView addDSA(HttpServletRequest request) {
		logger.info("request landing on request add DSA");
		ModelAndView model = new ModelAndView();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" )
	    {
			 model.setViewName("addDsaDetails");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	
	
	
	@RequestMapping(value = { "/deleteEmployee" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> deleteEmployee(@RequestParam String id2Delete ,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		ControllerResponse<Object> response = new ControllerResponse<Object>();
	if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				ServiceDto<String> handerResponse = empManagementHandler.deleteEmployee(id2Delete);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
				logger.info("delete Employee in controller:"+handerResponse.getStatus());
			}catch(Exception e){
				logger.error("error to delete Employee in controller:"+e); 
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		   }
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }		
	   return response;
	 }
	
	@RequestMapping(value = { "/empChangePassword" }, method = RequestMethod.GET)
	public ModelAndView empChangePassword(@RequestParam (required = false)String empEmailId,HttpServletRequest request) {
		logger.info("request for emp change profile home");
		HashMap<String,String> empprofile = null; 
		ModelAndView model = new ModelAndView();
		if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		empEmailId = AcqAuthToken.getAuthToken().getName();
	    		ServiceDto<HashMap<String,String>> globleMap  = empManagementHandler.empChangePassword1(empEmailId);
	    		empprofile = globleMap.getResult();
	    		model.addObject("empId", empprofile.get("empId"));
			 	model.addObject("empName", empprofile.get("empName"));
			 	model.addObject("empEmailId", empprofile.get("empEmailId"));
			 	model.addObject("empPhone", empprofile.get("empPhone"));
			 	model.addObject("empEnabled", empprofile.get("empEnabled"));
			 	model.addObject("empCreatedOn", empprofile.get("empCreatedOn"));
			 	model.addObject("empRole", empprofile.get("empRole"));
			 	model.addObject("reportManager", empprofile.get("reportManager"));
				model.setViewName("empchangepassword");
				System.out.println("wwwwwwwwwwwww::");
				logger.info("response returned from emp profile controller");
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}


	@RequestMapping(value = {"/empChangePassword" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> empChangePassword(@ModelAttribute AcqEmpDetailsModel modell,HttpServletRequest request)  {
		logger.info("request landing in emp change password");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqEmpDetailsModel>> inputErrSet= validator.validate(modell);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqEmpDetailsModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqEmpDetailsModel> validate = (ConstraintViolation<AcqEmpDetailsModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}				
			}else{
				ServiceDto<AcqEmpDetailsModel> handerResponse = empManagementHandler.empChangePassword(modell);
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
			}
		}catch(Exception e){
			logger.error("error to emp change password in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}

	
	@RequestMapping(value = { "/addEmployee" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> addEmployee(AcqCreateEmployeeModel model,HttpServletRequest request) {
		logger.info("request is landing add Employee Controller");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqCreateEmployeeModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqCreateEmployeeModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqCreateEmployeeModel> validate = (ConstraintViolation<AcqCreateEmployeeModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{
				ServiceDto<Object> handlerResponse = empManagementHandler.addEmployee(model);
				response.setStatus(handlerResponse.getStatus());
				response.setMessage(handlerResponse.getMessage());
				response.setResult(handlerResponse.getResult());	
				logger.info("response returned for add Employee");
			}
		}catch(Exception e){
			response.setStatus(100);
			response.setMessage("error in add Employee controller");
			response.setResult(null);
			logger.error("Error in add Employee controller "+e);
		}
		return response;
	}	
	
	@RequestMapping(value = { "/addEmployee" }, method = RequestMethod.GET)
	public ModelAndView addEmployee(HttpServletRequest request) {
		logger.info("request landing on request create Employee");
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null;
		List<HashMap<String,String>> emplist = null;
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" )
	    {
			 ServiceDto<List<HashMap<String, String>>> global= empManagementHandler.empReportList();
			 ServiceDto<List<HashMap<String, String>>> globalempList= empManagementHandler.empList();
			// model.addObject("employeeName",(String)ses.getAttribute("userName"));
				list = global.getResult();
				model.addObject("executiveList", list);
				emplist = globalempList.getResult();
				model.addObject("executiveEmpList", emplist);
			 model.setViewName("addEmployee");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = { "/empProfileTopBar" }, method = RequestMethod.GET)
	public ModelAndView empProfileTopBar(HttpServletRequest request) {
		logger.info("request for emp profile home");
		HashMap<String,String> empprofile = null; 
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null;
		
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		String	 empId =  AcqAuthToken.getAuthToken().getName();	    		
	    		System.out.println("id:::"+empId);
	    		ServiceDto<HashMap<String,String>> globleMap = empManagementHandler.empProfile(empId);
	    		empprofile = globleMap.getResult();
	    		model.addObject("empId", empprofile.get("empId"));
			 	model.addObject("empName", empprofile.get("empName"));
			 	model.addObject("empEmailId", empprofile.get("empEmailId"));
			 	model.addObject("empPhone", empprofile.get("empPhone"));
			 	model.addObject("empEnabled", empprofile.get("empEnabled"));
			 	model.addObject("empCreatedOn", empprofile.get("empCreatedOn"));
			 	model.addObject("empRole", empprofile.get("empRole"));
			 	model.addObject("reportManager", empprofile.get("reportManager"));
			 	ServiceDto<List<HashMap<String, String>>> global= empManagementHandler.empReportList();
				list = global.getResult();
				model.addObject("empList", list);
				model.setViewName("empprofile");
				logger.info("response returned from emp profile controller");
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	@RequestMapping(value = { "/empProfile" }, method = RequestMethod.POST)
	public ModelAndView empProfile(@RequestParam String empId,HttpServletRequest request) {
		logger.info("request for emp profile home");
		HashMap<String,String> empprofile = null; 
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null;
		
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    	
	    		System.out.println("id:::"+empId);
	    		ServiceDto<HashMap<String,String>> globleMap = empManagementHandler.empProfile(empId);
	    		empprofile = globleMap.getResult();
	    		model.addObject("empId", empprofile.get("empId"));
			 	model.addObject("empName", empprofile.get("empName"));
			 	model.addObject("empEmailId", empprofile.get("empEmailId"));
			 	model.addObject("empPhone", empprofile.get("empPhone"));
			 	model.addObject("empEnabled", empprofile.get("empEnabled"));
			 	model.addObject("empCreatedOn", empprofile.get("empCreatedOn"));
			 	model.addObject("empRole", empprofile.get("empRole"));
			 	model.addObject("reportManager", empprofile.get("reportManager"));
			 	ServiceDto<List<HashMap<String, String>>> global= empManagementHandler.empReportList();
				list = global.getResult();
				model.addObject("empList", list);
				model.setViewName("empprofile");
				logger.info("response returned from emp profile controller");
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	
	@RequestMapping(value = { "/emplockunlock" }, method = RequestMethod.GET)
	public ModelAndView emplockunlock(HttpServletRequest request) {
		logger.info("request for emp lockunlock List");
		List<HashMap<String,String>> list = null; 
		ModelAndView model = new ModelAndView();
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		ServiceDto<List<HashMap<String,String>>> globleMap = empManagementHandler.emplockunlock();
	    		list = globleMap.getResult();
	    		model.addObject("empList", list);
	    		model.addObject("");
	    		model.setViewName("empmanagement");
	    		logger.info("response returned from emp lockunlock controller");
	    	}catch(Exception e){
	    		logger.error("error in controller "+e);
	    		
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	@RequestMapping(value = {"/empChangeProfile" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> empChangeProfile(@ModelAttribute AcqEmpDetailsModel modell,HttpServletRequest request)  {
		logger.info("request landing in emp change profile");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		List<HashMap<String,String>> list = null;
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqEmpDetailsModel>> inputErrSet= validator.validate(modell);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqEmpDetailsModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqEmpDetailsModel> validate = (ConstraintViolation<AcqEmpDetailsModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}				
			}else{
				
				ServiceDto<AcqEmpDetailsModel> handerResponse = empManagementHandler.empChangeProfile(modell);
				 ServiceDto<List<HashMap<String, String>>> global= empManagementHandler.empList();
				// model.addObject("employeeName",(String)ses.getAttribute("userName"));
				/*list = global.getResult();
				model.addObject("executiveList", list);*/
				response.setStatus(handerResponse.getStatus());
				response.setMessage(handerResponse.getMessage());
				response.setResult(handerResponse.getResult());
			}}catch(Exception e){
				logger.error("error to update emp in controller:"+e);	
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			}
			return response;
	}
}
