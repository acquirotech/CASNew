package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqDSAModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.controller.model.AcqTeleCallerModel;
import com.acq.web.dto.impl.ServiceDto;

public interface EmpManagementHandlerInf {

	ServiceDto<AcqEmpDetailsModel> empChangeProfile(AcqEmpDetailsModel modell);

	ServiceDto<List<HashMap<String, String>>> emplockunlock();

	ServiceDto<HashMap<String, String>> empProfile(String empId);

	ServiceDto<Object> addEmployee(AcqCreateEmployeeModel model);

	ServiceDto<HashMap<String, String>> empChangePassword1(String empEmailId);

	ServiceDto<AcqEmpDetailsModel> empChangePassword(AcqEmpDetailsModel modell);

	ServiceDto<String> deleteEmployee(String empId);

	ServiceDto<List<HashMap<String, String>>> empList();

	ServiceDto<AcqDSAModel> addDsa(AcqDSAModel modell);

	ServiceDto<List<HashMap<String, String>>> dsaManagement();

	ServiceDto<AcqDSAModel> updateDSA(AcqDSAModel modell);

	ServiceDto<List<HashMap<String, String>>> empReportList();

	ServiceDto<String> deleteTeleCaller(String dummyUser);

	ServiceDto<String> updateTeleCustomer(AcqTeleCallerModel modell);

	ServiceDto<HashMap<String, String>> callerDetails(String callerId);

	ServiceDto<List<HashMap<String, String>>> teleCustomerList(AcqSearchModel modell);

	ServiceDto<String> createTeleCustomer(AcqTeleCallerModel modell);


	

}
