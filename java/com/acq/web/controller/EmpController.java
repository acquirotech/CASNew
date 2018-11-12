package com.acq.web.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
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
import com.acq.AcqStatusDefination;
import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
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
	
	@RequestMapping(value = { "/deleteEmployee" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> deleteEmployee(@RequestParam String dummyUser ,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		ControllerResponse<Object> response = new ControllerResponse<Object>();
	if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				ServiceDto<String> handerResponse = empManagementHandler.deleteEmployee(dummyUser);
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
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" )
	    {
			 model.setViewName("addEmployee");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value = { "/empProfile" }, method = RequestMethod.POST)
	public ModelAndView empProfile(@RequestParam (required = true)String empId,HttpServletRequest request) {
		logger.info("request for emp profile home");
		HashMap<String,String> empprofile = null; 
		ModelAndView model = new ModelAndView();
	 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		ServiceDto<HashMap<String,String>> globleMap = empManagementHandler.empProfile(empId);
	    		empprofile = globleMap.getResult();
	    		model.addObject("empId", empprofile.get("empId"));
			 	model.addObject("empName", empprofile.get("empName"));
			 	model.addObject("empEmailId", empprofile.get("empEmailId"));
			 	model.addObject("empPhone", empprofile.get("empPhone"));
			 	model.addObject("empEnabled", empprofile.get("empEnabled"));
			 	model.addObject("empCreatedOn", empprofile.get("empCreatedOn"));
			 	model.addObject("empRole", empprofile.get("empRole"));
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
