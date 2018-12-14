package com.acq.web.dao;

import java.util.HashMap;
import java.util.List;

import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqDSAModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqTeleCallerModel;
import com.acq.web.dto.impl.DbDto;

public interface EmpManagementDaoInf {

	DbDto<AcqEmpDetailsModel> empChangeProfile(AcqEmpDetailsModel modell);

	DbDto<List<HashMap<String, String>>> emplockunlock();

	DbDto<HashMap<String, String>> empProfile(String empId);

	DbDto<Object> addEmployee(AcqCreateEmployeeModel model);

	DbDto<AcqEmpDetailsModel> empChangePassword(AcqEmpDetailsModel modell);

	DbDto<HashMap<String, String>> empChangePassword(String empEmailId);

	DbDto<String> deleteEmployee(String empId);

	DbDto<List<HashMap<String, String>>> empList();

	DbDto<AcqDSAModel> addDsa(AcqDSAModel model);

	DbDto<List<HashMap<String, String>>> dsaManagement();

	DbDto<AcqDSAModel> updateDSA(AcqDSAModel model);

	DbDto<List<HashMap<String, String>>> empReportList();

	DbDto<List<HashMap<String, String>>> teleCustomerList(AcqSearchModel model);

	DbDto<String> deleteTeleCaller(String empId);

	DbDto<String> updateTeleCustomer(AcqTeleCallerModel modell);

	DbDto<HashMap<String, String>> callerDetails(String callerId);

	DbDto<String> createTeleCustomer(AcqTeleCallerModel modell);

}
