import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_slip_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';

class EmployeeSalarySlipApi {
  EmployeeSalarySlipApi.init();
  static final EmployeeSalarySlipApi instance = EmployeeSalarySlipApi.init();

  Future<List<EmployeeSalarySlipValues>> getSalary({
    required int miId,
    required int asmayId,
    required String base,
    required int hrmeId,
    required DateTime fromdate,
    required DateTime todate,
    required EmployeePunchController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/EmployeeLateInEarlyOutReportFacade/getrpt/";

      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "fromdate": fromdate.toString(),
        "todate": todate.toString(),
        "multiplehrmeid": hrmeId,
        "punchtype": "punch"
      });

      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "fromdate": fromdate.toString(),
        "todate": todate.toString(),
        "multiplehrmeid": hrmeId,
        "punchtype": "punch"
      });

      if (response.data['filldata'] == null) {
        return Future.error({
          "errorTitle": "No Data found",
          "errorMsg": "We are unable to get filldata"
        });
      }
      final EmployeeSalarySlipModel employees =
          EmployeeSalarySlipModel.fromJson(response.data['filldata']);

      salaryController.updateSalarySlip(employees.values!);
      return Future.value(employees.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server error Occured",
        "errorMsg": "We are unable to get filldata"
      });
    }
  }
}
