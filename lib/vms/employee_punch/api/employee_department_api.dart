import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/group_type_model.dart';

class EmployeeDepartmentApi {
  EmployeeDepartmentApi.init();
  static final EmployeeDepartmentApi instance = EmployeeDepartmentApi.init();

  getDepartment({
    required int miId,
    required int asmayId,
    required String base,
    required EmployeePunchController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/EmployeeLateInEarlyOutReportFacade/get_departments";

      logger.d(api);

      if (salaryController.isErrorOccuredWhileLoadingDepartment.value) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(false);
      }

      salaryController.updateIsLoadingDepartment(true);

      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "ASMAY_Id": asmayId,
            "multipletype": "1,2,3,4,5,6,7"
          });

      logger.d({"MI_Id": miId, "ASMAY_Id": asmayId, "multipletype": "1,2"});

      if (response.data['filldepartment'] == null) {
        salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
        salaryController.updateIsLoadingDepartment(false);
        return;
      }
      final GroupTypeDropdownModel department =
          GroupTypeDropdownModel.fromJson(response.data['filldepartment']);
      salaryController.updateDepartment(department.values!);
      if (department.values!.isNotEmpty) {}
      salaryController.updateIsErrorOccuredWhileLoadongDepartment(false);
      salaryController.updateIsLoadingDepartment(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      salaryController.updateIsErrorOccuredWhileLoadongDepartment(true);
      salaryController.updateIsLoadingDepartment(false);
    }
  }
}
