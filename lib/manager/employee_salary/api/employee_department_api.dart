import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_salary/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/group_type_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/month_list_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/yearlist_dropdown_model.dart';

import '../../../constants/api_url_constants.dart';

class EmployeeDepartmentApi {
  EmployeeDepartmentApi.init();
  static final EmployeeDepartmentApi instance = EmployeeDepartmentApi.init();

  getDepartment({
    required int miId,
    required int asmayId,
    required String base,
    required EmployeeSalaryController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = "$base${URLS.empGetDepartment}";

      if (salaryController.isErrorOccuredWhileLoadingDepartment.value) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(false);
      }

      salaryController.updateIsLoadingDepartment(true);

      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "ASMAY_Id": asmayId});

      if (response.data['departmentdropdown'] == null) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
        salaryController.updateIsLoadingDepartment(false);
        return;
      }
      final GroupTypeDropdownModel department =
          GroupTypeDropdownModel.fromJson(response.data['departmentdropdown']);

      final YearListDorpdownModel yearList =
          YearListDorpdownModel.fromJson(response.data['leaveyeardropdown']);
      final MonthDorpdownModel month =
          MonthDorpdownModel.fromJson(response.data['monthdropdown']);

      salaryController.updateDepartment(department.values!);
      if (department.values!.isNotEmpty) {
        salaryController.addToSelectedDepartment(department.values!.first);
      }
      salaryController.updateIsErrorOccuredWhileLoadongDepartment(false);
      salaryController.updateIsLoadingDepartment(false);

      salaryController.yearlist.clear();
      salaryController.monthList.clear();
      if (month.values!.isNotEmpty) {
        salaryController.selectedMonth = month.values!.first;
        salaryController.monthList.addAll(month.values!);
      }
      if (yearList.values!.isNotEmpty) {
        salaryController.selectedYear = yearList.values!.first;
        salaryController.yearlist.addAll(yearList.values!);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
      salaryController.updateIsLoadingDepartment(false);
    }
  }
}
