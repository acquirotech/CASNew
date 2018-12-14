package com.acq.web.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.acq.AcqAuthToken;
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dto.ResponseInf;
import com.acq.web.dto.impl.ControllerResponse;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.ListHandlerInf;

@Controller
public class ListController {
	
	@Autowired
	ListHandlerInf walletHandler;
	
	final static Logger logger = Logger.getLogger(MainController.class);	

	
	@RequestMapping(value = { "/rechargeList" }, method = RequestMethod.GET)
	 public ModelAndView rechargeList(AcqSearchModel modell,HttpServletRequest request) {
	  logger.info("request for Recharge List");
	  List<HashMap<String,String>> list = null; 
	  ModelAndView model = new ModelAndView();
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	      try{
	       if(AcqNumericValidator.checkId(modell.getPage())!=true){
	     modell.setPage("1");
	    }
	       HttpSession session = request.getSession();
 			modell.setEmpId((String)session.getAttribute("empRole"));
	       System.out.println("login id : "+modell.getUserPhone());
	      // ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.walletList(modell);
	       ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.rechargeList(modell);
	       list = globleMap.getResult();
	       HashMap<String,String> map = list.get(0);
	       model.addObject("totalRows", map.get("rows"));
	       list.remove(0);
	       model.addObject("page",modell.getPage());
	       if(modell.getTxnType()==null|| modell.getTxnType()==""|| modell.getTxnType().equals("%41")){
	           model.addObject("txnType","");
	         }else{
	           model.addObject("txnType", modell.getTxnType());
	         }if(modell.getUserPhone()==null|| modell.getUserPhone()==""|| modell.getUserPhone().equals("%41")){
	          model.addObject("loginId", "");
	         }else{
	          model.addObject("loginId", modell.getUserPhone());
	         }if(modell.getWalletStatus()==null|| modell.getWalletStatus()==""|| modell.getWalletStatus().equals("%41")){
	          model.addObject("status", "");
	         }else{
	          model.addObject("status", modell.getWalletStatus());
	         }if(modell.getWalletEmail()==null|| modell.getWalletEmail()==""|| modell.getWalletEmail().equals("%41")){
	          model.addObject("walletEmail", "");
	         }else{
	          model.addObject("walletEmail", modell.getWalletEmail());
	         }if(modell.getWalletTxnId()==null|| modell.getWalletTxnId()==""|| modell.getWalletTxnId().equals("%41")){
	          model.addObject("txnId", "");
	         }else{
	          model.addObject("txnId", modell.getWalletTxnId());
	         }if(modell.getCustPhone()==null|| modell.getCustPhone()==""|| modell.getCustPhone().equals("%41")){
	           model.addObject("custPhone","");
	         }else{
	           model.addObject("custPhone", modell.getCustPhone());
	         }if(modell.getFromDateTime()==null|| modell.getFromDateTime()==""|| modell.getFromDateTime().equals("%41")){
	          model.addObject("fromDate", "");
	         }else{
	          model.addObject("fromDate", modell.getFromDateTime());
	         }if(modell.getToDateTime()==null|| modell.getToDateTime()==""|| modell.getToDateTime().equals("%41")){
	           model.addObject("toDate", "");
	         }else{
	          model.addObject("toDate", modell.getToDateTime());
	         }
	       model.addObject("empRole",modell.getEmpId());
	       model.addObject("riskManagementList", list);
	       model.setViewName("RechargeList");
	       logger.info("response returned from recharge List controller");
	      }catch(Exception e){
	       logger.error("error in recharge List controller "+e);
	      }
	     }else{
	      logger.info("you are logged out");
	      model.setViewName("login");
	     }
	  return model;
	 }
	
	 
	 @RequestMapping(value = { "/transactionList" }, method = RequestMethod.GET)
	 public ModelAndView transactionList(AcqSearchModel modell,HttpServletRequest request) {
	  logger.info("request for dmt transaction List");
	  List<HashMap<String,String>> list = null; 
	  ModelAndView model = new ModelAndView();
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	      try{
	       if(AcqNumericValidator.checkId(modell.getPage())!=true){
	     modell.setPage("1");
	    }
	       String merchantName;
  	    if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
  	    	if(modell.getMerchantName().contains("%20")){
  	    		merchantName = modell.getMerchantName().replace("%20", " ");
  	    		modell.setMerchantName(merchantName);
  	    	}else{
  	    		merchantName = modell.getMerchantName();
  	    		modell.setMerchantName(merchantName);
  	    	}
  	    }
	       HttpSession session = request.getSession();
 			modell.setEmpId((String)session.getAttribute("empRole"));
	       System.out.println("login id : "+modell.getUserPhone());
	      // ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.walletList(modell);
	       ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.transactionList(modell);
	       list = globleMap.getResult();
	       HashMap<String,String> map = list.get(0);
	       model.addObject("totalRows", map.get("rows"));
	       list.remove(0);
	       model.addObject("page",modell.getPage());
	       if(modell.getTxnType()==null|| modell.getTxnType()==""|| modell.getTxnType().equals("%41")){
	           model.addObject("txnType","");
	         }else{
	           model.addObject("txnType", modell.getTxnType());
	         }if(modell.getUserPhone()==null|| modell.getUserPhone()==""|| modell.getUserPhone().equals("%41")){
	          model.addObject("loginId", "");
	         }else{
	          model.addObject("loginId", modell.getUserPhone());
	         }if(modell.getWalletStatus()==null|| modell.getWalletStatus()==""|| modell.getWalletStatus().equals("%41")){
	          model.addObject("status", "");
	         }else{
	          model.addObject("status", modell.getWalletStatus());
	         }if(modell.getMerchantName()==null|| modell.getMerchantName()==""|| modell.getMerchantName().equals("%41")){
	          model.addObject("merchantName", "");
	         }else{
	          model.addObject("merchantName", modell.getMerchantName());
	         }if(modell.getAccount()==null|| modell.getAccount()==""|| modell.getAccount().equals("%41")){
	          model.addObject("account", "");
	         }else{
	          model.addObject("account", modell.getAccount());
	         }if(modell.getAmount()==null|| modell.getAmount()==""|| modell.getAmount().equals("%41")){
	           model.addObject("amount","");
	         }else{
	           model.addObject("amount", modell.getCustPhone());
	         }if(modell.getFromDateTime()==null|| modell.getFromDateTime()==""|| modell.getFromDateTime().equals("%41")){
	          model.addObject("fromDate", "");
	         }else{
	          model.addObject("fromDate", modell.getFromDateTime());
	         }if(modell.getToDateTime()==null|| modell.getToDateTime()==""|| modell.getToDateTime().equals("%41")){
	           model.addObject("toDate", "");
	         }else{
	          model.addObject("toDate", modell.getToDateTime());
	         }
	       model.addObject("empRole",modell.getEmpId());
	       model.addObject("txnList", list);
	       model.setViewName("transactionList");
	       logger.info("response returned from dmt transaction List controller");
	      }catch(Exception e){
	       logger.error("error in dmt transaction List controller "+e);
	      }
	     }else{
	      logger.info("you are logged out");
	      model.setViewName("login");
	     }
	  return model;
	 }
	 
	
	
@RequestMapping(value = { "/downloadRiskDetails" }, method = RequestMethod.GET)
	public ModelAndView downloadBillDetails(@RequestParam (required=true)String fromDate,@RequestParam (required=true)String toDate,HttpServletRequest request) {
		List<HashMap<String,String>> list = null;
		logger.info("request for donwload Risk Details home");
		ModelAndView model = new ModelAndView();
		try{
		     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
				ServiceDto<List<HashMap<String, String>>> global= walletHandler.downloadRiskDetails(fromDate,toDate);
				list = global.getResult();
				model.addObject("riskDetailsList", list);
				model.setViewName("downloadRiskDetails");
				logger.info("response returned from download Risk Details controller");
		    }else{
				logger.info("you are logged out download Risk details");
				model.setViewName("index");
			}
		}catch(Exception e){
			logger.error("error to call dao method");
		}
		return model;
	}	
	@RequestMapping(value = { "/updateMdr" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updateMdr(@RequestParam (required = true)String txnId ,@RequestParam (required = false)String AcqMdr ,@RequestParam (required = false)String bankMdr ,HttpServletRequest request) {
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<String> handerResponse = walletHandler.updateMdr(txnId,AcqMdr,bankMdr);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
			logger.info("Mdr Updated Successfully");
		}catch(Exception e){
			logger.error("error to update bank mdr in controller:"+e);	
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
		
	@RequestMapping(value = { "/addRisk" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> addRisk(@RequestParam String txnId ,@RequestParam String txnType ,HttpServletRequest request) {
		logger.info("request landing in add risk status");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<String> handerResponse = walletHandler.addRisk(txnId,txnType);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
		}catch(Exception e){
			logger.error("error to call add risk status controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	@RequestMapping(value = { "/updateRiskStatus" }, method = RequestMethod.POST)
	public @ResponseBody ResponseInf<Object> updateRiskStatus(@RequestParam String riskId ,@RequestParam String txnType ,HttpServletRequest request) {
		logger.info("request landing in update risk status");
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		try{
			ServiceDto<Object> handerResponse = walletHandler.updateRiskStatus(riskId,txnType);
			response.setStatus(handerResponse.getStatus());
			response.setMessage(handerResponse.getMessage());
			response.setResult(handerResponse.getResult());
			System.out.println("result"+handerResponse.getResult());
			System.out.println("message"+handerResponse.getMessage());
		}catch(Exception e){
			logger.error("error to call update risk status controller:"+e); 
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
		}
		return response;
	}
	
	

	 @RequestMapping(value = { "/riskManagementList" }, method = RequestMethod.GET)
	 public ModelAndView riskManagementList(AcqSearchModel modell,HttpServletRequest request) {
	  logger.info("request for Risk Management List");
	  List<HashMap<String,String>> list = null; 
	  ModelAndView model = new ModelAndView();
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	      try{
	       if(AcqNumericValidator.checkId(modell.getPage())!=true){
	     modell.setPage("1");
	    }
	       HttpSession session = request.getSession();
  			modell.setEmpId((String)session.getAttribute("empRole"));
	       System.out.println("login id : "+modell.getUserPhone());
	       ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.riskManagementList(modell);
	       list = globleMap.getResult();
	       HashMap<String,String> map = list.get(0);
	       model.addObject("totalRows", map.get("rows"));
	       list.remove(0);
	       model.addObject("page",modell.getPage());
	       if(modell.getTxnType()==null|| modell.getTxnType()==""|| modell.getTxnType().equals("%41")){
	           model.addObject("txnType","");
	         }else{
	           model.addObject("txnType", modell.getTxnType());
	         }if(modell.getUserPhone()==null|| modell.getUserPhone()==""|| modell.getUserPhone().equals("%41")){
	          model.addObject("loginId", "");
	         }else{
	          model.addObject("loginId", modell.getUserPhone());
	         }if(modell.getWalletStatus()==null|| modell.getWalletStatus()==""|| modell.getWalletStatus().equals("%41")){
	          model.addObject("status", "");
	         }else{
	          model.addObject("status", modell.getWalletStatus());
	         }if(modell.getWalletEmail()==null|| modell.getWalletEmail()==""|| modell.getWalletEmail().equals("%41")){
	          model.addObject("walletEmail", "");
	         }else{
	          model.addObject("walletEmail", modell.getWalletEmail());
	         }if(modell.getWalletTxnId()==null|| modell.getWalletTxnId()==""|| modell.getWalletTxnId().equals("%41")){
	          model.addObject("txnId", "");
	         }else{
	          model.addObject("txnId", modell.getWalletTxnId());
	         }if(modell.getCustPhone()==null|| modell.getCustPhone()==""|| modell.getCustPhone().equals("%41")){
	           model.addObject("custPhone","");
	         }else{
	           model.addObject("custPhone", modell.getCustPhone());
	         }if(modell.getFromDateTime()==null|| modell.getFromDateTime()==""|| modell.getFromDateTime().equals("%41")){
	          model.addObject("fromDate", "");
	         }else{
	          model.addObject("fromDate", modell.getFromDateTime());
	         }if(modell.getToDateTime()==null|| modell.getToDateTime()==""|| modell.getToDateTime().equals("%41")){
	           model.addObject("toDate", "");
	         }else{
	          model.addObject("toDate", modell.getToDateTime());
	         }
	       model.addObject("empRole",modell.getEmpId());
	       model.addObject("riskManagementList", list);
	       model.setViewName("riskManagementList");
	       logger.info("response returned from Risk Management List controller");
	      }catch(Exception e){
	       logger.error("error in Risk Management List controller "+e);
	      }
	     }else{
	      logger.info("you are logged out");
	      model.setViewName("login");
	     }
	  return model;
	 }
	
	 
	
	
	@RequestMapping(value = { "/walletList" }, method = RequestMethod.GET)
	public ModelAndView walletList(AcqSearchModel modell,HttpServletRequest request) {
		logger.info("request for Wallet List");
		List<HashMap<String,String>> list = null; 
		ModelAndView model = new ModelAndView();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		if(AcqNumericValidator.checkId(modell.getPage())!=true){
					modell.setPage("1");
				}
	    		String merchantName;
	    	    String orgName;
	    	    if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
	    	    	if(modell.getMerchantName().contains("%20")){
	    	    		merchantName = modell.getMerchantName().replace("%20", " ");
	    	    		modell.setMerchantName(merchantName);
	    	    	}else{
	    	    		merchantName = modell.getMerchantName();
	    	    		modell.setMerchantName(merchantName);
	    	    	}
	    	    }if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&!modell.getOrgName().equals("%41")){
	    	    	if(modell.getOrgName().contains("%20")){
	    	    		orgName = modell.getOrgName().replace("%20", " ");
	    	    		modell.setOrgName(orgName);
	    	    	}else{
	    	    		orgName = modell.getOrgName();
	    	    		modell.setOrgName(orgName);
	    	    	}
	    	    }
	    	    HttpSession session = request.getSession();
	   			modell.setEmpId((String)session.getAttribute("empRole"));
	    		ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.walletList(modell);
	    		list = globleMap.getResult();
	    		HashMap<String,String> map = list.get(0);
	    		model.addObject("totalRows", map.get("rows"));
	    		list.remove(0);
	    		if(modell.getUserPhone()==null||modell.getUserPhone()==""||modell.getUserPhone().equals("%41")){
	    			model.addObject("loginId", "");
	    		}else{
	    			model.addObject("loginId", modell.getUserPhone());
	    		}if(modell.getMerchantName()==null||modell.getMerchantName()==""||modell.getMerchantName().equals("%41")){
	    			model.addObject("merchantName", "");
	    		}else{
	    			model.addObject("merchantName", modell.getMerchantName());
	    		}if(modell.getOrgName()==null||modell.getOrgName()==""||modell.getOrgName().equals("%41")){
	    			model.addObject("orgName", "");
	    		}else{
	    			model.addObject("orgName", modell.getOrgName());
	    		}if(modell.getWalletStatus()==null||modell.getWalletStatus()==""||modell.getWalletStatus().equals("%41")){
	    			model.addObject("status", "");
	    		}else{
	    			model.addObject("status", modell.getWalletStatus());
	    		}if(modell.getWalletEmail()==null||modell.getWalletEmail()==""||modell.getWalletEmail().equals("%41")){
	    			model.addObject("walletEmail", "");
	    		}else{
	    			model.addObject("walletEmail", modell.getWalletEmail());
	    		}if(modell.getWalletTxnId()==null||modell.getWalletTxnId()==""||modell.getWalletTxnId().equals("%41")){
	    			model.addObject("txnId", "");
	    		}else{
	    			model.addObject("txnId", modell.getWalletTxnId());
	    		}if(modell.getCustPhone()==null||modell.getCustPhone()==""||modell.getCustPhone().equals("%41")){
	    			 model.addObject("custPhone","");
	    		}else{
	    			 model.addObject("custPhone", modell.getCustPhone());
	    		}if(modell.getFromDateTime()==null||modell.getFromDateTime()==""||modell.getFromDateTime().equals("%41")){
	    			model.addObject("fromDate", "");
	    		}else{
	    			model.addObject("fromDate", modell.getFromDateTime());
	    		}if(modell.getToDateTime()==null||modell.getToDateTime()==""||modell.getToDateTime().equals("%41")){
	    			 model.addObject("toDate", "");
	    		}else{
	    			model.addObject("toDate", modell.getToDateTime());
	    		}if(modell.getTxnType()==null|| modell.getTxnType()==""|| modell.getTxnType().equals("%41")){
	    	        model.addObject("txnType", "");
	    	    }else{
	    	        model.addObject("txnType", modell.getTxnType());
	    	    }if(modell.getAmount()==null||modell.getAmount()==""||modell.getAmount().equals("%41")){
	    			model.addObject("amount", "");
	    		}else{
	    			model.addObject("amount", modell.getAmount());
	    		}if(modell.getAccount()==null||modell.getAccount()==""||modell.getAccount().equals("%41")){
	    			model.addObject("account", "");
	    		}else{
	    			model.addObject("account", modell.getAccount());
	    		}if(modell.getAuthcode()==null||modell.getAuthcode()==""||modell.getAuthcode().equals("%41")){
	    			model.addObject("authcode", "");
	    		}else{
	    			model.addObject("authcode", modell.getAuthcode());
	    		}
	    		model.addObject("page",modell.getPage());
	    		model.addObject("walletList", list);
	    		model.addObject("empRole",modell.getEmpId());
	    		model.setViewName("walletList");
	    		logger.info("response returned from wallet List controller");
	    	}catch(Exception e){
	    		logger.error("error in Wallet List controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
	
	@RequestMapping(value = { "/wholeTxnList" }, method = RequestMethod.GET)
	public ModelAndView wholeTxnList(AcqSearchModel modell,HttpServletRequest request) {
		logger.info("request for Wallet List");
		List<HashMap<String,String>> list = null; 
		ModelAndView model = new ModelAndView();
		//SecurityContext securityContext = SecurityContextHolder.getContext();
	    //Authentication authentication = securityContext.getAuthentication();	    
	    if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
	    	try{
	    		if(AcqNumericValidator.checkId(modell.getPage())!=true){
					modell.setPage("1");
				}
	    		String merchantName;
	    	       String orgName;
	    	       HttpSession session = request.getSession();
	   			modell.setEmpId((String)session.getAttribute("empRole"));
	    	if(modell.getMerchantName()!=null&&modell.getMerchantName()!=""&&!modell.getMerchantName().equals("%41")){
	    	       if(modell.getMerchantName().contains("%20")){
	    	     merchantName = modell.getMerchantName().replace("%20", " ");
	    	     modell.setMerchantName(merchantName);
	    	    }else{
	    	     merchantName = modell.getMerchantName();
	    	     modell.setMerchantName(merchantName);
	    	    }
	    	       }if(modell.getOrgName()!=null&&modell.getOrgName()!=""&&!modell.getOrgName().equals("%41")){
	    	        if(modell.getOrgName().contains("%20")){
	    	         orgName = modell.getOrgName().replace("%20", " ");
	    	      modell.setOrgName(orgName);
	    	     }else{
	    	      orgName = modell.getOrgName();
	    	      modell.setOrgName(orgName);
	    	     }
	    	        }
	    		ServiceDto<List<HashMap<String,String>>> globleMap = walletHandler.wholeTxnList(modell);
	    		list = globleMap.getResult();
	    		HashMap<String,String> map = list.get(0);
	    		model.addObject("totalRows", map.get("rows"));
	    		list.remove(0);
	    		if(modell.getAmount()==null||modell.getAmount()==""||modell.getAmount().equals("%41")){
	    			model.addObject("amount", "");
	    		}else{
	    			model.addObject("amount", modell.getAmount());
	    		}
	    		if(modell.getAccount()==null||modell.getAccount()==""||modell.getAccount().equals("%41")){
	    			model.addObject("account", "");
	    		}else{
	    			model.addObject("account", modell.getAccount());
	    		}
	    		
	    		if(modell.getUserPhone()==null||modell.getUserPhone()==""||modell.getUserPhone().equals("%41")){
	    			model.addObject("loginId", "");
	    		}else{
	    			model.addObject("loginId", modell.getUserPhone());
	    		}if(modell.getMerchantName()==null||modell.getMerchantName()==""||modell.getMerchantName().equals("%41")){
	    			model.addObject("merchantName", "");
	    		}else{
	    			model.addObject("merchantName", modell.getMerchantName());
	    		}if(modell.getOrgName()==null||modell.getOrgName()==""||modell.getOrgName().equals("%41")){
	    			model.addObject("orgName", "");
	    		}else{
	    			model.addObject("orgName", modell.getOrgName());
	    		}if(modell.getWalletStatus()==null||modell.getWalletStatus()==""||modell.getWalletStatus().equals("%41")){
	    			model.addObject("status", "");
	    		}else{
	    			model.addObject("status", modell.getWalletStatus());
	    		}if(modell.getWalletEmail()==null||modell.getWalletEmail()==""||modell.getWalletEmail().equals("%41")){
	    			model.addObject("walletEmail", "");
	    		}else{
	    			model.addObject("walletEmail", modell.getWalletEmail());
	    		}if(modell.getWalletTxnId()==null||modell.getWalletTxnId()==""||modell.getWalletTxnId().equals("%41")){
	    			model.addObject("txnId", "");
	    		}else{
	    			model.addObject("txnId", modell.getWalletTxnId());
	    		}if(modell.getCustPhone()==null||modell.getCustPhone()==""||modell.getCustPhone().equals("%41")){
	    			 model.addObject("custPhone","");
	    		}else{
	    			 model.addObject("custPhone", modell.getCustPhone());
	    		}if(modell.getFromDateTime()==null||modell.getFromDateTime()==""||modell.getFromDateTime().equals("%41")){
	    			model.addObject("fromDate", "");
	    		}else{
	    			model.addObject("fromDate", modell.getFromDateTime());
	    		}if(modell.getToDateTime()==null||modell.getToDateTime()==""||modell.getToDateTime().equals("%41")){
	    			 model.addObject("toDate", "");
	    		}else{
	    			model.addObject("toDate", modell.getToDateTime());
	    		}if(modell.getTxnType()==null|| modell.getTxnType()==""|| modell.getTxnType().equals("%41")){
	    	        model.addObject("txnType", "");
	    	    }else{
	    	        model.addObject("txnType", modell.getTxnType());
	    	    }if(modell.getAuthcode()==null||modell.getAuthcode()==""||modell.getAuthcode().equals("%41")){
	    			model.addObject("authcode", "");
	    		}else{
	    			model.addObject("authcode", modell.getAuthcode());
	    		}
	    		model.addObject("page",modell.getPage());
	    		model.addObject("walletList", list);
	    		model.addObject("empRole", modell.getEmpId());
	    		model.setViewName("wholeWalletList");
	    		logger.info("response returned from wallet List controller");
	    	}catch(Exception e){
	    		logger.error("error in Wallet List controller "+e);
	    	}
	    }else{
	    	logger.info("you are logged out");
	    	model.setViewName("login");
	    }
		return model;
	}
}
