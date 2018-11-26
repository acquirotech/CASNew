package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;

import com.acq.web.dto.impl.ServiceDto;

public interface ReportsHandlerInf {

	ServiceDto<List<HashMap<String, String>>> downloadCardTxnReport(String merchantId, String orgId, String loginId,String fromDate, String toDate, String txnType);

	ServiceDto<List<HashMap<String, String>>> downloadRechargeReport(String merchantId, String orgId, String loginId,
			String fromDate, String toDate, String txnType);

	ServiceDto<List<HashMap<String, String>>> downloadDmtReport(String merchantId, String orgId, String loginId,
			String fromDate, String toDate, String txnType);

	ServiceDto<Object> downloadcardCommisionProcedureFromAndToDate(String acquirerCode, String empId, String merchantId,
			String orgId, String loginId, String fromDate, String toDate, String txnType, String payoutStatus);


	

}
