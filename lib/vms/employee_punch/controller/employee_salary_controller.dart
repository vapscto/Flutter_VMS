import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_slip_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/designation_dropdown_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/employee_details.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/group_type_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/month_list_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/staff_list_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/yearlist_dropdown_model.dart';

class EmployeePunchController extends GetxController {
  final RxList<GroupTypeDropdownValues> department = RxList();
  final RxList<GroupTypeDropdownValues> selectedDepartment = RxList();

  void updateDepartment(List<GroupTypeDropdownValues> val) {
    if (department.isNotEmpty) {
      department.clear();
    }

    department.addAll(val);
  }

  void addToSelectedDepartment(GroupTypeDropdownValues sele) {
    selectedDepartment.add(sele);
  }

  void removeFromSelectedDepartment(GroupTypeDropdownValues sele) {
    selectedDepartment.remove(sele);
  }

  RxBool isLoadingDepartment = RxBool(false);
  RxBool isErrorOccuredWhileLoadingDepartment = RxBool(false);

  void updateIsLoadingDepartment(bool b) {
    isLoadingDepartment.value = b;
  }

  void updateIsErrorOccuredWhileLoadongDepartment(bool b) {
    isErrorOccuredWhileLoadingDepartment.value = b;
  }

  final RxList<DesignationDropdownValues> designation = RxList();
  final RxList<DesignationDropdownValues> selectedDesignation = RxList();

  void updateDesignation(List<DesignationDropdownValues> val) {
    if (designation.isNotEmpty) {
      designation.clear();
    }

    designation.addAll(val);
  }

  void addToSelectedDesignation(DesignationDropdownValues sele) {
    selectedDesignation.add(sele);
  }

  void removeFromSelectedDesignation(DesignationDropdownValues sele) {
    selectedDesignation.remove(sele);
  }

  RxBool isLoadingDesignation = RxBool(false);
  RxBool isErrorOccuredWhileLoadingDesignation = RxBool(false);

  void updateIsLoadingDesignation(bool b) {
    isLoadingDesignation.value = b;
  }

  void updateIsErrorOccuredWhileLoadongDesignation(bool b) {
    isErrorOccuredWhileLoadingDesignation.value = b;
  }

  final RxList<YearListDorpdownValues> yearlist = RxList();
  final RxList<MonthDorpdownValues> monthList = RxList();

  MonthDorpdownValues? selectedMonth;
  YearListDorpdownValues? selectedYear;

  RxBool isLoadingStaff = RxBool(false);
  RxBool isErrorOccuredWhileLoadingStaff = RxBool(false);

  void updateIsLoadingStaff(bool b) {
    isLoadingStaff.value = b;
  }

  void updateIsErrorOccuredWhileLoadongStaff(bool b) {
    isErrorOccuredWhileLoadingStaff.value = b;
  }

  final RxList<StaffListValues> staffs = RxList();

  void updateStaff(List<StaffListValues> val) {
    if (staffs.isNotEmpty) {
      staffs.clear();
    }

    staffs.addAll(val);
  }

  StaffListValues? selectedStaff;

  final RxList<EmployeeSalarySlipValues> salarySlip = RxList();
  void updateSalarySlip(List<EmployeeSalarySlipValues> list) {
    if (salarySlip.isNotEmpty) {
      salarySlip.clear();
    }
    salarySlip.addAll(list);
  }

  RxList<EmployeePunchDetailsModelValues> employeePunchDetails =
      <EmployeePunchDetailsModelValues>[].obs;
  RxBool isDataLoading = RxBool(false);
  void loading(bool loading) {
    isDataLoading.value = loading;
  }

  getList(List<EmployeePunchDetailsModelValues> list) {
    if (employeePunchDetails.isNotEmpty) {
      employeePunchDetails.clear();
    }
    for (int index = 0; index < list.length; index++) {
      employeePunchDetails.add(list.elementAt(index));
    }
  }
}
