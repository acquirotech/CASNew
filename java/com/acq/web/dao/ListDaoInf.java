package com.acq.web.dao;

import java.util.HashMap;
import java.util.List;
import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dto.impl.DbDto;

public interface ListDaoInf {

	DbDto<List<HashMap<String, String>>> walletList(AcqSearchModel modell);

	DbDto<List<HashMap<String, String>>> txnMerchantlist(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> txnOrgList(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> txnTerminalList(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> riskManagementList(AcqSearchModel modell);

	DbDto<Object> updateRiskStatus(String id, String txnType);

	DbDto<String> addRisk(String txnId, String txnType);

	DbDto<HashMap<String, String>> getCardTxnDetails(String signImage);

	DbDto<String> updateMdr(String txnId, String AcqMdr, String bankMdr);

	DbDto<List<HashMap<String, String>>> txnMerchantlist1(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> txnOrgList1(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> txnTerminalList1(AcqBillingModel modell);

	DbDto<List<HashMap<String, String>>> wholeTxnList(AcqSearchModel modell);

	DbDto<List<HashMap<String, String>>> downloadRiskDetails(String fromDate, String toDate);

	DbDto<List<HashMap<String, String>>> rechargeList(AcqSearchModel modell);

	DbDto<List<HashMap<String, String>>> transactionList(AcqSearchModel modell);
}
