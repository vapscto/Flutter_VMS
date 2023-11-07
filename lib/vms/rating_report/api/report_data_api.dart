import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/rating_report/controller/rating_report_controller.dart';
import 'package:m_skool_flutter/vms/rating_report/model/report_data_model.dart';

Future<void> getReportData(
    {required String base,
    required int mIId,
    required int userId,
    required String flag,
    required String year,
    required List<Map<String, dynamic>> monthList,
    required RatingReportController controller}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.dataReport;

  try {
    logger.d(api);

    logger.d({
      "MI_Id": mIId,
      "UserId": userId,
      "flag": "monthyearwise",
      "year": year,
      "monthList": monthList
    });

    controller.updateisLoadingRatingReportData(true);

    final response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": mIId,
      "UserId": userId,
      "flag": "monthyearwise",
      "year": year,
      "monthList": monthList
    });

    // logger.d(response.data['consolidateData']);

    if (response.data['consolidateData'] == null) {
      controller.updateErrorLoadingRatingReportData(true);
    } else if (response.data['consolidateData'] != null) {
      controller.updateErrorLoadingRatingReportData(false);
      controller.updateisLoadingRatingReportData(false);
      ReportDataModel ratingReportDataListResponse =
          ReportDataModel.fromJson(response.data['consolidateData']);
      controller.ratingReportData.addAll(ratingReportDataListResponse.values!);
    }
  } on Exception catch (e) {
    logger.printError();
  }
}
