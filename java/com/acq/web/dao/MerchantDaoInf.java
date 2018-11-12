package com.acq.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.acq.users.entity.AcqAddNewMerchantEntity;
import com.acq.web.controller.model.AcqInventoryDeviceModel;
import com.acq.web.controller.model.AcqMerchantNewModel;
import com.acq.web.controller.model.AcqMerchantSearchModel;
import com.acq.web.controller.model.AcqNewDeviceDetailModel;
import com.acq.web.controller.model.AcqNewOrganization;
import com.acq.web.controller.model.AcqNewUpdateDeviceDetailModel;
import com.acq.web.controller.model.AcqNewUpdateMerchantModel;
import com.acq.web.controller.model.AcqNewUpdateOrgModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqSettingModel;
import com.acq.web.dto.impl.DbDto;

public interface MerchantDaoInf {


	DbDto<AcqInventoryDeviceModel> inventoryAddDevice(
			AcqInventoryDeviceModel model);

	DbDto<List<HashMap<String, String>>> InventoryDeviceList(
			AcqSearchModel modell);

	DbDto<String> inventoryDeviceDelete(String deviceId);

	DbDto<AcqInventoryDeviceModel> inventoryUpdateDevice(
			AcqInventoryDeviceModel model);

	DbDto<Object> addOrganization(AcqNewOrganization model);

	DbDto<Object> addMerchant(AcqMerchantNewModel model);

	DbDto<Object> addDeviceDetail(AcqNewDeviceDetailModel model);

	DbDto<String> merchantDelete(String merchantId);

	DbDto<String> deleteorg(String orgId);

	DbDto<String> devicedelete(String userId, String orgId);

	DbDto<Object> updateMerchant(AcqNewUpdateMerchantModel model);

	DbDto<AcqNewUpdateOrgModel> updateOrg(AcqNewUpdateOrgModel model);

	DbDto<Object> updatedevicedetail(AcqNewUpdateDeviceDetailModel model);

	DbDto<List<HashMap<String, String>>> selectTidAndMerchant(
			AcqMerchantSearchModel model);

	DbDto<Object> deviceList(String accessKey);

	DbDto<Object> getBankTid(String serialNo);

	
	
	DbDto<List<HashMap<String, String>>> executivesList();


	DbDto<Object> downloadMerchantDtls(String merchantId);

	DbDto<List<HashMap<String, String>>> downloadDeviceDetails(String fromDate, String toDate);



}
