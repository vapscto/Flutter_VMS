import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/salary_slip/model/salaryslipdetailmodel.dart';
import 'package:m_skool_flutter/vms/salary_slip/model/yearandmonthdropdown.dart';

var dio = Dio();
Future<YearAndMonthDropdownModel?> getYearandMonth({
  required int miId,
  required int userId,
  required String base,
}) async {
  var url = base + URLS.getYearandMonth;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "LogInUserId": userId,
      },
    );
    if (response.statusCode == 200) {
      YearAndMonthDropdownModel yearAndMonthDropdownModel =
          YearAndMonthDropdownModel.fromJson(response.data);
      return yearAndMonthDropdownModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<SalarySlipDetailModel?> getSalaryDetail({
  required int miId,
  required int userId,
  required String hresYear,
  required String hresMonth,
  required String base,
}) async {
  var url = base + URLS.getSalarySlipDetails;

  logger.d(url);
  logger.d({
    "HRES_Month": hresMonth,
    "HRES_Year": hresYear,
    "MI_Id": miId,
    "LogInUserId": userId,
  });
  try {
    var response = await dio.post(url,
        options: Options(
          headers: getSession(),
        ),
        data: {
          "HRES_Month": hresMonth,
          "HRES_Year": hresYear,
          "MI_Id": miId,
          "LogInUserId": userId,
        });

    if (response.statusCode == 200) {
      SalarySlipDetailModel salarySlipDetailModel =
          SalarySlipDetailModel.fromJson(response.data);
      return salarySlipDetailModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
