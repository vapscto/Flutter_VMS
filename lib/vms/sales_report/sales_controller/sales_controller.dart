import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/sales_report/model/department_model.dart';
import 'package:m_skool_flutter/vms/sales_report/model/designation_model.dart';
import 'package:m_skool_flutter/vms/sales_report/model/employee_model.dart';
import 'package:m_skool_flutter/vms/sales_report/model/sale_list_model.dart';

class SalesController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  RxBool isDesignationLoading = RxBool(false);
  RxBool isDepartmentLoading = RxBool(false);
  RxBool isEmployeeLoading = RxBool(false);
  void error(bool error) {
    isErrorLoading.value = error;
  }

  void designationLoading(bool loading) {
    isDesignationLoading.value = loading;
  }

  void departmentLoading(bool v) {
    isDepartmentLoading.value = v;
  }

  void employeeLoading(bool v) {
    isEmployeeLoading.value = v;
  }

  //department
  RxList<DepartmentListModelValues> departmentlistValues =
      <DepartmentListModelValues>[].obs;
  RxList<DepartmentListModelValues> departmentSelectedValues =
      <DepartmentListModelValues>[].obs;
  // RxList<int> idListController = <int>[].obs;
  void getDepartment(List<DepartmentListModelValues> value) {
    if (departmentlistValues.isNotEmpty) {
      departmentlistValues.clear();
    }
    for (int index = 0; index < value.length; index++) {
      departmentlistValues.add(value.elementAt(index));
    }
  }

  void addSelectedValues(DepartmentListModelValues value) {
    departmentSelectedValues.add(value);
  }

  void removeSelectedValues(DepartmentListModelValues value) {
    departmentSelectedValues.remove(value);
  }

  // Designation
  RxList<DesignationListModelValues> designationListValues =
      <DesignationListModelValues>[].obs;
  RxList<DesignationListModelValues> selectedDesignationListValues =
      <DesignationListModelValues>[].obs;
  RxList<int> designationId = <int>[].obs;
  void getDesignation(List<DesignationListModelValues> designation) {
    if (designationListValues.isNotEmpty) {
      designationListValues.clear();
    }
    for (int index = 0; index < designation.length; index++) {
      designationListValues.add(designation.elementAt(index));
    }
  }

  void addDegId(int value) {
    designationId.add(value);
  }

  void removeDegId(int value) {
    designationId.removeAt(value);
  }

  void addSelectedDesignationValues(DesignationListModelValues value) {
    selectedDesignationListValues.add(value);
  }

  void removeSelectedDesignationValues(DesignationListModelValues value) {
    selectedDesignationListValues.remove(value);
  }

  //employee list
  RxList<EmployeeListModelValues> employeeListValues =
      <EmployeeListModelValues>[].obs;
  RxList<EmployeeListModelValues> selectedEmployeeListValues =
      <EmployeeListModelValues>[].obs;
  RxList<int> empId = <int>[].obs;
  void getEmployee(List<EmployeeListModelValues> employee) {
    if (employeeListValues.isNotEmpty) {
      employeeListValues.clear();
    }
    for (int index = 0; index < employee.length; index++) {
      employeeListValues.add(employee.elementAt(index));
    }
  }

  void addSelectedEmpValues(EmployeeListModelValues value) {
    selectedEmployeeListValues.add(value);
  }

  void removeSelectedEmpValues(EmployeeListModelValues value) {
    selectedEmployeeListValues.remove(value);
  }

  void addEmpId(int value) {
    empId.add(value);
  }

  void removeEmpId(int value) {
    empId.removeAt(value);
  }

  //Sales list
  RxBool isList = RxBool(false);
  void listLoading(bool loading) {
    isList.value = loading;
  }

  RxList<SalesEmployeeListModelValues> leadListModelValue =
      <SalesEmployeeListModelValues>[].obs;
  void salesList(List<SalesEmployeeListModelValues> list) {
    if (leadListModelValue.isNotEmpty) {
      leadListModelValue.clear();
    }
    for (int i = 0; i < list.length; i++) {
      leadListModelValue.add(list.elementAt(i));
    }
  }
}
