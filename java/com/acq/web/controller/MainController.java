package com.acq.web.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acq.AcqAuthToken;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.users.dao.AcqMerchantDaoImpl;
import com.acq.users.dao.UserDaoInf;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.ResponseInf;
import com.acq.web.dto.impl.ControllerResponse;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.MainHandlerInf;
import com.acq.web.handler.MerchantHanlderInf;


@Controller
public class MainController{	
	@Autowired
	UserDaoInf userDao;
	
	@Autowired
	UserDaoInf usrDao;
	
	@Autowired
	MainHandlerInf mainHandler;
		
	@Autowired
	MerchantHanlderInf  mrchantHandler;
	final static Logger logger = Logger.getLogger(MainController.class);	
		
	@RequestMapping(value = { "/PreBoardedMerchantlist" }, method = RequestMethod.GET)
	public ModelAndView PreBoardedMerchantlist(AcqSearchModel modell,HttpServletRequest request,HttpServletResponse response){
		ModelAndView model = new ModelAndView();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			if(AcqNumericValidator.checkId(modell.getPage())!=true){
	    	  modell.setPage("1");
	    }
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setDateHeader("Expires", 0);
	   try{
		HttpSession session = request.getSession();
  		modell.setEmpId((String)session.getAttribute("empRole"));
		model.setViewName("PreBoardedmerchantList");
	    modell.setEmpId(AcqAuthToken.getAuthToken().getName());
	    modell.setWalletEmail(AcqAuthToken.getAuthToken().getName());
	    modell.setUserId((String)session.getAttribute("empRole"));
	    System.out.println("wwwwwwwwwwww::::::::::::"+modell.getUserId());
	    String modelName;
	    if(modell.getModelName()!=null&&modell.getModelName()!=""&&!modell.getModelName().equals("%41")){
	    	if(modell.getModelName().contains("%20")){
	    		modelName = modell.getModelName().replace("%20", " ");
	    		modell.setModelName(modelName);
	    	}
	    }
	    ServiceDto<List<HashMap<String,String>>> merchantList1= mainHandler.PreBoardedMerchantlist(modell); 
	    if(modell.getModelName()==null||modell.getModelName()==""||modell.getModelName().equals("%41")){
  			model.addObject("executiveName", "");
  			}else{
  			model.addObject("executiveName", modell.getModelName());
  			}
	    if(modell.getVerificationstatus()==null||modell.getVerificationstatus()==""||modell.getVerificationstatus().equals("%41")){
  			model.addObject("verificationstatus", "");
  			}else{
  			model.addObject("verificationstatus", modell.getVerificationstatus());
  			}
	    if(modell.getMerchantName()==null||modell.getMerchantName()==""||modell.getMerchantName().equals("%41")){
  			model.addObject("merchantName", "");
  			}else{
  			model.addObject("merchantName", modell.getMerchantName());
  			}
	    if(modell.getMarketingName()==null||modell.getMarketingName()==""||modell.getMarketingName().equals("%41")){
  			model.addObject("marketingName", "");
  			}else{
  			model.addObject("marketingName", modell.getMarketingName());
  			}	    
	    List<HashMap<String,String>> merchantList = merchantList1.getResult();
	       HashMap<String,String> map = merchantList.get(0);
	       model.addObject("totalRows", map.get("rows"));  
	       merchantList.remove(0);
	       model.addObject("empRole",modell.getEmpId());
	       
	    model.addObject("basicMerchantDetails", merchantList);
	   }catch(Exception e){
	    logger.info("Error to select PreBoarded merchant list "+e);  
	   }
	   model.addObject("page",modell.getPage());   
	   model.setViewName("PreBoardedmerchantList");
	     }else{
	   logger.info("you are logged out preboard merchant list");
	   model.setViewName("index");
	  }
	  return model;
	 }
	
	@RequestMapping(value = { "/PreBoardedmerchantdetails" }, method = RequestMethod.GET)
	public ModelAndView PreBoardedmerchantdetails(HttpServletRequest request) {
		String merchantId =request.getParameter("MerchantId");
		ModelAndView model = new ModelAndView();
		List<HashMap<String,String>> list = null;
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	String emp = AcqAuthToken.getAuthToken().getName();
	    	
	    	ServiceDto<Map> daoResponse = mainHandler.PreBoardedmerchantdetails(merchantId,emp);
	    	Map merchantDetails = daoResponse.getResult();
	    	ServiceDto<List<HashMap<String, String>>> global= mrchantHandler.executivesList();
			list = global.getResult();
			model.addObject("executiveList", list);
			model.addObject("kycCheck", merchantDetails.get("kycCheck"));
	    	//System.out.println("qqqqqqq::::::::::::::"+merchantDetails.get("kycCheck"));
	    	model.addObject("allMerchantDetails", merchantDetails);
	    	model.setViewName("PreBoardingMerchantDetails");
	    }else{
			logger.info("you are logged out preboard merchant details");
			model.setViewName("index");
		}
		return model;
	}		
	
	
	@RequestMapping(value = { "/{admnres}" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> getSuperAdminDetails(@RequestParam String  servervalue, @PathVariable(value = "admnres") String admnres, HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		Map<String,String> responseMap = new HashMap<String,String>();
		System.out.println("admnresadmnresadmnresadmnres:");
		try{
			if(AcqAuthToken.getAuthToken().getName().equals("admin@acquiro.com")){
				ServiceDto<HashMap<String,String>> response1  = mainHandler.getSuperAdminDetails(AcqAuthToken.getAuthToken().getName(),admnres);
				HashMap<String,String> res =  response1.getResult();
				if(res.isEmpty()){
					logger.info("you are logged out");
					response.setStatus(response1.getStatus());
					response.setMessage(response1.getMessage());
					return response;
				}
				if(admnres.equals("merchantBoarded")){
					logger.info("response for merchant boared");
					responseMap.put("todayMerchantBoarded", res.get("todayNoOfMerchant"));
					responseMap.put("monthlyMchntBoarded", res.get("monthlyNoOfMerchant"));
					responseMap.put("totalnoOfMerchant", res.get("totalNoOfMerchant"));
				}
				if(admnres.equals("todayActivities")){
					responseMap.put("todayTxnCount", res.get("todayTxnCount"));
					responseMap.put("todaySales", res.get("todaySales"));
					responseMap.put("todayMdr", res.get("todayMdr"));
					responseMap.put("todayCommission", res.get("todayCommission"));
				}
				if(admnres.equals("monthlyActivities")){
					logger.info("response for merchant boared for monthly");					
					responseMap.put("monthlyTxnCount", res.get("totalNoTxn1"));
					responseMap.put("monthlyTxnSales", res.get("totalAmount1"));
					responseMap.put("monthlyTxnMdr", res.get("totalMdr1"));
					responseMap.put("monthlyTxnCommission", res.get("acquiroShare1"));
					responseMap.put("monthlyTxnGMV", res.get("gmv"));
				}
				response.setStatus(response1.getStatus());
				response.setMessage(response1.getMessage());
				response.setResult(responseMap);
			}else{
				logger.info("you are logged out");
				response.setStatus(response.getStatus());
				response.setMessage(response.getMessage());
				return response;
			}
		}catch(Exception e){
			logger.error("error in welcome controller"+e);
		}
		return response;
		
	}
	
	
	@RequestMapping(value = { "/getDetails" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> getDetails(@RequestParam String  servervalue, HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		logger.info("request in get details controller");
		try{
			ServiceDto<Object> handerResponse = mainHandler.getDetails(servervalue);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			if(handerResponse.getResult()!=null)
				response.setResult(handerResponse.getResult());
			logger.info("response from get details controller");
			return response;
		}catch(Exception e){
			logger.error("error to call get details controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			return response;
		}
		
	}
		
	@RequestMapping(value = {"/addOrg"}, method = RequestMethod.GET)
	 public ModelAndView addOrganization(AcqBillingModel modell,HttpServletRequest request) {
	     ModelAndView model = new ModelAndView();
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	         try{
		    	 List<HashMap<String,String>> merchantList= usrDao.txnMerchantlist(modell);
		    	 model.addObject("merchantList", merchantList);	    	 
			     logger.info("response returned from Add Org controller");  
		     }catch(Exception e){
		        logger.error("Error from Add Org controller");
		     }
		 }else{
			  logger.info("you are logged out");
			  model.setViewName("login");
		 }
	     return model;
	}
	
	@RequestMapping(value = {"/addDeviceDetail"}, method = RequestMethod.GET)
	 public ModelAndView addDeviceDetail(AcqBillingModel modell,HttpServletRequest request) {
	     ModelAndView model = new ModelAndView();
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){		    
	     try{
	    	 List<HashMap<String,String>> merchantList= usrDao.txnMerchantlist(modell);
	    	 model.addObject("merchantList", merchantList);	 
	    	 modell.setMerchantId(modell.getMerchantId());
	    	if(modell.getMerchantId()!=null && modell.getMerchantId()+""!="" && modell.getMerchantId()>0){
	    	 List<HashMap<String, String>> orgList= usrDao.txnOrgList(modell);
	    	 model.addObject("orgList", orgList);	
	    	}
		     logger.info("response returned from Add Device controller");  
	        }catch(Exception e){
	        	logger.error("Error from Add Device controller");
	        }}
		    else
			{
				logger.info("you are logged out");
				model.setViewName("login");
			}
	    return model;
	    }
	
	@RequestMapping(value = { "/settingUpdate" }, method = RequestMethod.GET)
	public ModelAndView settingUpdateGet(HttpServletRequest request) {
		System.out.println("setting get method is called.");
		ModelAndView model = new ModelAndView();   
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	 model.setViewName("settingHome");
	    }else{
			logger.info("you are logged out setting home");
			model.setViewName("index");
		}
		return model;
	}
	
	@RequestMapping(value = {"/settingUpdate"}, method = RequestMethod.POST)
	public ModelAndView settingUpdate(AcqSettingModel modell,HttpServletRequest request) {
    	ModelAndView model = new ModelAndView();
		    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
			Validator validator = vFactory.getValidator();
			Set<ConstraintViolation<AcqSettingModel>> inputErrSet= validator.validate(modell);
			if(inputErrSet.size()>0){
				Iterator<ConstraintViolation<AcqSettingModel>> itr = inputErrSet.iterator();
				while(itr.hasNext()){
					ConstraintViolation<AcqSettingModel> validate = (ConstraintViolation<AcqSettingModel>)itr.next();
					model.addObject("message",validate.getMessage());
				}
				try{
					ServiceDto<List<String>> daoResponse  = mainHandler.getSettingList();
		    		List<String> response = daoResponse.getResult();
		    		model.addObject("serviceTax", response.get(1));
		    		model.addObject("mdrDebit1", response.get(2));
		    		model.addObject("mdrDebit2", response.get(3));
		    		model.addObject("mdrCr", response.get(4));
		    		model.addObject("mdrCrpn", response.get(5));
		    		model.addObject("mdrAmex", response.get(6));
		    		model.addObject("other", response.get(7));
		    		model.addObject("mdrCashAtPos", response.get(13));
		    		model.addObject("cardPayoutAc", response.get(15));
		    		model.addObject("payoutEmail", response.get(17));
		    		model.addObject("cashAtPosServiceTax", response.get(18));
		    		model.addObject("maintenanceMode", response.get(19));
		    		model.addObject("maintenanceReason", response.get(20));
		    		model.addObject("appVersion", response.get(21));
		    		model.addObject("mdrDebit0", response.get(22));
		    		model.addObject("neftFees", response.get(23));
		    		model.addObject("systemUtilityAmount", response.get(24));
		    		model.addObject("systemUtilityFees", response.get(25));
					logger.info("list successfully puted");
		    	}catch(Exception e){
		    		logger.error("Error from setting controller"+e);
		    	}
		    	model.setViewName("settingHome");
				return model;
			}else{
				try{
					ServiceDto<List<String>> daoResponse  = mainHandler.getSettingUpdateList(modell);
			    		List<String> response = daoResponse.getResult();
			    		model.addObject("serviceTax", response.get(1));
			    		model.addObject("mdrDebit1", response.get(2));
			    		model.addObject("mdrDebit2", response.get(3));
			    		model.addObject("mdrCr", response.get(4));
			    		model.addObject("mdrCrpn", response.get(5));
			    		model.addObject("mdrAmex", response.get(6));
			    		model.addObject("other", response.get(7));
			    		model.addObject("mdrCashAtPos", response.get(13));
			    		model.addObject("cardPayoutAc", response.get(15));
			    		model.addObject("payoutEmail", response.get(17));
			    		model.addObject("cashAtPosServiceTax", response.get(18));
			    		model.addObject("maintenanceMode", response.get(19));
			    		model.addObject("maintenanceReason", response.get(20));
			    		model.addObject("appVersion", response.get(21));
			    		model.addObject("mdrDebit0", response.get(22));
			    		model.addObject("neftFees", response.get(23));
			    		model.addObject("systemUtilityAmount", response.get(24));
			    		model.addObject("systemUtilityFees", response.get(25));
			    		model.addObject("message","Settings successfully updated");
			    		logger.info("list successfully puted");
					
		    	}catch(Exception e){
		    		logger.error("Error from setting controller "+e);
		    	}
		    	model.setViewName("settingHome");
		    	return model;
			}
		}else{
			logger.info("you are logged out setting update");
			model.setViewName("index");
			return model;
		}
	}
	
	@RequestMapping(value = {"/settingHome"}, method = RequestMethod.GET)
	public ModelAndView settingHome(HttpServletRequest request, HttpServletResponse res) {
    	ModelAndView model = new ModelAndView();
    	res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    try{
    		ServiceDto<List<String>> daoResponse  = mainHandler.getSettingList();
    		List<String> response = daoResponse.getResult();
    		model.addObject("serviceTax", response.get(1));
    		model.addObject("mdrDebit1", response.get(2));
    		model.addObject("mdrDebit2", response.get(3));
    		model.addObject("mdrCr", response.get(4));
    		model.addObject("mdrCrpn", response.get(5));
    		model.addObject("mdrAmex", response.get(6));
    		model.addObject("other", response.get(7));
    		model.addObject("mdrCashAtPos", response.get(13));
    		model.addObject("cardPayoutAc", response.get(15));
    		model.addObject("payoutEmail", response.get(17));
    		model.addObject("cashAtPosServiceTax", response.get(18));
    		model.addObject("maintenanceMode", response.get(19));
    		model.addObject("maintenanceReason", response.get(20));
    		model.addObject("appVersion", response.get(21));
    		model.addObject("mdrDebit0", response.get(22));
    		model.addObject("neftFees", response.get(23));
    		model.addObject("systemUtilityAmount", response.get(24));
    		model.addObject("systemUtilityFees", response.get(25));
    		logger.info("list successfully puted");
    	}catch(Exception e){
    		logger.error("Error from setting controller");
    	}
    	model.setViewName("settingHome");
	    }else{
			logger.info("you are logged out setting update home");
			model.setViewName("index");
		}
		return model;
	}
	
	
	@RequestMapping(value = { "/logout" }, method = RequestMethod.GET)
	public ModelAndView logoutErpUser(HttpServletRequest request){
		SecurityContextHolder.getContext().getAuthentication().setAuthenticated(false); 
		SecurityContextHolder.clearContext();
		HttpSession AcqSession = request.getSession();
		AcqSession.setAttribute("userName", null);
		AcqSession.setAttribute("empRole", null);
		AcqSession.invalidate();
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}
		
	@RequestMapping(value = { "/create" }, method = RequestMethod.GET)
	public ModelAndView createMerchant() {
		ModelAndView model = new ModelAndView();
		model.setViewName("createMerchant");
		return model;
	}
		
	@RequestMapping(value = { "/updatemerchant" }, method = RequestMethod.GET)
	public ModelAndView updateMerchantGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}	
	
	@RequestMapping(value = { "/deleteorg" }, method = RequestMethod.GET)
	public ModelAndView orgDeleteGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}

	@RequestMapping(value = { "/devicedelete" }, method = RequestMethod.GET)
	public ModelAndView deviceDeleteGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}
		
	@RequestMapping(value = { "/merchantdetails" }, method = RequestMethod.GET)
	public ModelAndView showMerchantDetails(HttpServletRequest request) {
		String merchantId =request.getParameter("MerchantId");
		ModelAndView model = new ModelAndView();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    String emp = AcqAuthToken.getAuthToken().getName();
		AcqMerchantDaoImpl merchantHandler = new AcqMerchantDaoImpl();	
		TreeMap<String,Object> merchantDetails= merchantHandler.merchantDetails(merchantId,emp);
		model.addObject("allMerchantDetails", merchantDetails);
		model.setViewName("merchantDetails");
	    }
	    else
		{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value = { "/merchantDelete" }, method = RequestMethod.GET)
	public ModelAndView merchantDeleteGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}

	@RequestMapping(value = { "/list" }, method = RequestMethod.GET)
	 public ModelAndView merchantList(AcqSearchModel modell,HttpServletRequest request, HttpServletResponse res){
	  ModelAndView model = new ModelAndView();
	  res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0);
	   if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	      //System.out.println("modell.getPage():::"+modell.getPage());
		   HttpSession session = request.getSession();
		   System.out.println("model.getCloneCheck() main controler::"+modell.getCloneCheck());
		   modell.setEmpId((String)session.getAttribute("empRole"));
		   if(AcqNumericValidator.checkId(modell.getPage())!=true){
	    	  modell.setPage("1");
	      }else
	    	  modell.setPage(modell.getPage());		  
	      try{
	    	  model.setViewName("merchantList");
	    	  modell.setWalletEmail(AcqAuthToken.getAuthToken().getName());
	    	  String modelName=null;
	    	  if(modell.getModelName()!=null&&modell.getModelName()!=""&&!modell.getModelName().equals("%41")){
	    		  if(modell.getModelName().contains("%20")){
	    			  modelName = modell.getModelName().replace("%20", " ");
	    			  modell.setModelName(modelName);
	    		  }
	    	  }
	    	  String city=null;
	    	  if(modell.getCity()!=null&&modell.getCity()!=""&&!modell.getCity().equals("%41")){
	    		  if(modell.getCity().contains("%20")){
	    			  city = modell.getCity().replace("%20", " ");
	    			  modell.setCity(city);
	    		  }
	    	  }
	    	  String state=null;
	    	  if(modell.getState()!=null&&modell.getState()!=""&&!modell.getState().equals("%41")){
	    		  if(modell.getState().contains("%20")){
	    			  state = modell.getState().replace("%20", " ");
	    			  modell.setState(state);
	    		  }
	    	  }
	    	  if(modell.getVerificationstatus()!=null&&modell.getVerificationstatus()!=""&&!modell.getVerificationstatus().equals("%41")){
	    		  if(modell.getVerificationstatus().contains("%20")){
	    			  String status = modell.getVerificationstatus().replace("%20", " ");
	    			  modell.setVerificationstatus(status);
	    		  }
	    	  }
	    	  ServiceDto<List<HashMap<String,String>>> merchantList1= mainHandler.getMerchantList(modell); 
	    	  List<HashMap<String,String>> merchantList = merchantList1.getResult();
	    	  HashMap<String,String> map = merchantList.get(0);
	    	  model.addObject("totalRows", map.get("rows"));       
	    	  merchantList.remove(0);
	    	
	    	  if(modell.getApplicationNo()==null||modell.getApplicationNo()==""||modell.getApplicationNo().equals("%41")){
	    		  model.addObject("applicationno", "");
 			  }else{
 				  model.addObject("applicationno", modell.getApplicationNo());
 			  }if(modell.getMerchantName()==null||modell.getMerchantName()==""||modell.getMerchantName().equals("%41")){
	    		  model.addObject("merchantname", "");
 			  }else{
 				  model.addObject("merchantname", modell.getMerchantName());
 			  }if(modell.getMarketingName()==null||modell.getMarketingName()==""||modell.getMarketingName().equals("%41")){
	    		  model.addObject("marketingname", "");
 			  }else{
 				  model.addObject("marketingname", modell.getMarketingName());
 			  }if(modell.getCustPhone()==null||modell.getCustPhone()==""||modell.getCustPhone().equals("%41")){
	    		  model.addObject("custPhone", "");
 			  }else{
 				  model.addObject("custPhone", modell.getCustPhone());
 			  }if(modell.getVerificationstatus()==null||modell.getVerificationstatus()==""||modell.getVerificationstatus().equals("%41")){
	    		  model.addObject("verificationstatus", "");
 			  }else{
 				  model.addObject("verificationstatus", modell.getVerificationstatus());
 			  }
	    	  if(modell.getCity()==null||modell.getCity()==""||modell.getCity().equals("%41")){
	    		  model.addObject("city", "");
 			  }else{
 				  model.addObject("city", modell.getCity());
 			  }
	    	  if(modell.getState()==null||modell.getState()==""||modell.getState().equals("%41")){
	    		  model.addObject("state", "");
	   		  }else{
	   			  model.addObject("state", modell.getState());
	   		  }
	    	  if(modell.getModelName()==null||modell.getModelName()==""||modell.getModelName().equals("%41")){
	   				model.addObject("executiveName", "");
	   		  }else{
	   				model.addObject("executiveName", modell.getModelName());
	   		  }	    	  
	    	  if(modell.getDateTime()==null||modell.getDateTime()==""||modell.getDateTime().equals("%41")){
	   				model.addObject("dateCreated", "");
	   		  }else{
	   			   model.addObject("dateCreated", modell.getDateTime());
	   		  }if(modell.getFromDateTime()==null||modell.getFromDateTime()==""||modell.getFromDateTime().equals("%41")){
	   				model.addObject("fromDateTime", "");
	   		  }else{
	   			   model.addObject("fromDateTime", modell.getFromDateTime());
	   		  }if(modell.getToDateTime()==null||modell.getToDateTime()==""||modell.getToDateTime().equals("%41")){
	   				model.addObject("toDateTime", "");
	   		  }else{
	   			   model.addObject("toDateTime", modell.getToDateTime());
	   		  }
		   		if(modell.getBankMid()==null||modell.getBankMid()==""||modell.getBankMid().equals("%41")){
	  				model.addObject("bankMid", "");
		   		}else{
	  			   model.addObject("bankMid", modell.getBankMid());
		   		}
	   		  model.addObject("basicMerchantDetails", merchantList);	    	
	      }catch(Exception e){
	    	  logger.info("Error to select merchant list "+e);  
	      }
	      model.addObject("page",modell.getPage());  
	      model.addObject("empRole",modell.getEmpId());
	      System.out.println("modell.getPage()modell.getPage()modell.getPage():"+modell.getPage());
	      model.setViewName("merchantList");
	   }else{
		   logger.info("you are logged out merchant list");
		   model.setViewName("index");
	   }
	   return model;
	}
	
	@RequestMapping(value = { "/updateOrg" }, method = RequestMethod.GET)
	public ModelAndView updateOrgDetailsGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}
	
	@RequestMapping(value = { "/updatedevicedetails" }, method = RequestMethod.GET)
	public ModelAndView updateDeviceDetailsGet(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public ModelAndView defaultPage(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		SecurityContextHolder.getContext().getAuthentication().setAuthenticated(false); 
		SecurityContextHolder.clearContext();
		HttpSession AcqSession = request.getSession();
		AcqSession.setAttribute("userName", null);
		AcqSession.setAttribute("empRole", null);
		AcqSession.invalidate();
		model.setViewName("login");
		return model;
	}
	
	@RequestMapping(value = {"/welcome**" }, method = RequestMethod.GET)
	public ModelAndView homePage(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		String serveletRequest = request.getRequestURI();
		logger.info("you are logged in::::::;");
		
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	logger.info("you are logged in");
			try{
				if(AcqAuthToken.getAuthToken().getName().equals("admin@acquiropayments.com")){
					ServiceDto<List<String>> response1  = mainHandler.getHomePageReport(AcqAuthToken.getAuthToken().getName());
					List<String> res = response1.getResult();
					if(res.isEmpty()){
						logger.info("you are logged out");
						model.setViewName("login");
						return model;
					}
					model.addObject("todayTxnCount", "0");
					model.addObject("todaySales", "0");
					model.addObject("todayMdr", "0");
					model.addObject("todayCommission", "0");
					model.addObject("todayMerchantBoarded", "0");
					model.addObject("monthlyTxnCount", "0");
					model.addObject("monthlyTxnSales", "0");
					model.addObject("monthlyTxnMdr", "0");
					model.addObject("monthlyTxnCommission", "0");
					model.addObject("monthlyTxnGMV", "0");
					model.addObject("monthlyMchntBoarded", "0");
					model.addObject("totalnoOfMerchant", "0");			
					HttpSession session = request.getSession();
					session.setAttribute("userName", res.get(0));
					session.setAttribute("empRole", res.get(1));
					model.setViewName("home");
				}else{
					ServiceDto<List<String>> response1  = mainHandler.getHomePageReport(AcqAuthToken.getAuthToken().getName());
					List<String> res = response1.getResult();
					if(res.isEmpty()){
						logger.info("you are logged out");
						model.setViewName("login");
						return model;
					}
					model.addObject("todayMerchantBoarded", "0");
					model.addObject("monthlyMchntBoarded", "0");
					model.addObject("totalnoOfMerchant", "0");			
					HttpSession session = request.getSession();
					session.setAttribute("userName", res.get(0));
					session.setAttribute("empRole", res.get(1));
					model.setViewName("nhome");
				}				
			}catch(Exception e){
				logger.error("error in welcome controller"+e);
			}
	    }else{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		logger.info("response putted in welcome controller");
		return model;
	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {
		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security + Hibernate Example");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request) {
		logger.info("erp home page");
		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", getErrorMessage(request, "SPRING_SECURITY_LAST_EXCEPTION"));
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");
		return model;
	}

	private String getErrorMessage(HttpServletRequest request, String key) {

		Exception exception = (Exception) request.getSession().getAttribute(key);

		String error = "";
		if (exception instanceof BadCredentialsException) {
			error = "Invalid username and password!";
		} else if (exception instanceof LockedException) {
			error = exception.getMessage();
		} else {
			error = "Invalid username and password!";
		}

		return error;
	}

	@RequestMapping(value = "/404", method = RequestMethod.POST)
	public ModelAndView notFound() {
		logger.info("404 is found");
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {
		logger.info("403 is found");
		ModelAndView model = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			model.addObject("username", userDetail.getUsername());
		}
		model.setViewName("403");
		return model;
	}

}