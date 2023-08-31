import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_salary/api/employee_slip_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/salary_deduction_mode.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/salary_earning_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/split_salary_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/total_deduction_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/total_earning_model.dart';


class EmployeeSalarySlipApi {
  EmployeeSalarySlipApi.init();
  static final EmployeeSalarySlipApi instance = EmployeeSalarySlipApi.init();

  Future<SplitSalaryModel> getSalary({
    required int miId,
    required int asmayId,
    required String base,
    required int hrmeId,
    required String year,
    required String month,
    required EmployeeSalaryController salaryController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/EmployeeSalaryDetailsFacade/getsalaryalldetails/";

      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "hreS_Year": year,
        "hreS_Month": month.trim(),
        "hrmE_Id": hrmeId,
        "MI_Id": miId,
         "HRES_Id": 0,
        //"ASMAY_Id": asmayId,
       // "serchtype": "2"
      });
      logger.d({
         "hreS_Year": year,
        "hreS_Month": month.trim(),
        "hrmE_Id": hrmeId,
        "MI_Id": miId,
         "HRES_Id": 0,
      });
      logger.d(response.data);
      final TotalEarningModel totalEarning =
          TotalEarningModel.fromJson(response.data['totalEarning']);

      final TotalDeductionModel deductionModel =
          TotalDeductionModel.fromJson(response.data['totalDeduction']);

      final SalaryDeductionModel salaryDeductionModel =
          SalaryDeductionModel.fromJson(response.data['salarylistD']);

      final SalaryEarningModel salaryEarningModel =
          SalaryEarningModel.fromJson(response.data['salarylistE']);

      final SplitSalaryModel splitSalaryModel = SplitSalaryModel(
        totalEarningModel: totalEarning,
        totalDeductionModel: deductionModel,
        salaryDeductionModel: salaryDeductionModel,
        salaryEarningModel: salaryEarningModel,
      );

      
      return Future.value(splitSalaryModel);
    } on DioError catch (e) {
      logger.e(e.toString());

      return Future.error({
        "errorTitle": "Server Error Occured",
        "errorMsg":
            "After a successfully connection to the server.. Server returned an error.",
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "An Unexpected Error Occured",
        "errorMsg":
            "Right Now, we are unable to process the request because of an internal error",
      });
    }
  }
}
