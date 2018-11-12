package com.acq.web.handler;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.dto.impl.ServiceDto;

public interface EmpManagementHandlerInf {

	ServiceDto<AcqEmpDetailsModel> empChangeProfile(AcqEmpDetailsModel modell);

	ServiceDto<List<HashMap<String, String>>> emplockunlock();

	ServiceDto<HashMap<String, String>> empProfile(String empId);

	ServiceDto<Object> addEmployee(AcqCreateEmployeeModel model);

	ServiceDto<HashMap<String, String>> empChangePassword1(String empEmailId);

	ServiceDto<AcqEmpDetailsModel> empChangePassword(AcqEmpDetailsModel modell);

	ServiceDto<String> deleteEmployee(String empId);


	

}
