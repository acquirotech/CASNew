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
import com.acq.AcqNumericValidator;
import com.acq.AcqStatusDefination;
import com.acq.dto.impl.ControllerResponse;
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
	@RequestMapping(value = { "/downloadcardCommisionProcedureFromAndToDate" }, method = RequestMethod.GET)
	public ModelAndView downloadcardCommisionProcedureFromAndToDate(@RequestParam (required = true)String merchantId,@RequestParam (required = false)String orgId,@RequestParam (required = false)String loginId,@RequestParam (required = false)String acquirerCode,@RequestParam (required = false)String fromDate,@RequestParam (required = false)String toDate, @RequestParam (required = false) String txnType,@RequestParam (required = false)String payoutStatus,HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		logger.info("request is landing download MDR Rpt New Process:::"+acquirerCode);
		ControllerResponse<Object> response = new ControllerResponse<Object>();
		 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
		try{	
			String empId = AcqAuthToken.getAuthToken().getName();
			ServiceDto<Object> daoResponse = reportsHandler.downloadcardCommisionProcedureFromAndToDate(acquirerCode,empId,merchantId,orgId,loginId,fromDate,toDate,txnType,payoutStatus);
			if(daoResponse.getStatus()==AcqStatusDefination.OK.getIdentifier()&&daoResponse.getMessage()==AcqStatusDefination.OK.getDetails()){
				String fileName = ""+daoResponse.getResult();
				return new ModelAndView("redirect:/downloadCommisionExcel?fileName="+fileName);
			}else{   
				logger.info("response returned from download MDR Rpt New Process");
				model.setViewName("cardCommisionReportFromAndToDate");
				model.addObject("msg", daoResponse.getMessage());
			}				
		}catch(Exception e){
			response.setStatus(AcqStatusDefination.RollBackError.getIdentifier());
			response.setMessage(AcqStatusDefination.RollBackError.getDetails());
			response.setResult(null);
			logger.error("Error in download MDR Rpt New Process controller "+e);
		}  }else{
			logger.info("you are logged out");
			model.setViewName("index");
		}
		return model;
	}
	
	@RequestMapping(value = {"/cardCommissionReportProcedure"}, method = RequestMethod.GET)
	public ModelAndView cardCommissionReportProcedure(AcqBillingModel modell,HttpServletRequest request){
		List<HashMap<String,String>> list = null; 
		ModelAndView model = new ModelAndView();   
		if(AcqNumericValidator.checkId(""+modell.getMerchantId())==false){
			modell.setMerchantId(Long.valueOf("0"));
		}if(AcqNumericValidator.checkId(""+modell.getOrgId())==false){
			modell.setOrgId(Long.valueOf("0"));
		}
 if (AcqAuthToken.getAuthToken().getName().length()!=13&&AcqAuthToken.getAuthToken().getName() != "anonymousUser" ){
			try{
				
				ServiceDto<List<HashMap<String,String>>> merchantList= listHandler.txnMerchantlist(modell);
				list = merchantList.getResult();
				model.addObject("merchantList", list);
				if(modell.getMerchantId()!=null&&modell.getMerchantId()+""!="" && Integer.valueOf(""+modell.getMerchantId())>0){
					ServiceDto<List<HashMap<String,String>>> orgList= listHandler.txnOrgList(modell);
					list = orgList.getResult();
					model.addObject("orgList", list);
				}if(modell.getOrgId()!=null&&modell.getOrgId()+""!=""&&Integer.valueOf(""+modell.getOrgId())>0){
					ServiceDto<List<HashMap<String,String>>> terminalList= listHandler.txnTerminalList(modell);
					list = terminalList.getResult();
					model.addObject("terminalList", list);
				}
				model.setViewName("commissionNewReport");
				logger.info("response returned from Card commission report controller");  
			}catch(Exception e){
				logger.error("Error from Card commission report controller");
			}
		}else{
			logger.info("you are logged out");
			model.setViewName("index");
		}
		return model;
	}
	
	
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
				 	model.setViewName("txnreports");
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
