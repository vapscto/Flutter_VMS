import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/salary_deduction_mode.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/salary_earning_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/split_salary_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/total_deduction_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/total_earning_model.dart';

class SalaryBreakApi {
  SalaryBreakApi.init();
  static final SalaryBreakApi instance = SalaryBreakApi.init();

  Future<SplitSalaryModel> getSalaryDivision({
    required int miId,
    required int userId,
    required int hresId,
    required String base,
  }) async {
    final String apiUrl = base + URLS.getSalaryBreak;
    final Dio ins = getGlobalDio();
    try {
      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId, "HRES_Id": hresId},
      );

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
