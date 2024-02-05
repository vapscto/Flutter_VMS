import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/rating_report/controller/rating_report_controller.dart';
import 'package:m_skool_flutter/vms/rating_report/model/month_rating_report_model.dart';
import 'package:m_skool_flutter/vms/rating_report/model/year_list_rating_model.dart';

Future<void> getYearListRatingReport(
    {required String base,
    required int mIId,
    required int userId,
    required String roleFlag,
    required int ivrmRtId,
    required RatingReportController controller}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.yearListRatingReport;

  try {
    logger.d(api);

    logger.d({
      "MI_Id": mIId,
      "Userid": userId,
      "Role_flag": roleFlag,
      "IVRMRT_Id": ivrmRtId
    });

    controller.updateisLoadingOnloadYearList(true);

    final response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": mIId,
          "Userid": userId,
          "Role_flag": roleFlag,
          "IVRMRT_Id": ivrmRtId
        });

    // logger.d(response.data['yearlist']);
    if (response.data['yearlist'] == null) {
      controller.updateErrorLoadingOnloadYearList(true);
    } else if (response.data['yearlist'] != null) {
      controller.updateErrorLoadingOnloadYearList(false);
      controller.updateisLoadingOnloadYearList(false);
      YearListRatingReportModel yearListListResponse =
          YearListRatingReportModel.fromJson(response.data['yearlist']);
      controller.yearList.addAll(yearListListResponse.values!);
    }

    controller.updateisLoadingMonth(true);

    final responseMonth = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": mIId,
          "Userid": userId,
          "Role_flag": roleFlag,
          "IVRMRT_Id": ivrmRtId
        });

    // logger.d(response.data['month_array']);
    if (response.data['month_array'] == null) {
      controller.updateErrorLoadingMonth(true);
    } else if (response.data['month_array'] != null) {
      controller.updateErrorLoadingMonth(false);
      controller.updateisLoadingMonth(false);
      MonthRatingReportModel monthListResponse =
          MonthRatingReportModel.fromJson(response.data['month_array']);
      controller.monthList.addAll(monthListResponse.values!);
      for (int i = 0; i < monthListResponse.values!.length; i++) {
        controller.checkListBoxs.add(false);
      }
    }
  } on Exception catch (e) {
    logger.e(e.toString());
    logger.printError();
  }
}
