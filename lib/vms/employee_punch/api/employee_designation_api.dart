import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/designation_dropdown_model.dart';

class EmployeeDesignationApi {
  EmployeeDesignationApi.init();
  static final EmployeeDesignationApi instance = EmployeeDesignationApi.init();

  getDesignation({
    required int miId,
    required int asmayId,
    required String base,
    required String departments,
    required EmployeePunchController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/EmployeeLateInEarlyOutReportFacade/get_designation";

      if (salaryController.isErrorOccuredWhileLoadingDesignation.value) {
        salaryController.updateIsErrorOccuredWhileLoadongDesignation(false);
      }
      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipledep": departments.substring(0, departments.length - 1),
        "multipletype": "1,2,3,4,5,6,7"
      });
      salaryController.updateIsLoadingDesignation(true);

      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipledep": departments.substring(0, departments.length - 1),
        "multipletype": "1,2,3,4,5,6,7"
      });

      if (response.data['filldesignation'] == null) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
        salaryController.updateIsLoadingDepartment(false);
        return;
      }
      final DesignationDropdownModel designation =
          DesignationDropdownModel.fromJson(response.data['filldesignation']);

      salaryController.updateDesignation(designation.values!);
      if (designation.values!.isNotEmpty) {
        //salaryController.addToSelectedDesignation(designation.values!.first);
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
