import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_salary/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/designation_dropdown_model.dart';

class EmployeeDesignationApi {
  EmployeeDesignationApi.init();
  static final EmployeeDesignationApi instance = EmployeeDesignationApi.init();

  getDesignation({
    required int miId,
    required int asmayId,
    required String base,
    required String departments,
    required EmployeeSalaryController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = "${base}api/SalaryDetailsFacade/get_designation/";

      if (salaryController.isErrorOccuredWhileLoadingDesignation.value) {
        salaryController.updateIsErrorOccuredWhileLoadongDesignation(false);
      }

      salaryController.updateIsLoadingDesignation(true);

      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "ASMAY_Id": asmayId,
            "multipledep": departments
          });

      if (response.data['designationdropdown'] == null) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
        salaryController.updateIsLoadingDepartment(false);
        return;
      }
      final DesignationDropdownModel designation =
          DesignationDropdownModel.fromJson(
              response.data['designationdropdown']);

      salaryController.updateDesignation(designation.values!);
      if (designation.values!.isNotEmpty) {
        salaryController.addToSelectedDesignation(designation.values!.first);
      }
      salaryController.updateIsErrorOccuredWhileLoadongDesignation(false);
      salaryController.updateIsLoadingDesignation(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      salaryController.updateIsErrorOccuredWhileLoadongDesignation(true);
      salaryController.updateIsLoadingDesignation(false);
    }
  }
}
