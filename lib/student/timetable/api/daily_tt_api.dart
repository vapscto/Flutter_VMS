import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/timetable/model/daywise_tt.dart';

class DailyttApi {
  DailyttApi.init();
  static final DailyttApi instance = DailyttApi.init();

  Future<List<DailyTTModelValues>> loadDailyTT({
    required int miId,
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int amstId,
    required String dayName,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.dailyTT;

    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "AMST_Id": amstId,
        "dayname": dayName,
      });
      logger.d(apiUrl);
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "AMST_Id": amstId,
        "dayname": dayName,
      });
      if (response.data['daywiseTimeTableList'] == null) {
        return Future.error({
          "errorTitle": "Data not mapped",
          "errorMsg":
              "Sorry! but we are unable to show timetable because daywiseTimeTableList array not present"
        });
      }
      final DailyTTModel dailyTTModel =
          DailyTTModel.fromJson(response.data['daywiseTimeTableList']);

      return Future.value(dailyTTModel.values);
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "Sorry! but we are unable to connect to server, or server returned an error"
      });
    }
  }
}
