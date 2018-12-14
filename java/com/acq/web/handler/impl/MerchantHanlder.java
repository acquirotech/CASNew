package com.acq.web.handler.impl;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.acq.web.controller.model.AcqPrepaidInventoryDeviceModel;
import com.acq.AcqImageFunctions;
import com.acq.AcqNumericValidator;
import com.acq.AcqSmsUtility;
import com.acq.mail.impl.EmailServiceHandler;
import com.acq.web.controller.model.AcqInventoryDeviceModel;
import com.acq.web.controller.model.AcqMerchantNewModel;
import com.acq.web.controller.model.AcqMerchantSearchModel;
import com.acq.web.controller.model.AcqNewDeviceDetailModel;
import com.acq.web.controller.model.AcqNewOrganization;
import com.acq.web.controller.model.AcqNewUpdateDeviceDetailModel;
import com.acq.web.controller.model.AcqNewUpdateMerchantModel;
import com.acq.web.controller.model.AcqNewUpdateOrgModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.PreBoardNewMerchant;
import com.acq.web.dao.MerchantDaoInf;
import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;
import com.acq.web.handler.MerchantHanlderInf;

@Service
public class MerchantHanlder implements MerchantHanlderInf{

	final static Logger logger = Logger.getLogger(MerchantHanlder.class);
	
	@Autowired
	MerchantDaoInf merchantDao;
	
	
	@Value("#{AcqConfig['signimage.location']}")
	 private String pdfLocation;
	 public String getPdfLocation() {
	  return pdfLocation;
	 }
	
	 @Value("#{AcqConfig['mrchntUptEmail']}")
		private String mrchntUptEmail;
		public String getMrchntUptEmail() {
			return mrchntUptEmail;
		}
	 
	@Value("#{AcqConfig['adminUptEmail']}")
	private String adminUptEmail;
	public String getAdminUptEmail() {
		return adminUptEmail;
	}
		
	 @Value("#{AcqConfig['preBoard.location']}")
	  private String preBoardLocation;
	 public String getPreBoardLocation() {
	  return preBoardLocation;
	 }
	 
	 
	 	
	@Autowired
	EmailServiceHandler emailServiceHandler;
	public ServiceDto<Object> preBoardNewMerchant(PreBoardNewMerchant model) {
		logger.info("request landing in pre board merchant handler");
		ServiceDto<Object> response = new ServiceDto<Object>();
		try{
			DbDto<Object> daoResponse = merchantDao.preBoardNewMerchant(model);
			 if(model.getFile()!=null&&!model.getFile().isEmpty()){
				String location = preBoardLocation+File.separator+model.getPhoneNo()+".pdf";			
				if(AcqImageFunctions.savePdf(model.getFile(),location) == false) {
					logger.warn("pdf not uploaded");				
				}
			} 
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());	
		}catch(Exception e){
			logger.info("error in pre board merchant handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> updatePreBoardMerchant(PreBoardNewMerchant model) {
		ServiceDto<Object>  response = new ServiceDto<Object>();
		try{
			DbDto<Object> daoResponse = merchantDao.updatePreBoardMerchant(model);
			if(model.getFile()!=null&&!model.getFile().isEmpty()){
								String location = preBoardLocation+File.separator+model.getPhoneNo()+".pdf";			
								if(AcqImageFunctions.savePdf(model.getFile(),location) == false) {
									logger.warn("pdf not uploaded");				
								}
							} 
						response.setStatus(daoResponse.getStatus());
						response.setMessage(daoResponse.getMessage());
						response.setResult(daoResponse.getResult());
					}catch(Exception e){
						logger.info("error in Update Pre BoardMerchant handler "+e);
					}
					return response;
				 }
	public ServiceDto<List<HashMap<String, String>>> downloadDeviceDetails(String fromDate,String toDate) {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String, String>>> daoResponse = merchantDao.downloadDeviceDetails(fromDate,toDate);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in download Device Details handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> downloadMerchantDtls(String merchantId) {
		ServiceDto<Object> response = new ServiceDto<Object>();
		try{
			logger.info("download merchant details handler");
			DbDto<Object> daoResponse = merchantDao.downloadMerchantDtls(merchantId);			
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in merchant details handler "+e);
		}
		return response;
	}
		
	public ServiceDto<List<HashMap<String, String>>> executivesList() {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			logger.info("request in sale executive list handler");
			DbDto<List<HashMap<String, String>>> daoResponse = merchantDao.executivesList();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in sale executive list handler "+e);
		}
		return response;
	}
	public ServiceDto<List<HashMap<String, String>>> empexecutivesList() {
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			logger.info("request in sale executive list handler");
			DbDto<List<HashMap<String, String>>> daoResponse = merchantDao.empexecutivesList();
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in sale executive list handler "+e);
		}
		return response;
	}
	
	public ServiceDto<List<HashMap<String, String>>> selectTidAndMerchant(AcqMerchantSearchModel model) {
		logger.info("Request landing select tid and merchant handler");
		ServiceDto<List<HashMap<String, String>>> response = new ServiceDto<List<HashMap<String, String>>>();
		try{
			DbDto<List<HashMap<String, String>>> daoResponse = merchantDao.selectTidAndMerchant(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in select tid and merchant handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> updatedevicedetail(
			AcqNewUpdateDeviceDetailModel model) {
		ServiceDto<Object>  response = new ServiceDto<Object> ();
		try{
			DbDto<Object> daoResponse = merchantDao.updatedevicedetail(model);
			if(daoResponse.getResult()!=null&&daoResponse.getResult()!=""){
				try{
						List<String> list = (List<String>) daoResponse.getResult();
						HashMap<String,Object> pageData= new HashMap<String,Object>();
						StringBuffer reason = new StringBuffer();
						SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
						SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
						 Date validTill = sdfDestination1.parse(model.getValidTil());
						String validtill = sdfSource1.format(validTill);
				if(!validtill.equals(list.get(24)))
				{
					reason.append("Valid Till :  ").append(validtill);
					reason.append("<br>");
					reason.append("Valid Till Old : ").append(list.get(24));
				}				
				if(!model.getRent().equals(list.get(0)))
				{
					reason.append("Rent :  ").append(model.getRent());
					reason.append("<br>");
					reason.append("Rent Old : ").append(list.get(0));
				}if(!model.getPendingRent().equals(list.get(2)))
				{
					reason.append("PendingRent :  ").append(model.getPendingRent());
					reason.append("<br>");
					reason.append("PendingRent Old : ").append(list.get(2));
				}if(!model.getPaymentMode().equals(list.get(1)))
				{
					reason.append("PaymentMode :  ").append(model.getPaymentMode());
					reason.append("<br>");
					reason.append("PaymentMode Old : ").append(list.get(1));
				}
				Double amount = Double.parseDouble(model.getAvgTxnAmount());
				Double amount1 = Double.parseDouble(list.get(7));
				String avgTxnAmount= ""+new DecimalFormat("#.###").format(amount);
				String avgTxnAmount1= ""+new DecimalFormat("#.###").format(amount1);
				if(!avgTxnAmount.equals(avgTxnAmount1))
				{
					reason.append("Avg Txn Amount :  ").append(avgTxnAmount);
					reason.append("<br>");
					reason.append("Avg Txn Amount Old : ").append(list.get(7));
				}
				if(((!model.getPenaltyAmount().equals(list.get(3)))&&(model.getPenaltyAmount() != null &&  model.getPenaltyAmount() != ""&& model.getPenaltyAmount().length()>1)))
				{
					reason.append("<br>");
					reason.append("Penalty Amount :  ").append(model.getPenaltyAmount());
					reason.append("<br>");
					reason.append("Penalty Amount Old :  ").append(list.get(3));
				}if((!model.getPenaltyReason().equals(list.get(4)))&&(model.getPenaltyReason() != null && model.getPenaltyReason() != ""&&model.getPenaltyReason().length()>2))		
				{
					reason.append("<br>");
					reason.append("Penalty Reason :  ").append(model.getPenaltyReason());
					reason.append("<br>");
					reason.append("Penalty Reason Old :  ").append(list.get(4));
				}if((!model.getDiscount().equals(list.get(5)))&&(model.getDiscount() != null && model.getDiscount() != ""&&model.getDiscount().length()>1))	
				{
					reason.append("<br>");
					reason.append("Discount :  ").append(model.getDiscount());
					reason.append("<br>");
					reason.append("Discount Old :  ").append(list.get(5));
				}if((!model.getDiscountReason().equals(list.get(6)))&&(model.getDiscountReason() != null && model.getDiscountReason() != ""&&model.getDiscountReason().length()>2))
				{
					reason.append("<br>");
					reason.append("Discount Reason :  ").append(model.getDiscountReason());
					reason.append("<br>");
					reason.append("Discount Reason Old :  ").append(list.get(6));
				//}if((model.getMdrDebit0() != null || model.getMdrDebit0() != ""||model.getMdrDebit0().length()>1)&&(!model.getMdrDebit0().equals(list.get(25)))){
				}if((!model.getMdrDebit0().equals(list.get(25)))&&(model.getMdrDebit0() != null || model.getMdrDebit0() != ""||model.getMdrDebit0().length()>1)){
					reason.append("<br>");
					reason.append("MDR Debit0 :  ").append(model.getMdrDebit0());
					reason.append("<br>");
					reason.append("MDR Debit0 Old :  ").append(list.get(25));
				}if((!model.getMdrDebit1().equals(list.get(8)))&&(model.getMdrDebit1() != null || model.getMdrDebit1() != ""||model.getMdrDebit1().length()>1)){
					reason.append("<br>");
					reason.append("MDR Debit1 :  ").append(model.getMdrDebit1());
					reason.append("<br>");
					reason.append("MDR Debit1 Old :  ").append(list.get(8));
				}if((!model.getMdrDebit2().equals(list.get(9)))&&(model.getMdrDebit2() != null && model.getMdrDebit2() != ""&&model.getMdrDebit2().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR Debit2 :  ").append(model.getMdrDebit2());
					reason.append("<br>");
					reason.append("MDR Debit2 Old :  ").append(list.get(9));
				}if((!model.getMdrCreditNpre().equals(list.get(11)))&&(model.getMdrCreditNpre() != null && model.getMdrCreditNpre() != ""&&model.getMdrCreditNpre().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR Credit Non Premium :  ").append(model.getMdrCreditNpre());
					reason.append("<br>");
					reason.append("MDR Credit Non Premium Old :  ").append(list.get(11));
				}if((!model.getMdrCreditPre().equals(list.get(10)))&&(model.getMdrCreditPre() != null && model.getMdrCreditPre() != ""&&model.getMdrCreditPre().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR Credit Premium :  ").append(model.getMdrCreditPre());
					reason.append("<br>");
					reason.append("MDR Credit Premium Old :  ").append(list.get(10));
				}if((!model.getMdrMobiKwik().equals(list.get(12)))&&(model.getMdrMobiKwik() != null && model.getMdrMobiKwik() != ""&&model.getMdrMobiKwik().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR Wallet :  ").append(model.getMdrMobiKwik());
					reason.append("<br>");
					reason.append("MDR Wallet Old :  ").append(list.get(12));
				}if((!model.getMdrCashAtPos().equals(list.get(13)))&&(model.getMdrCashAtPos() != null && model.getMdrCashAtPos() != ""&&model.getMdrCashAtPos().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR CashAtPos :  ").append(model.getMdrCashAtPos());
					reason.append("<br>");
					reason.append("MDR CashAtPos :  ").append(list.get(13));
				}if((!model.getOther().equals(list.get(14)))&&(model.getOther() != null && model.getOther() != ""&&model.getOther().length()>1))	
				{
					reason.append("<br>");
					reason.append("MDR International :  ").append(model.getOther());
					reason.append("<br>");
					reason.append("MDR International Old :  ").append(list.get(14));
				}if((!model.getBankAccountType().equals(list.get(15)))&&(model.getBankAccountType() != null && model.getBankAccountType() != ""&&model.getBankAccountType().length()>1))	
				{
					reason.append("<br>");
					reason.append("Account Type :  ").append(model.getBankAccountType());
					reason.append("<br>");
					reason.append("Account Type Old :  ").append(list.get(15));
				}if((!model.getBankAccountNo().equals(list.get(16)))&&(model.getBankAccountNo() != null && model.getBankAccountNo() != ""&&model.getBankAccountNo().length()>1))	
				{
					reason.append("<br>");
					reason.append("Account No :  ").append(model.getBankAccountNo());
					reason.append("<br>");
					reason.append("Account No Old :  ").append(list.get(16));
				}if((!model.getBankName().equals(list.get(17)))&&(model.getBankName() != null && model.getBankName() != ""&&model.getBankName().length()>1))	
				{
					reason.append("<br>");
					reason.append("Bank Name :  ").append(model.getBankName());
					reason.append("<br>");
					reason.append("Bank Name Old :  ").append(list.get(17));
				}if((!model.getBenefName().equals(list.get(18)))&&(model.getBenefName() != null && model.getBenefName() != ""&&model.getBenefName().length()>1))	
				{
					reason.append("<br>");
					reason.append("Beneficiary Name :  ").append(model.getBenefName());
					reason.append("<br>");
					reason.append("Beneficiary Name Old :  ").append(list.get(18));
				}if((!model.getBranchName().equals(list.get(19)))&&(model.getBranchName() != null && model.getBranchName() != ""&&model.getBranchName().length()>1))	
				{
					reason.append("<br>");
					reason.append("Bank Branch :  ").append(model.getBranchName());
					reason.append("<br>");
					reason.append("Bank Branch Old :  ").append(list.get(19));
				}if((!model.getBankIfsc().equals(list.get(21)))&&(model.getBankIfsc() != null && model.getBankIfsc() != ""&&model.getBankIfsc().length()>1))	
				{
					reason.append("<br>");
					reason.append("Bank IFSC :  ").append(model.getBankIfsc());
					reason.append("<br>");
					reason.append("Bank IFSC Old :  ").append(list.get(21));
				}if((!model.getBankMicr().equals(list.get(20)))&&(model.getBankMicr() != null && model.getBankMicr() != ""&&model.getBankMicr().length()>1))	
				{
					reason.append("<br>");
					reason.append("Bank MICR :  ").append(model.getBankMicr());
					reason.append("<br>");
					reason.append("Bank MICR Old :  ").append(list.get(20));
				}							
						if((reason != null && !reason.toString().equals("")) ){
							pageData.put("fname", model.getLoginId());
							String htmlString="<p style= <p style='padding: 5px;color: #500050;font-weight: normal;font-size: 14px;'> "+ pageData.get("fname") +" application for AcqSwype Mobile Point of Sale Solution has been Updated.<br />"
			       					+reason+"</p>";
							        logger.info("PageData:"+htmlString);						
									pageData.put("htmlString", htmlString);
									emailServiceHandler.sendEmail(pageData,"/emailtemplate/updatedevice.html",mrchntUptEmail);	
							
					   }else{							
							logger.info("PageData Not Found For Update:"+pageData);				
						}
					}catch(Exception e){
						logger.error("error to send email in add merchant "+e);
					}
				}
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Update Users Device handler "+e);
		}
		// TODO Auto-generated method stub
		return response;
	}
	
	public ServiceDto<AcqNewUpdateOrgModel> updateOrg(AcqNewUpdateOrgModel model) {
		ServiceDto<AcqNewUpdateOrgModel>  response = new ServiceDto<AcqNewUpdateOrgModel> ();
		try{
			DbDto<AcqNewUpdateOrgModel> daoResponse = merchantDao.updateOrg(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Update Users Device handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> updateMerchant(AcqNewUpdateMerchantModel model) {
		ServiceDto<Object>  response = new ServiceDto<Object> ();
		try{
			DbDto<Object> daoResponse = merchantDao.updateMerchant(model);		
			if(model.getFile()!=null&&!model.getFile().isEmpty()){
				String filename = model.getFile().getOriginalFilename();
				if(filename!=null&&filename.endsWith(".pdf")){				
					//System.out.println("model.getFile().getSize():::::" +model.getFile().getSize());
					String location = pdfLocation+File.separator+model.getMerId()+".pdf";			
					if(AcqImageFunctions.savePdf(model.getFile(),location) == false) {
						logger.warn("pdf not uploaded");				
					}
				}
			}
			if(daoResponse.getResult()!=null&&daoResponse.getResult()!=""){
				try{
						List<String> list = (List<String>) daoResponse.getResult();
						HashMap<String,Object> pageData= new HashMap<String,Object>();
						StringBuffer reason = new StringBuffer();
						SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd/MM/yyyy");
						SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd");
						
				if(!model.getModeofpayment().equalsIgnoreCase(list.get(0))){
					reason.append("Payment Mode :  ").append(model.getModeofpayment());
					reason.append("<br>");
					reason.append("Payment Mode Old : ").append(list.get(0));
					reason.append("<br>");
				}if((model.getSwipeAmount() != null && model.getSwipeAmount() != ""&&model.getSwipeAmount().length()>1)&&(!model.getSwipeAmount().equals(list.get(1))))
				{
					reason.append("Swipe Amount :  ").append(model.getSwipeAmount());
					reason.append("<br>");
					reason.append("Swipe Amount Old : ").append(list.get(1));
				}if(((!model.getSwipeTerminal().equals(list.get(2)))&&(model.getSwipeTerminal() != null &&  model.getSwipeTerminal() != ""&& model.getSwipeTerminal().length()>1)))
				{
					reason.append("<br>");
					reason.append("swipe Terminal :  ").append(model.getSwipeTerminal());
					reason.append("<br>");
					reason.append("swipe Terminal Old :  ").append(list.get(2));
				}if((!model.getCashAmount().equals(list.get(3)))&&(model.getCashAmount() != null && model.getCashAmount() != ""&&model.getCashAmount().length()>1))		
				{
					reason.append("<br>");
					reason.append("Cash Amount :  ").append(model.getCashAmount());
					reason.append("<br>");
					reason.append("Cash Amount Old :  ").append(list.get(3));
				}if((!model.getChequeAmount().equals(list.get(4)))&&(model.getChequeAmount() != null && model.getChequeAmount() != ""&&model.getChequeAmount().length()>1))	
				{
					reason.append("<br>");
					reason.append("Cheque Amount :  ").append(model.getChequeAmount());
					reason.append("<br>");
					reason.append("Cheque Amount Old :  ").append(list.get(4));
				}if((!model.getChequeNo().equals(list.get(6)))&&(model.getChequeNo() != null && model.getChequeNo() != ""&&model.getChequeNo().length()>1))
				{
					reason.append("<br>");
					reason.append("Cheque No :  ").append(model.getChequeNo());
					reason.append("<br>");
					reason.append("Cheque No Old :  ").append(list.get(6));
				}if((!model.getChequeBank().equals(list.get(5)))&&(model.getChequeBank() != null && model.getChequeBank() != ""&&model.getChequeBank().length()>1))
				{
					reason.append("<br>");
					reason.append("Cheque Bank :  ").append(model.getChequeBank());
					reason.append("<br>");
					reason.append("Cheque Bank Old :  ").append(list.get(5));
				}if((!model.getNeftAmount().equals(list.get(7)))&&(model.getNeftAmount() != null && model.getNeftAmount() != ""&&model.getNeftAmount().length()>1))	
				{
					reason.append("<br>");
					reason.append("NEFT Amount :  ").append(model.getNeftAmount());
					reason.append("<br>");
					reason.append("NEFT Amount Old :  ").append(list.get(7));
				}if((!model.getNeftchequeNo().equals(list.get(8)))&&(model.getNeftchequeNo() != null && model.getNeftchequeNo() != ""&&model.getNeftchequeNo().length()>1))	
				{
					reason.append("<br>");
					reason.append("NEFT ChequeNo :  ").append(model.getNeftchequeNo());
					reason.append("<br>");
					reason.append("NEFT ChequeNo Old :  ").append(list.get(8));
				}
				
				if((model.getSwipeDate() != null && model.getSwipeDate() != ""&&model.getSwipeDate().length()>1))	
				{
					Date swipeDate = sdfDestination1.parse(model.getSwipeDate());
					String swipedate = sdfSource1.format(swipeDate);
					if((!swipedate.equals(list.get(10))))
					{
					reason.append("<br>");
					reason.append("Swipe Date :  ").append(swipedate);
					reason.append("<br>");
					if(list.get(10) != null && list.get(10) != "" ){
						reason.append("Swipe Date Old :  ").append(list.get(10));
					}else{
						reason.append("Swipe Date Old :  ").append("");
					}
					
					}
				}	if((model.getCashDate() != null && model.getCashDate() != ""&&model.getCashDate().length()>1))	
				{   Date cashDate = sdfDestination1.parse(model.getCashDate());
						String cashdate = sdfSource1.format(cashDate);
					if((!cashdate.equals(list.get(11)))){
						reason.append("<br>");
						reason.append("Cash Date :  ").append(cashdate);
						reason.append("<br>");
						if(list.get(11) != null && list.get(11) != "" ){
							reason.append("Cash Date Old :  ").append(list.get(11));
						}else{
							reason.append("Cash Date Old :  ").append("");
						}
						
				    }	
				}if((model.getChequeDate() != null && model.getChequeDate() != ""&&model.getChequeDate().length()>1))	
				{
						Date cashDate = sdfDestination1.parse(model.getChequeDate());
						String cashdate = sdfSource1.format(cashDate);
					if(!cashdate.equals(list.get(12))){
					reason.append("<br>");
					reason.append("Cheque Date :  ").append(cashdate);
					reason.append("<br>");
					if(list.get(12) != null && list.get(12) != "" ){
						reason.append("Cheque Date Old :  ").append(list.get(12));
					}else{
						reason.append("Cheque Date Old :  ").append("");	
					}
					}
				}if((model.getChequeDepositDate() != null && model.getChequeDepositDate() != ""&&model.getChequeDepositDate().length()>1))	
				{
						Date cashDate = sdfDestination1.parse(model.getChequeDepositDate());
						String cashdate = sdfSource1.format(cashDate);
					if((!cashdate.equals(list.get(13)))){
					reason.append("<br>");
					reason.append("Cheque Deposite Date :  ").append(cashdate);
					reason.append("<br>");
					if(list.get(13) != null && list.get(13) != "" ){
						reason.append("Cheque Deposite Date Old :  ").append(list.get(13));
					}else{
						reason.append("Cheque Deposite Date Old :  ").append("");
					}
					}
				}	if((model.getNeftDate() != null && model.getNeftDate() != ""&&model.getNeftDate().length()>1))	
				{
					Date cashDate = sdfDestination1.parse(model.getNeftDate());
					String cashdate = sdfSource1.format(cashDate);
					if((!cashdate.equals(list.get(14)))){
					reason.append("<br>");
					reason.append("NEFT Date :  ").append(cashdate);
					reason.append("<br>");
					if(list.get(14) != null && list.get(14) != "" ){
						reason.append("NEFT Date Old :  ").append(list.get(14));
					}else{
						reason.append("NEFT Date Old :  ").append("");
					}
					}
				}if(!pageData.isEmpty()||(reason != null && !reason.toString().equals("")) ){
					pageData.put("fname", model.getMarketingName());
					String htmlString="<p style= <p style='padding: 5px;color: #500050;font-weight: normal;font-size: 14px;'> "+ pageData.get("fname") +" application for AcqSwype Mobile Point of Sale Solution has been Updated.<br />"
							+reason+"</p>";
					logger.info("PageData:"+htmlString);
					pageData.put("htmlString", htmlString);
					emailServiceHandler.sendEmail(pageData,"/emailtemplate/updatemerchant.html",mrchntUptEmail);	
				}else{							
					logger.info("PageData Not Found For Update:"+pageData);				
				}
			}catch(Exception e){
				logger.error("error to send email in add merchant "+e);
			}
			}
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in add Merchant handler "+e);
		}
		return response;
	}
	
public ServiceDto<String> merchantDelete(String merchantId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = merchantDao.merchantDelete(merchantId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Merchant handler "+e);
		}
		return response;
	}
public ServiceDto<String> deletePreBoard(String id) {
	ServiceDto<String>  response = new ServiceDto<String> ();
	try{
		DbDto<String> daoResponse = merchantDao.deletePreBoard(id);
		response.setStatus(daoResponse.getStatus());
		response.setMessage(daoResponse.getMessage());
		response.setResult(daoResponse.getResult());
	}catch(Exception e){
		logger.info("error in Delete Merchant handler "+e);
	}
	return response;
}	

public ServiceDto<List<HashMap<String, String>>> merchantListPagination(String id) {
	ServiceDto<List<HashMap<String, String>>>  response = new ServiceDto<List<HashMap<String, String>>> ();
	try{
		DbDto<List<HashMap<String, String>>> daoResponse = merchantDao.merchantListPagination(id);
		response.setStatus(daoResponse.getStatus());
		response.setMessage(daoResponse.getMessage());
		response.setResult(daoResponse.getResult());
	}catch(Exception e){
		logger.info("error in Delete Merchant handler "+e);
	}
	return response;
}
	public ServiceDto<String> deleteorg(String orgId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = merchantDao.deleteorg(orgId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Organization handler "+e);
		}
		return response;
	}
	
	public ServiceDto<String> devicedelete(String userId,String orgId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = merchantDao.devicedelete(userId,orgId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Users Device handler "+e);
		}
		// TODO Auto-generated method stub
		return response;
	}

	public ServiceDto<Object> addOrganization(AcqNewOrganization model) {
		logger.info("request landing in Organization handler");
		ServiceDto<Object> response = new ServiceDto<Object>();
		try{
			DbDto<Object> daoResponse = merchantDao.addOrganization(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());	
		}catch(Exception e){
			logger.info("error in add Organization handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> deviceList(String accessKey) {
		ServiceDto<Object>  response = new ServiceDto<Object> ();
		try{
			DbDto<Object> daoResponse = merchantDao.deviceList(accessKey);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in device and bank tid handler "+e);
		}
		return response;
	 }
	
	public ServiceDto<Object> addMerchant(AcqMerchantNewModel model) {
		logger.info("request landing in merchant handler");
		ServiceDto<Object> response = new ServiceDto<Object>();
		System.out.println("pdfLocation :"+pdfLocation);
		try{
			DbDto<Object> daoResponse = merchantDao.addMerchant(model);
			 if(model.getFile()!=null&&!model.getFile().isEmpty()){
				String location = pdfLocation+File.separator+daoResponse.getResult()+".pdf";
				if(AcqImageFunctions.savePdf(model.getFile(),location) == false) {
					logger.warn("pdf not uploaded");
				}
			 }if(daoResponse.getStatus()==0&&daoResponse.getMessage().equals("OK")){
				if(AcqNumericValidator.checkPhoneNo(model.getPhoneNo())){
					try{
						String message = "Hi "+model.getMarketingName()+", Your application has been logged with  for verification. We'll soon update you with credentials to use .";
						AcqSmsUtility.sendSMS(message, model.getPhoneNo());
					}catch(Exception e){
						logger.error("error to send sms "+e);
					}
				}
				if(model.getEmailId()!=null&&model.getEmailId()!=""&&model.getEmailId().length()>=4){
					try{
						HashMap<String,Object> pageData= new HashMap<String,Object>();
						pageData.put("email", model.getEmailId());
						pageData.put("fname", model.getMarketingName());
					    pageData.put("appNo", daoResponse.getResult());
					    pageData.put("mailType", "addMerchant");
					    emailServiceHandler.sendEmailWithCC(pageData,"/emailtemplate/addmerchant.html","signup@.com" , model.getEmailId());
					}catch(Exception e){
						logger.error("error to send email in add merchant "+e);
					}
				}
			}  
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());	
		}catch(Exception e){
			logger.info("error in add merchant handler "+e);
		}
		return response;
	}
	
	public ServiceDto<Object> addDeviceDetail(AcqNewDeviceDetailModel model) {
		logger.info("request landing in Device Detail handler");
		ServiceDto<Object> response = new ServiceDto<Object>();
		try{
			//System.out.println("handler"+model.getMdrMobiKwik());
			DbDto<Object> daoResponse = merchantDao.addDeviceDetail(model);			
			if(daoResponse.getStatus()==0&&daoResponse.getMessage().equals("OK")){
				if(AcqNumericValidator.checkPhoneNo(model.getRmn())){
					try{
						String message = "Hi "+model.getName()+", Your username to login into  is "+model.getLoginId()+". Your one time password is 123. Happy Swyping..!!";
						 AcqSmsUtility.sendSMS(message, model.getRmn());
					}catch(Exception e){
						logger.error("error to send sms in user");
					}
				}
				if(model.getEmailId()!=null&&model.getEmailId()!=""&&model.getEmailId().length()>=4){
					try{
						HashMap<String,Object> pageData= new HashMap<String,Object>();
						pageData.put("email", model.getEmailId());
						pageData.put("fname", model.getName());
						pageData.put("deviceId", daoResponse.getResult());
						pageData.put("mailType", "addDevice");
						emailServiceHandler.sendEmailWithCC(pageData,"/emailtemplate/adddevice.html","signup@Acquiro.com" , model.getEmailId());
					}catch(Exception e){
						logger.error("error to send email in add merchant "+e);
					}
				}
			}
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());	
		}catch(Exception e){
			logger.info("error in add user/device handler "+e);
		}
		return response;
	}
		
	 public ServiceDto<String> inventoryDeviceDelete(String deviceId) {
		ServiceDto<String>  response = new ServiceDto<String> ();
		try{
			DbDto<String> daoResponse = merchantDao.inventoryDeviceDelete(deviceId);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Inventory Device handler "+e);
		}
		return response;
	 }

	 public ServiceDto<AcqInventoryDeviceModel> inventoryUpdateDevice(
	   AcqInventoryDeviceModel model) {
		ServiceDto<AcqInventoryDeviceModel>  response = new ServiceDto<AcqInventoryDeviceModel>();
		try{
			DbDto<AcqInventoryDeviceModel> daoResponse = merchantDao.inventoryUpdateDevice(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Update Inventory Device handler "+e);
		}
		return response;
	 }
	
	 public ServiceDto<List<HashMap<String, String>>> InventoryDeviceList(
	   AcqSearchModel modell) {
		logger.info("request landing in inventory device list");
		ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
		try{
			DbDto<List<HashMap<String,String>>> daoResponse = merchantDao.InventoryDeviceList(modell);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in inventory device list handler "+e);
		}
		return response;
	 }
	
	public ServiceDto<AcqInventoryDeviceModel> inventoryAddDevice(AcqInventoryDeviceModel model) {
		logger.info("request landing in add inventory device handler");
		ServiceDto<AcqInventoryDeviceModel> response = new ServiceDto<AcqInventoryDeviceModel>();
		try{
			DbDto<AcqInventoryDeviceModel> daoResponse = merchantDao.inventoryAddDevice(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult()); 
		}catch(Exception e){
			logger.info("error in add inventory device handler "+e);
		}
		return response;
	 }
	 public ServiceDto<AcqPrepaidInventoryDeviceModel> prepaidInventoryUpdateDevice(
			 AcqPrepaidInventoryDeviceModel model) {
				ServiceDto<AcqPrepaidInventoryDeviceModel>  response = new ServiceDto<AcqPrepaidInventoryDeviceModel>();
				try{
					DbDto<AcqPrepaidInventoryDeviceModel> daoResponse = merchantDao.prepaidInventoryUpdateDevice(model);
					response.setStatus(daoResponse.getStatus());
					response.setMessage(daoResponse.getMessage());
					response.setResult(daoResponse.getResult());
				}catch(Exception e){
					logger.info("error in Update Inventory Device handler "+e);
				}
				return response;
			 }
	
	 public ServiceDto<List<HashMap<String, String>>> prepaidInventoryList(
			   AcqSearchModel modell) {
				logger.info("request landing in inventory device list");
				ServiceDto<List<HashMap<String,String>>> response = new ServiceDto<List<HashMap<String,String>>>();
				try{
					DbDto<List<HashMap<String,String>>> daoResponse = merchantDao.prepaidInventoryList(modell);
					response.setStatus(daoResponse.getStatus());
					response.setMessage(daoResponse.getMessage());
					response.setResult(daoResponse.getResult());
				}catch(Exception e){
					logger.info("error in inventory device list handler "+e);
				}
				return response;
			 }

	
	public ServiceDto<AcqPrepaidInventoryDeviceModel> addPrepaidInventory(AcqPrepaidInventoryDeviceModel model) {
		logger.info("request landing in add prepaid inventory device handler");
		ServiceDto<AcqPrepaidInventoryDeviceModel> response = new ServiceDto<AcqPrepaidInventoryDeviceModel>();
		try{
			DbDto<AcqPrepaidInventoryDeviceModel> daoResponse = merchantDao.addPrepaidInventory(model);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult()); 
		}catch(Exception e){
			logger.info("error in add prepaid inventory device handler "+e);
		}
		return response;
	 }
	@Override
	public ServiceDto<Object> getBankTid(String serialNo) {
		ServiceDto<Object>  response = new ServiceDto<Object> ();
		try{
			DbDto<Object> daoResponse = merchantDao.getBankTid(serialNo);
			response.setStatus(daoResponse.getStatus());
			response.setMessage(daoResponse.getMessage());
			response.setResult(daoResponse.getResult());
		}catch(Exception e){
			logger.info("error in Delete Inventory Device handler "+e);
		}
		return response;
	}
}
