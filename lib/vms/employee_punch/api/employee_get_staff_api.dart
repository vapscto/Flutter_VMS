import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/staff_list_model.dart';

class EmployeeStaffApi {
  EmployeeStaffApi.init();
  static final EmployeeStaffApi instance = EmployeeStaffApi.init();

  getStaff({
    required int miId,
    required int asmayId,
    required String base,
    required String departments,
    required String selectedDesignation,
    required EmployeePunchController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/EmployeeLateInEarlyOutReportFacade/get_employee";

      logger.d(api);

      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipledep": departments.substring(0, departments.length - 1),
        "multipledes":
            selectedDesignation.substring(0, selectedDesignation.length - 0),
        "multipletype": "1,2,3,4,5,6,7"
      });

      if (salaryController.isErrorOccuredWhileLoadingStaff.value) {
        salaryController.updateIsErrorOccuredWhileLoadongStaff(false);
      }

      salaryController.updateIsLoadingStaff(true);

      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "multipledep": departments.substring(0, departments.length - 1),
        "multipledes":
            selectedDesignation.substring(0, selectedDesignation.length - 1),
        "multipletype": "1,2,3,4,5,6,7"
      });

      if (response.data['fillemployee'] == null) {
        salaryController.updateIsErrorOccuredWhileLoadongStaff(true);
        salaryController.updateIsLoadingStaff(false);
        return;
      }
      final StaffListModel staff =
          StaffListModel.fromJson(response.data['fillemployee']);

      salaryController.updateStaff(staff.values!);
      if (staff.values!.isNotEmpty) {
        salaryController.selectedStaff = staff.values!.first;
      }
      salaryController.updateIsErrorOccuredWhileLoadongStaff(false);
      salaryController.updateIsLoadingStaff(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      salaryController.updateIsErrorOccuredWhileLoadongStaff(true);
      salaryController.updateIsLoadingStaff(false);
    }
  }
}
