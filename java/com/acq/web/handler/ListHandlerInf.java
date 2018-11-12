package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;

import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dto.impl.ServiceDto;

public interface ListHandlerInf {


	ServiceDto<List<HashMap<String, String>>> txnMerchantlist(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> txnOrgList(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> txnTerminalList(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> walletList(AcqSearchModel modell);

	ServiceDto<List<HashMap<String, String>>> riskManagementList(AcqSearchModel modell);

	ServiceDto<Object> updateRiskStatus(String riskId, String txnType);

	ServiceDto<String> addRisk(String txnId, String txnType);

	ServiceDto<HashMap<String, String>> getCardTxnDetails(String requestString);

	ServiceDto<String> updateMdr(String txnId, String AcqMdr, String bankMdr);

	ServiceDto<List<HashMap<String, String>>> txnMerchantlist1(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> txnOrgList1(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> txnTerminalList1(AcqBillingModel modell);

	ServiceDto<List<HashMap<String, String>>> wholeTxnList(AcqSearchModel modell);

	ServiceDto<List<HashMap<String, String>>> downloadRiskDetails(String fromDate, String toDate);

	ServiceDto<List<HashMap<String, String>>> transactionList(AcqSearchModel modell);

	ServiceDto<List<HashMap<String, String>>> rechargeList(AcqSearchModel modell);

	
}
