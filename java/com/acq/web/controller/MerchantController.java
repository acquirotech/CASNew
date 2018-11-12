package com.acq.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
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

import org.apache.commons.io.IOUtils;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acq.AcqAuthToken;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.web.controller.model.AcqInventoryDeviceModel;
import com.acq.web.controller.model.AcqMerchantNewModel;
import com.acq.web.controller.model.AcqNewDeviceDetailModel;
import com.acq.web.controller.model.AcqNewOrganization;
import com.acq.web.controller.model.AcqNewUpdateDeviceDetailModel;
import com.acq.web.controller.model.AcqNewUpdateMerchantModel;
import com.acq.web.controller.model.AcqNewUpdateOrgModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dto.ResponseInf;
import com.acq.web.dto.impl.ControllerResponse;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.MerchantHanlderInf;
import com.acq.web.handler.ListHandlerInf;

@Controller
public class MerchantController {

	final static Logger logger = Logger.getLogger(MerchantController.class);

	@Autowired
	ListHandlerInf walletHandler;

	@Autowired
	MerchantHanlderInf merchantHandler;

	@Value("#{AcqConfig['generateMerchant.location']}")
	private String mrchntDetails;
	public String getMrchntDetails() {
		return mrchntDetails;
	}

	@Value("#{AcqConfig['preBoard.location']}")
	private String preBoardLocation;
	public String getPreBoardLocation() {
		return preBoardLocation;
	}
	
	@RequestMapping(value = { "/downloadDeviceDetails" }, method = RequestMethod.GET)
	public ModelAndView downloadDeviceDetails(@RequestParam (required=true)String fromDate,@RequestParam (required=true)String toDate,HttpServletRequest request) {
		List<HashMap<String,String>> list = null;
		logger.info("request for donwload Device Details home");
		ModelAndView model = new ModelAndView();
		try{
		     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
				ServiceDto<List<HashMap<String, String>>> global= merchantHandler.downloadDeviceDetails(fromDate,toDate);
				list = global.getResult();
				model.addObject("billDetailsList", list);
				model.setViewName("downloadInventoryDeviceReport");
				logger.info("response returned from download Device Details controller");
		    }else{
				logger.info("you are logged out download Device details");
				model.setViewName("index");
			}
		}catch(Exception e){
			logger.error("error to call dao method");
		}
		return model;
	}
	  	
	@RequestMapping(value = { "/merchantActivityHome" }, method = RequestMethod.GET)
	public ModelAndView merchantActivityHome(HttpServletRequest request, HttpServletResponse res) {
		logger.info("request landing on merchant activity home");
		ModelAndView model = new ModelAndView();
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
		if(AcqAuthToken.getAuthToken().getName() != "anonymousUser" || AcqAuthToken.getAuthToken().getPrincipal() != "anonymousUser" ) {
			model.setViewName("merchantActivityHome");
		}else{
			logger.info("you are logged out merchant activity home");
			model.setViewName("index");
		}
		return model;
	}		
	  
	@RequestMapping(value="/view_docs_preboard", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getPDF(@RequestParam String param) {
		logger.info("merchant view docs is invoked....");
		File file = new File(preBoardLocation+File.separator+param+".pdf");
		byte[] contents = null;
		if(file.exists()){
			try {
				InputStream inputStream = new FileInputStream(file);
				contents = IOUtils.toByteArray(inputStream);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			logger.warn("file not found");
			return null;
		}
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.parseMediaType("application/pdf"));
	    String filename = "output.pdf";
	    headers.setContentDispositionFormData(filename, filename);
	    headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
	    ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(contents, headers, HttpStatus.OK);
	    return response;
	}
	
	@RequestMapping(value = {"/gnrtExcelSheet"}, method = RequestMethod.GET)
	public HttpEntity<byte[]> getDetails(@RequestParam (required=true) String signImage) {
		byte[] document = null;
		 HttpHeaders header = new HttpHeaders();
		ServiceDto<Object> daoResponse = merchantHandler.downloadMerchantDtls(signImage);
		if(daoResponse.getStatus()==AcqStatusDefination.OK.getIdentifier()&&daoResponse.getMessage().equals(AcqStatusDefination.OK.getDetails())){
			File file = new File(mrchntDetails + File.separator+"SCHEDULE Prop.xlsx");
		    if(file.exists()){
				try {
					document = FileCopyUtils.copyToByteArray(file);
				} catch (IOException e) {
					e.printStackTrace();
				}
		        header.setContentType(new MediaType("application", "vnd.openxmlformats-officedocument.spreadsheetml.sheet"));
		        header.set("Content-Disposition", "inline; filename=" + file.getName());
		        header.setContentLength(document.length);
		        return new HttpEntity<byte[]>(document, header);
		    }else{
	        	logger.warn("file does not exist");
	        }
		}
		return new HttpEntity<byte[]>(document, header);		
	}
	
	
	
	@RequestMapping(value = { "/dEviceLst" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> deviceList(@RequestParam String accessKey ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<Object> handerResponse = merchantHandler.deviceList(accessKey);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
			logger.error("error to inventory device in controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	
	
	@RequestMapping(value = { "/updatedevicedetails" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updatedevicedetail(@ModelAttribute AcqNewUpdateDeviceDetailModel model,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		logger.info("logger type controller:");
		try{
			if(model.getIntegrationKey()!=null&&model.getIntegrationKey().equalsIgnoreCase("csrf")){
				response.setStatus(100);
				response.setMessage("Invalid Integraion Key");
				return response;
			}
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqNewUpdateDeviceDetailModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqNewUpdateDeviceDetailModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqNewUpdateDeviceDetailModel> validate = (ConstraintViolation<AcqNewUpdateDeviceDetailModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{
					ServiceDto<Object> handerResponse = merchantHandler.updatedevicedetail(model);
					response.setStatus(handerResponse.getStatus());
					response.setMessage(handerResponse.getMessage());
					response.setResult(handerResponse.getResult());
			}}catch(Exception e){
				logger.error("error to delete merchant in controller:"+e);	
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			}
			return response;
	}
	
	
	@RequestMapping(value = { "/updateOrg" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updateOrg(@ModelAttribute AcqNewUpdateOrgModel model,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqNewUpdateOrgModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqNewUpdateOrgModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqNewUpdateOrgModel> validate = (ConstraintViolation<AcqNewUpdateOrgModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{
					ServiceDto<AcqNewUpdateOrgModel> handerResponse = merchantHandler.updateOrg(model);
					response.setStatus(handerResponse.getStatus());
					response.setMessage(handerResponse.getMessage());
					response.setResult(handerResponse.getResult());
			}
		}catch(Exception e){
			logger.error("error to update org in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	
	@RequestMapping(value = { "/updatemerchant" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updateMerchant(AcqNewUpdateMerchantModel model,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqNewUpdateMerchantModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqNewUpdateMerchantModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqNewUpdateMerchantModel> validate = (ConstraintViolation<AcqNewUpdateMerchantModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
					model.setOnBoardUpdateExeName(AcqAuthToken.getAuthToken().getName());
				}
			}else{
				
					ServiceDto<Object> handerResponse = merchantHandler.updateMerchant(model);
					response.setStatus(handerResponse.getStatus());
					response.setMessage(handerResponse.getMessage());
					logger.info("successfully updated and return from update merchant controller:");	
			}
		}catch(Exception e){
			logger.error("error to delete merchant in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	

@RequestMapping(value = { "/merchantDelete" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> merchantDelete(@RequestParam String merchantId ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{			
			ServiceDto<String> handerResponse = merchantHandler.merchantDelete(merchantId);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
				logger.error("error to delete merchant in controller:"+e);	
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			}
			return response;
	}
	
	@RequestMapping(value = { "/deleteorg" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> deleteorg(@RequestParam String orgId ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<String> handerResponse = merchantHandler.deleteorg(orgId);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
				logger.error("error to delete merchant in controller:"+e);	
				response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
				response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			}
			return response;
	}
	
	@RequestMapping(value = { "/devicedelete" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> devicedelete(@RequestParam String userId,String orgId ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<String> handerResponse = merchantHandler.devicedelete(userId,orgId);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
			logger.error("error to delete merchant in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	
	@RequestMapping(value = { "/addDeviceDetail"}, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> addDeviceDetailHome(AcqNewDeviceDetailModel model,HttpServletRequest request,HttpServletResponse res) {
		logger.info("request is landing add Device ");
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		ServiceDto<Object> verifyTokenRes =  null;
		try{
			if(model.getIntegrationKey()!=null&&model.getIntegrationKey().equalsIgnoreCase("csrf")){
				response.setStatus(100);
				response.setMessage("Invalid Integraion Key");
				return response;
			}
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqNewDeviceDetailModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqNewDeviceDetailModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqNewDeviceDetailModel> validate = (ConstraintViolation<AcqNewDeviceDetailModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{
				ServiceDto<Object> handlerResponse = merchantHandler.addDeviceDetail(model);
				response.setStatus(handlerResponse.getStatus());
				response.setMessage(handlerResponse.getMessage());
				response.setResult(handlerResponse.getResult());
				logger.info("response returned for add Device");
			}
		}catch(Exception e){
			response.setStatus(100);
			response.setMessage("error in add Device controller");
			response.setResult(null);
			logger.error("Error in add Device controller "+e);
		}
		return response;
	}
	
	
	
	@RequestMapping(value = { "/addOrg" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> addOrganization(AcqNewOrganization model,HttpServletRequest request, HttpServletResponse res) {
		logger.info("request is landing add Organization");
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqNewOrganization>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqNewOrganization>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqNewOrganization> validate = (ConstraintViolation<AcqNewOrganization>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{
				ServiceDto<Object> handlerResponse = merchantHandler.addOrganization(model);
				response.setStatus(handlerResponse.getStatus());
				response.setMessage(handlerResponse.getMessage());
				response.setResult(handlerResponse.getResult());	
				logger.info("response returned for add Organization");
			}
			return response;
		}catch(Exception e){
			response.setStatus(100);
			response.setMessage("error in add Organization controller");
			response.setResult(null);
			logger.error("Error in add Organization controller "+e);
		}
		return response;
	}
	
	@RequestMapping(value = { "/addPreBoardMerchant" }, method = RequestMethod.GET)
	public ModelAndView addPreBoardMerchant(HttpServletRequest request, HttpServletResponse res) {
		logger.info("request landing add preBoard merchant home home page");
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
		List<HashMap<String,String>> list = null;
		ModelAndView model = new ModelAndView();
		HttpSession ses = request.getSession();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String, String>>> global= merchantHandler.executivesList();
			list = global.getResult();
			model.addObject("executiveList", list);
			model.addObject("employeeName",(String)ses.getAttribute("userName"));
			model.setViewName("PreBoardMerchant");
	    }else{
			logger.info("you are logged out add merchant 1");
			model.setViewName("index");
		}
		return model;
	}
	
	@RequestMapping(value = { "/addmerchant" }, method = RequestMethod.GET)
	public ModelAndView addMerchantHome(HttpServletRequest request, HttpServletResponse res) {
		logger.info("request landing add merchant home home page");
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
		List<HashMap<String,String>> list = null;
		ModelAndView model = new ModelAndView();
		HttpSession ses = request.getSession();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String, String>>> global= merchantHandler.executivesList();
			list = global.getResult();
			model.addObject("executiveList", list);
			model.addObject("employeeName",(String)ses.getAttribute("userName"));
			model.setViewName("addmerchant");
	    }else{
			logger.info("you are logged out add merchant 1");
			model.setViewName("index");
		}
		return model;
	}

	@RequestMapping(value = { "/addmerchant" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> merchantTxnList(AcqMerchantNewModel model,HttpServletRequest request) {
		logger.info("request is landing add merchant");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqMerchantNewModel>> inputErrSet= validator.validate(model);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqMerchantNewModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqMerchantNewModel> validate = (ConstraintViolation<AcqMerchantNewModel>)itr.next();
					response.setStatus(100);
					response.setMessage(validate.getMessage());
				}
			}else{	
				model.setOnBoardUpdateEmpName(AcqAuthToken.getAuthToken().getName());
					ServiceDto<Object> handlerResponse = merchantHandler.addMerchant(model);
					response.setStatus(handlerResponse.getStatus());
					response.setMessage(handlerResponse.getMessage());
					response.setResult(handlerResponse.getResult());	
					logger.info("response returned for add merchant");					
					return response;
			}
		}catch(Exception e){
			response.setStatus(100);
			response.setMessage("error in add merchant controller");
			response.setResult(null);
			logger.error("Error in add merchant controller "+e);
		}
		return response;
	}
	
	
	
	@RequestMapping(value = { "/inventoryDeviceDelete" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> inventoryDeviceDelete(@RequestParam String deviceId ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{   
			ServiceDto<String> handerResponse = merchantHandler.inventoryDeviceDelete(deviceId);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
			logger.error("error to delete inventory device in controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
	   }
	   return response;
	 }
	 
	 @RequestMapping(value = { "/inventoryUpdateDevice" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> inventoryUpdateDevice(@ModelAttribute AcqInventoryDeviceModel model,HttpServletRequest request) {
		 ControllerResponse<Object> response = new ControllerResponse<Object>();
		 logger.info("Request landing in inventory device update");
		 try{
			 ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			 Validator validator = vFactory.getValidator();
			 Set<ConstraintViolation<AcqInventoryDeviceModel>> inputErrSet= validator.validate(model);
			 if(inputErrSet.size()>0){
				 Iterator<ConstraintViolation<AcqInventoryDeviceModel>> itr = inputErrSet.iterator();
				 while(itr.hasNext()){
					 ConstraintViolation<AcqInventoryDeviceModel> validate = (ConstraintViolation<AcqInventoryDeviceModel>)itr.next();
					 response.setStatus(100);
					 response.setMessage(validate.getMessage());
				 }
			 }else{
					 ServiceDto<AcqInventoryDeviceModel> handerResponse = merchantHandler.inventoryUpdateDevice(model);
					 response.setStatus(handerResponse.getStatus());
					 response.setMessage(handerResponse.getMessage());
					 response.setResult(handerResponse.getResult());
			 }
		}catch(Exception e){
			logger.error("error to update Inventory Device in controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	 }
	
	@RequestMapping(value = { "/InventoryDeviceList" }, method = RequestMethod.GET)
	public ModelAndView InventoryDeviceList(AcqSearchModel modell,HttpServletRequest request){
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null; 	    
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	if(AcqNumericValidator.checkId(modell.getPage())!=true){
			modell.setPage("1");
			}
			try{
				 HttpSession session = request.getSession();
		   			modell.setEmpId((String)session.getAttribute("empRole"));
				modell.setWalletEmail(AcqAuthToken.getAuthToken().getName());
				ServiceDto<List<HashMap<String,String>>> globleMap = merchantHandler.InventoryDeviceList(modell);
	    		list = globleMap.getResult();
	    		HashMap<String,String> map = list.get(0);
	    		model.addObject("totalRows", map.get("rows"));
	    		list.remove(0);
	    		if(modell.getModelName()==null||modell.getModelName()==""||modell.getModelName().equals("%41")){
	    			model.addObject("Name", "");
	    		}else{
	    			model.addObject("Name", modell.getModelName());
	    		}
	    		if(modell.getSerialNo()==null||modell.getSerialNo()==""||modell.getSerialNo().equals("%41")){
	    			model.addObject("SrNo", "");
	    		}else{
	    			model.addObject("SrNo", modell.getSerialNo());
	    		}
	    		if(modell.getTid()==null||modell.getTid()==""||modell.getTid().equals("%41")){
	    			model.addObject("Tid", "");
	    		}else{
	    			model.addObject("Tid", modell.getTid());
	    		}
	    		if(modell.getStatus()==null||modell.getStatus()==""||modell.getStatus().equals("%41")){
	    			model.addObject("Status", "");
	    		}else{
	    			model.addObject("Status", modell.getStatus());
	    		}
	    		model.addObject("page",modell.getPage());
	    		model.addObject("deviceList", list);
	    		model.addObject("empRole",modell.getEmpId());
	    		model.setViewName("InventoryDeviceList");
	    		logger.info("response returned from Inventory Device List controller");
			}catch(Exception e){
				logger.info("Error to select enventory device list controller "+e);		
			}
		 }else{
			logger.info("you are logged out");
			model.setViewName("index");
		}
		return model;
	}
	
	@RequestMapping(value = { "/inventoryAddDevice" }, method = RequestMethod.GET)
	 public ModelAndView inventoryAddDevice(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();  
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			model.setViewName("addDevice");
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("index");
	    }
		return model;
	}
	@RequestMapping(value = { "/getBankTid" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> getBankTid(@RequestParam String serialNo ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<Object> handerResponse = merchantHandler.getBankTid(serialNo);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
			logger.error("error  in controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	} 
	
	 @RequestMapping(value = { "/inventoryAddDevice" }, method = RequestMethod.POST)
	 public @ResponseBody ResponseInf<Object> inventoryAddDevice(@ModelAttribute AcqInventoryDeviceModel model,HttpServletRequest request) {
		 logger.info("request landing in add inventory Device");  
		 ControllerResponse<Object> response = new ControllerResponse<Object>();
		 try{
			 ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			 Validator validator = vFactory.getValidator();
			 Set<ConstraintViolation<AcqInventoryDeviceModel>> inputErrSet= validator.validate(model);
			 if(inputErrSet.size()>0){
				 Iterator<ConstraintViolation<AcqInventoryDeviceModel>> itr = inputErrSet.iterator();
				 while(itr.hasNext()){
					 ConstraintViolation<AcqInventoryDeviceModel> validate = (ConstraintViolation<AcqInventoryDeviceModel>)itr.next();
					 response.setStatus(100);
					 response.setMessage(validate.getMessage());
				 }    
			 }else{
				 ServiceDto<AcqInventoryDeviceModel> handerResponse = merchantHandler.inventoryAddDevice(model);
				 response.setStatus(handerResponse.getStatus());
				 response.setMessage(handerResponse.getMessage());
				 response.setResult(handerResponse.getResult());
				return response;
			 }
		 }catch(Exception e){
			 logger.error("error to add inventory Device in controller:"+e); 
			 response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			 response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		 }
		 return response;
	 }
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
}