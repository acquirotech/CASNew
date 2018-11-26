package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.impl.ServiceDto;

public interface MainHandlerInf {
	ServiceDto<List<String>> getHomePageReport(String email);
	ServiceDto<Object> getDetails(String servervalue);
	ServiceDto<HashMap<String, String>> getSuperAdminDetails(String servervalue, String admnres);
	ServiceDto<List<String>> getSettingList();
	ServiceDto<List<String>> getSettingUpdateList(AcqSettingModel modell);
	ServiceDto<List<HashMap<String, String>>> getMerchantList(AcqSearchModel modell);
	ServiceDto<List<HashMap<String, String>>> PreBoardedMerchantlist(AcqSearchModel modell);
	ServiceDto<Map> PreBoardedmerchantdetails(String merchantId, String emp);
}
