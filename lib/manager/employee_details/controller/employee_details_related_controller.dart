import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_details/api/employee_details_related_api.dart';
import 'package:m_skool_flutter/manager/employee_details/model/departmentModel.dart';
import 'package:m_skool_flutter/manager/employee_details/model/employeeDetailsModel.dart';
import 'package:m_skool_flutter/manager/employee_details/model/typeModel.dart';

import '../model/designationModel.dart';

class EmployeeDetailsController extends GetxController {
  RxList<FilltypesValue> typeList = <FilltypesValue>[].obs;
  RxList<FilldepartmentValue> departmentList = <FilldepartmentValue>[].obs;
  RxList<FilldesignationValue> designationList = <FilldesignationValue>[].obs;
  RxList<EmployeeDetailsValue> employeeDetailsList =
      <EmployeeDetailsValue>[].obs;

  RxList<Map> headerList = <Map>[
    {"columnID": "HRME_Photo", "columnName": "Employee Photo"},
    {"columnID": "HRME_EmployeeCode", "columnName": "Employee Code"},
    {"columnID": "HRME_EmployeeFirstName", "columnName": "Employee Name"},
    {"columnID": "HRME_FatherName", "columnName": "Father Name"},
    {"columnID": "HRME_MobileNo", "columnName": "Mobile No."},
    {"columnID": "HRME_EmailId", "columnName": "Email Id"},
    {"columnID": "HRME_DOB", "columnName": "Date Of Birth"},
    {"columnID": "HRME_DOJ", "columnName": "Date of Join"},
    {
      "columnID": "HRME_ExpectedRetirementDate",
      "columnName": "Retirement Date"
    },
    {"columnID": "HRME_PerStreet", "columnName": "Address"},
    {"columnID": 'HREED_Amount', "columnName": 'Basic Amount'},
  ].obs;

  RxList<int> selectedHeaderList = <int>[].obs;

  void addToSelectedHeaderList(int index) {
    selectedHeaderList.add(index);
  }

  void removeFromSelectedHeaderList(int index) {
    selectedHeaderList.removeWhere((i) => i == index);
  }

  RxBool isType = RxBool(false);
  RxBool isDepartment = RxBool(false);
  RxBool isDesignation = RxBool(false);
  RxBool isSearch = RxBool(false);
  RxBool left = RxBool(false);
  RxBool working = RxBool(false);

  void leftCheckbox(bool check) {
    left.value = check;
  }

  void workingCheckbox(bool check) {
    working.value = check;
  }

  void istypeloading(bool loading) {
    isType.value = loading;
  }

  void isdepartmentloading(bool loading) {
    isDepartment.value = loading;
  }

  void isdesignationloading(bool loading) {
    isDesignation.value = loading;
  }

  void issearchloadig(bool loading) {
    isSearch.value = loading;
  }

  Future<bool> getTypes({
    required String base,
    required int miId,
    required int asmayId,
  }) async {
    TypeModel? typeModel =
        await getTypesData(base: base, miId: miId, asmayId: asmayId);
    try {
      if (typeModel!.filltypes != null || typeModel.filltypes!.values != null) {
        typeList.clear();
        for (var i = 0; i < typeModel.filltypes!.values!.length; i++) {
          typeList.add(typeModel.filltypes!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getDepartment({
    required String base,
    required int miId,
    required int asmayId,
    required String multipletype,
  }) async {
    DepartmentModel? departmentModel = await getDepartmentData(
        base: base, miId: miId, asmayId: asmayId, multipletype: multipletype);
    departmentList.clear();
    designationList.clear();
    try {
      if (departmentModel!.filldepartment != null ||
          departmentModel.filldepartment!.values != null) {
        for (var i = 0;
            i < departmentModel.filldepartment!.values!.length;
            i++) {
          departmentList
              .add(departmentModel.filldepartment!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getDesignation({
    required int miId,
    required int asmayId,
    required String multipletype,
    required String multipledep,
    required String base,
  }) async {
    DesignationModel? designationModel = await getDesignationData(
        miId: miId,
        asmayId: asmayId,
        multipletype: multipletype,
        multipledep: multipledep,
        base: base);
    designationList.clear();
    try {
      if (designationModel!.filldesignation != null ||
          designationModel.filldesignation!.values != null) {
        for (var i = 0;
            i < designationModel.filldesignation!.values!.length;
            i++) {
          designationList
              .add(designationModel.filldesignation!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getEmployeeDetail({
    required int miId,
    required bool left,
    required bool working,
    required List selectedDepartment,
    required List selectedDesignation,
    required List selectedType,
    required List selectedHeader,
    required String base,
  }) async {
    EmployeDetailsModel? employeDetailsModel = await getEmployeeDetails(
        miId: miId,
        left: left,
        working: working,
        selectedDepartment: selectedDepartment,
        selectedDesignation: selectedDesignation,
        selectedType: selectedType,
        selectedHeader: selectedHeader,
        base: base);
    try {
      if (employeDetailsModel!.employeeDetailsfromDatabase != null ||
          employeDetailsModel.employeeDetailsfromDatabase!.values != null) {
        employeeDetailsList.clear();
        for (var i = 0;
            i < employeDetailsModel.employeeDetailsfromDatabase!.values!.length;
            i++) {
          employeeDetailsList.add(employeDetailsModel
              .employeeDetailsfromDatabase!.values!
              .elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
