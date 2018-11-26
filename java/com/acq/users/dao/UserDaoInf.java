package com.acq.users.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.acq.web.controller.model.AcqBillingModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.impl.DbDto;
import com.acq.web.dto.impl.ServiceDto;

public interface UserDaoInf {
	public List<HashMap<String,String>> merchantList();

	public TreeMap<String, Object> merchantDetails(String merchantId,String emp);
	public List<HashMap<String, String>> txnHome(AcqSearchModel modell);

	
	DbDto<List<HashMap<String, String>>> getMerchantList(AcqSearchModel modell);

	public void getMe();

	
	public DbDto<List<String>> getHomePageReport(String email);

	public DbDto<Object> getDetails();

	public DbDto<HashMap<String, String>> getSuperAdminDetails(String emailId, String admnres);

	public DbDto<List<String>> getSettingList();

	public DbDto<List<String>> getSettingUpdateList(AcqSettingModel modell);

	List<HashMap<String, String>> txnMerchantlist(AcqBillingModel modell);

	List<HashMap<String, String>> txnTerminalList(AcqBillingModel modell);

	public List<HashMap<String, String>> txnOrgList(AcqBillingModel modell);

	public DbDto<List<HashMap<String, String>>> PreBoardedMerchantlist(AcqSearchModel modell);

	public DbDto<Map> PreBoardedmerchantdetails(String merchantId, String emp);

}

	
	
