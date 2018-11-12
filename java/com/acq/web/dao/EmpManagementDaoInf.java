package com.acq.web.dao;

import java.util.HashMap;
import java.util.List;

import com.acq.web.controller.model.AcqCreateEmployeeModel;
import com.acq.web.controller.model.AcqEmpDetailsModel;
import com.acq.web.controller.model.AcqSearchModel;
import com.acq.web.dto.impl.DbDto;

public interface EmpManagementDaoInf {

	DbDto<AcqEmpDetailsModel> empChangeProfile(AcqEmpDetailsModel modell);

	DbDto<List<HashMap<String, String>>> emplockunlock();

	DbDto<HashMap<String, String>> empProfile(String empId);

	DbDto<Object> addEmployee(AcqCreateEmployeeModel model);

	DbDto<AcqEmpDetailsModel> empChangePassword(AcqEmpDetailsModel modell);

	DbDto<HashMap<String, String>> empChangePassword(String empEmailId);

	DbDto<String> deleteEmployee(String empId);

}
