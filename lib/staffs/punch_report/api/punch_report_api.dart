import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/staffs/punch_report/model/punch_report_model.dart';

class PunchReportApi {
  PunchReportApi.init();
  static final PunchReportApi instance = PunchReportApi.init();

  pcReports({
    required int miId,
    required int userId,
    required String fromDate,
    required String endDate,
    required String base,
    required PunchFilterController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.punchReport;
    if (controller.isErrorOccured.value) {
      controller.isErrorOccured.value = false;
    }
    logger.d(apiUrl);
    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "fromdate": fromDate,
      "todate": endDate
    });
    controller.updateStartFilteration(true);
    try {
      final Response response = await ins.post(apiUrl,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "UserId": userId,
            "fromdate": fromDate,
            "todate": endDate
          });

      if (response.data['emp_punchDetails'] == null) {
        controller.updateIsErrorOccured(true);
        controller.message.value =
            "Sorry! but we are unable to find any data, it may happens that data list is deleted";
        controller.updateStartFilteration(false);
        // return Future.error({
        //   "errorTitle": "Data Unavailable",
        //   "errorMsg":
        //       ,
        // });
      }

      final PunchReportModel prModel =
          PunchReportModel.fromJson(response.data['emp_punchDetails']);
      logger.d(prModel.toJson());
      controller.updateIsErrorOccured(false);
      controller.updatePunchReports(prModel.values!);
      controller.updateStartFilteration(false);
    } on DioError catch (e) {
      logger.e(e.message);
      controller.message.value = e.message;
      return Future.error(
        {
          "errorTitle": "Unexpected Error Occured",
          "errorMsg": e.message,
        },
      );
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.message.value =
          "While Creating your view, we encountered an error.. Try again later";
      // return Future.error({
      //   "errorTitle": "An Internal Error Occured",
      //   "errorMsg":
      //       "",
      // });
    }
  }
}
