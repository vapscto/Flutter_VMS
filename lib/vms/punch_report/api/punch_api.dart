import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/vms/punch_report/model/current_punch_details.dart';

class PunchApi {
  PunchApi.init();
  static final PunchApi instance = PunchApi.init();

  pcReports({
    required Map<String, dynamic> body,
    required String base,
    required PunchFilterController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.punchList;
    if (controller.isErrorOccured.value) {
      controller.isErrorOccured.value = false;
    }
    logger.d(apiUrl);

    controller.punchLoading(true);
    try {
      final Response response = await ins.post(apiUrl,
          options: Options(headers: getSession()), data: body);

      if (response.data['punchdetails'] == null) {
        controller.punchLoading(true);
        controller.message.value =
            "Sorry! but we are unable to find any data, it may happens that data list is deleted";
      }

      final CurrentPunchDetailsModel prModel =
          CurrentPunchDetailsModel.fromJson(response.data['punchdetails']);
      logger.d(prModel.toJson());
      controller.punchLoading(false);
      controller.getPunch(prModel.values!);
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
    }
  }
}
