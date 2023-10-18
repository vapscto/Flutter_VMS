import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/employee_details.dart';

class EmployeePunchDetailsApi {
  EmployeePunchDetailsApi.init();
  static final EmployeePunchDetailsApi instance =
      EmployeePunchDetailsApi.init();

  getDetails({
    required int miId,
    required int asmayId,
    required String base,
    required int hrmeId,
    required DateTime fromdate,
    required DateTime todate,
    required EmployeePunchController salaryController,
  }) async {
    try {
      salaryController.loading(true);
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
      if (response.statusCode == 200) {
        EmployeePunchDetailsModel employeePunchDetailsModel =
            EmployeePunchDetailsModel.fromJson(response.data['filldata']);
        salaryController.getList(employeePunchDetailsModel.values!);
        salaryController.loading(false);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server error Occured",
        "errorMsg": "We are unable to get filldata"
      });
    }
  }
}
