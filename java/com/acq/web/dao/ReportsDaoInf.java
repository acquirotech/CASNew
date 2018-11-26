package com.acq.web.dao;

import java.util.HashMap;
import java.util.List;

import com.acq.web.dto.impl.DbDto;

public interface ReportsDaoInf {

	DbDto<List<HashMap<String, String>>> downloadCardTxnReport(String merchantId, String orgId, String userId,
			String fromDate, String toDate, String txnType);

	DbDto<List<HashMap<String, String>>> downloadRechargeReport(String merchantId, String orgId, String userId,
			String fromDate, String toDate, String txnType);

	DbDto<List<HashMap<String, String>>> downloadDmtReport(String merchantId, String orgId, String userId,
			String fromDate, String toDate, String txnType);

	DbDto<Object> downloadcardCommisionProcedureFromAndToDate(String acquirerCode, String empId, String merchantId,
			String orgId, String userId, String fromDate, String batch, String txnType, String payoutStatus);

	

}
