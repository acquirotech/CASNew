package com.acq.web.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acq.AcqAuthToken;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.ListHandlerInf;
import com.acq.web.handler.ReportsHandlerInf;

@Controller
public class ReportsController {

	final static Logger logger = Logger.getLogger(ReportsController.class);
	
	@Autowired
	ReportsHandlerInf reportsHandler;
	
	@Autowired
	ListHandlerInf listHandler;
	
	@RequestMapping(value = { "/downloadCardTxnReport" }, method = RequestMethod.GET)
	public ModelAndView downloadCardTxnReport(@RequestParam (required = true)String merchantId,@RequestParam (required = false)String orgId,@RequestParam (required = false)String loginId,@RequestParam (required = false)String fromDate,@RequestParam (required = false)String toDate,@RequestParam (required = false)String txnType,HttpServletRequest request) {
		List<HashMap<String,String>> list = null; 
		logger.info("request for donwload Card Txn report home");
		ModelAndView model = new ModelAndView();
		try{
		if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String,String>>> global= reportsHandler.downloadCardTxnReport(merchantId,orgId,loginId,fromDate,toDate,txnType);
			list = global.getResult();
			model.addObject("wallettxnlist", list);
			model.addObject("isreport", "isreport");
			model.setViewName("downloadTxnReport");
			logger.info("response returned from download Card Txn controller");
		}else{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		}catch(Exception e){
			logger.error("error to download Wallet dao"+e);
		}
		return model;
	}

	@RequestMapping(value = {"/cardTxnReport"}, method = RequestMethod.GET)
	 public ModelAndView cardTxnReport(AcqBillingModel modell,HttpServletRequest request) {
	     ModelAndView model = new ModelAndView();
	     List<HashMap<String,String>> list = null;
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){		    
			 try{
				 ServiceDto<List<HashMap<String,String>>> merchantList= listHandler.txnMerchantlist(modell);
				 list = merchantList.getResult();
				 model.addObject("merchantList", list);
				 	if(modell.getMerchantId()!=null&&modell.getMerchantId()+""!="" && modell.getMerchantId()>0){
				 		ServiceDto<List<HashMap<String,String>>> orgList= listHandler.txnOrgList(modell);
				 		list = orgList.getResult();
				 		model.addObject("orgList", list);
				 	}if(modell.getOrgId()!=null&&modell.getOrgId()+""!=""&&modell.getOrgId()>0){
				 		ServiceDto<List<HashMap<String,String>>> terminalList= listHandler.txnTerminalList(modell);
				 		list = terminalList.getResult();
				 		model.addObject("terminalList", list);
				 	}
				 	model.setViewName("txnreport");
				 	logger.info("response returned from card Txn Report controller");  
			 }catch(Exception e){
				 logger.error("Error from card Txn Report controller");
	     	 }
		}else{
			 logger.info("you are logged out");
			 model.setViewName("login");
		}
	    return model;
	}

	@RequestMapping(value = { "/downloadRechargeReport" }, method = RequestMethod.GET)
	public ModelAndView downloadRechargeReport(@RequestParam (required = true)String merchantId,@RequestParam (required = false)String orgId,@RequestParam (required = false)String loginId,@RequestParam (required = false)String fromDate,@RequestParam (required = false)String toDate,@RequestParam (required = false)String txnType,HttpServletRequest request) {
		List<HashMap<String,String>> list = null; 
		logger.info("request for donwload Card Txn report home");
		ModelAndView model = new ModelAndView();
		try{
		if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String,String>>> global= reportsHandler.downloadRechargeReport(merchantId,orgId,loginId,fromDate,toDate,txnType);
			list = global.getResult();
			model.addObject("wallettxnlist", list);
			model.addObject("isreport", "isreport");
			model.setViewName("downloadRechargeReport");
			logger.info("response returned from download Recharge Txn controller");
		}else{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		}catch(Exception e){
			logger.error("error to download Recharge dao"+e);
		}
		return model;
	}

	@RequestMapping(value = {"/rechargeReport"}, method = RequestMethod.GET)
	 public ModelAndView rechargeReport(AcqBillingModel modell,HttpServletRequest request) {
	     ModelAndView model = new ModelAndView();
	     List<HashMap<String,String>> list = null;
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){		    
			 try{
				 ServiceDto<List<HashMap<String,String>>> merchantList= listHandler.txnMerchantlist(modell);
				 list = merchantList.getResult();
				 model.addObject("merchantList", list);
				 	if(modell.getMerchantId()!=null&&modell.getMerchantId()+""!="" && modell.getMerchantId()>0){
				 		ServiceDto<List<HashMap<String,String>>> orgList= listHandler.txnOrgList(modell);
				 		list = orgList.getResult();
				 		model.addObject("orgList", list);
				 	}if(modell.getOrgId()!=null&&modell.getOrgId()+""!=""&&modell.getOrgId()>0){
				 		ServiceDto<List<HashMap<String,String>>> terminalList= listHandler.txnTerminalList(modell);
				 		list = terminalList.getResult();
				 		model.addObject("terminalList", list);
				 	}
				 	model.setViewName("RechargeReport");
				 	logger.info("response returned from Recharge Report controller");  
			 }catch(Exception e){
				 logger.error("Error from card recharge Report controller");
	     	 }
		}else{
			 logger.info("you are logged out");
			 model.setViewName("login");
		}
	    return model;
	}

	
	@RequestMapping(value = { "/downloaddmtReport" }, method = RequestMethod.GET)
	public ModelAndView downloaddmtReport(@RequestParam (required = true)String merchantId,@RequestParam (required = false)String orgId,@RequestParam (required = false)String loginId,@RequestParam (required = false)String fromDate,@RequestParam (required = false)String toDate,@RequestParam (required = false)String txnType,HttpServletRequest request) {
		List<HashMap<String,String>> list = null; 
		logger.info("request for donwload Card Txn report home");
		ModelAndView model = new ModelAndView();
		try{
		if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			ServiceDto<List<HashMap<String,String>>> global= reportsHandler.downloadDmtReport(merchantId,orgId,loginId,fromDate,toDate,txnType);
			list = global.getResult();
			model.addObject("wallettxnlist", list);
			model.addObject("isreport", "isreport");
			model.setViewName("downloadDmtReport");
			logger.info("response returned from download Dmt Txn controller");
		}else{
			logger.info("you are logged out");
			model.setViewName("login");
		}
		}catch(Exception e){
			logger.error("error to download Dmt dao"+e);
		}
		return model;
	}

	@RequestMapping(value = {"/dmtReport"}, method = RequestMethod.GET)
	 public ModelAndView dmtReport(AcqBillingModel modell,HttpServletRequest request) {
	     ModelAndView model = new ModelAndView();
	     List<HashMap<String,String>> list = null;
	     if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){		    
			 try{
				 ServiceDto<List<HashMap<String,String>>> merchantList= listHandler.txnMerchantlist(modell);
				 list = merchantList.getResult();
				 model.addObject("merchantList", list);
				 	if(modell.getMerchantId()!=null&&modell.getMerchantId()+""!="" && modell.getMerchantId()>0){
				 		ServiceDto<List<HashMap<String,String>>> orgList= listHandler.txnOrgList(modell);
				 		list = orgList.getResult();
				 		model.addObject("orgList", list);
				 	}if(modell.getOrgId()!=null&&modell.getOrgId()+""!=""&&modell.getOrgId()>0){
				 		ServiceDto<List<HashMap<String,String>>> terminalList= listHandler.txnTerminalList(modell);
				 		list = terminalList.getResult();
				 		model.addObject("terminalList", list);
				 	}
				 	model.setViewName("DmtReport");
				 	logger.info("response returned from Dmt Report controller");  
			 }catch(Exception e){
				 logger.error("Error from card Dmt Report controller");
	     	 }
		}else{
			 logger.info("you are logged out");
			 model.setViewName("login");
		}
	    return model;
	}
	
}
