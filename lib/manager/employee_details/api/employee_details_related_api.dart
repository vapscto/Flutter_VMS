import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_details/model/departmentModel.dart';
import 'package:m_skool_flutter/manager/employee_details/model/designationModel.dart';
import 'package:m_skool_flutter/manager/employee_details/model/employeeDetailsModel.dart';
import 'package:m_skool_flutter/manager/employee_details/model/typeModel.dart';

var dio = Dio();

Future<TypeModel?> getTypesData({
  required String base,
  required int miId,
  required int asmayId,
}) async {
  var url = base + URLS.getTypes;
  logger.d(url);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
      },
    );
    if (response.statusCode == 200) {
      TypeModel typeModel = TypeModel.fromJson(response.data);
      return typeModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<DepartmentModel?> getDepartmentData({
  required String base,
  required int miId,
  required int asmayId,
  required String multipletype,
}) async {
  var url = base + URLS.getDepartment;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipletype": multipletype,
      },
    );
    if (response.statusCode == 200) {
      DepartmentModel departmentModel = DepartmentModel.fromJson(response.data);
      return departmentModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<DesignationModel?> getDesignationData({
  required int miId,
  required int asmayId,
  required String multipletype,
  required String multipledep,
  required String base,
}) async {
  var url = base + URLS.getdesignation;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipledep": multipledep,
        "multipletype": multipletype,
      },
    );
    if (response.statusCode == 200) {
      DesignationModel designationModel =
          DesignationModel.fromJson(response.data);
      return designationModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<EmployeDetailsModel?> getEmployeeDetails({
  required int miId,
  required bool left,
  required bool working,
  required List selectedDepartment,
  required List selectedDesignation,
  required List selectedType,
  required List selectedHeader,
  required String base,
}) async {
  var url = base + URLS.getEmployeeDetails;
  logger.d(url);
  logger.d({
    "MI_Id": miId,
    "FormatType": "Format2",
    "Left": left,
    "Working": working,
    "departmentselected": selectedDepartment,
    "designationselected": selectedDesignation,
    "groupTypeselected": selectedType,
    "headerselected": selectedHeader,
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "FormatType": "Format2",
        "Left": left,
        "Working": working,
        "departmentselected": selectedDepartment,
        "designationselected": selectedDesignation,
        "groupTypeselected": selectedType,
        "headerselected": selectedHeader,
      },
    );
    if (response.statusCode == 200) {
      EmployeDetailsModel employeDetailsModel =
          EmployeDetailsModel.fromJson(response.data);
      return employeDetailsModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
