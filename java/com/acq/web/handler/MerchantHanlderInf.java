package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;
import com.acq.web.controller.model.AcqInventoryDeviceModel;
import com.acq.web.controller.model.AcqMerchantNewModel;
import com.acq.web.controller.model.AcqMerchantSearchModel;
import com.acq.web.controller.model.AcqNewDeviceDetailModel;
import com.acq.web.controller.model.AcqNewOrganization;
import com.acq.web.controller.model.AcqNewUpdateDeviceDetailModel;
import com.acq.web.controller.model.AcqNewUpdateMerchantModel;
import com.acq.web.controller.model.AcqNewUpdateOrgModel;
import com.acq.web.controller.model.AcqPrepaidInventoryDeviceModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.PreBoardNewMerchant;
import com.acq.web.dto.impl.ServiceDto;

public interface MerchantHanlderInf {

	ServiceDto<AcqInventoryDeviceModel> inventoryAddDevice(AcqInventoryDeviceModel model);

	ServiceDto<List<HashMap<String, String>>> InventoryDeviceList(AcqSearchModel modell);

	ServiceDto<String> inventoryDeviceDelete(String deviceId);

	ServiceDto<AcqInventoryDeviceModel> inventoryUpdateDevice(AcqInventoryDeviceModel model);

	ServiceDto<Object> addDeviceDetail(AcqNewDeviceDetailModel model);

	ServiceDto<Object> addMerchant(AcqMerchantNewModel model);

	ServiceDto<Object> addOrganization(AcqNewOrganization model);

	ServiceDto<String> merchantDelete(String merchantId);

	ServiceDto<String> deleteorg(String orgId);

	ServiceDto<String> devicedelete(String userId, String orgId);

	ServiceDto<Object> updateMerchant(AcqNewUpdateMerchantModel model);

	ServiceDto<AcqNewUpdateOrgModel> updateOrg(AcqNewUpdateOrgModel model);

	ServiceDto<Object> updatedevicedetail(AcqNewUpdateDeviceDetailModel model);

	ServiceDto<List<HashMap<String, String>>> selectTidAndMerchant(AcqMerchantSearchModel modell);

	ServiceDto<Object> deviceList(String accessKey);

	ServiceDto<Object> getBankTid(String serialNo);

	ServiceDto<List<HashMap<String, String>>> executivesList();

	ServiceDto<Object> downloadMerchantDtls(String merchantId);

	ServiceDto<List<HashMap<String, String>>> downloadDeviceDetails(String fromDate, String toDate);

	ServiceDto<Object> updatePreBoardMerchant(PreBoardNewMerchant model);

	ServiceDto<Object> preBoardNewMerchant(PreBoardNewMerchant model);

	ServiceDto<List<HashMap<String, String>>> empexecutivesList();

	ServiceDto<String> deletePreBoard(String id);

	ServiceDto<List<HashMap<String, String>>> merchantListPagination(String id);

	ServiceDto<AcqPrepaidInventoryDeviceModel> addPrepaidInventory(AcqPrepaidInventoryDeviceModel model);

	ServiceDto<List<HashMap<String, String>>> prepaidInventoryList(AcqSearchModel modell);

	ServiceDto<AcqPrepaidInventoryDeviceModel> prepaidInventoryUpdateDevice(AcqPrepaidInventoryDeviceModel model);


	
}
