import 'package:logger/logger.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_daily_Day_model.dart';

class GetManagerDailyDayTTApi {
  GetManagerDailyDayTTApi.init();

  static final GetManagerDailyDayTTApi instance =
      GetManagerDailyDayTTApi.init();

  getDailyDayTTApi({
    required int miId,
    required String base,
    required ManagerTimeTableController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerDailyDayTT;

    if (controller.isErrorOccuredWhileLoadingDailyDayTT.value) {
      controller.updateIsErrorOccuredWhileLoadingDailyDayTT(false);
    }

    controller.updateIsLoadingDailyDayTT(true);

    logger.d(api);

    logger.d({
      {
        {"MI_Id": 4, "ASMAY_Id": 24}
      }
    });

    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": controller.selectedStaffList!.asmaYId,
          // "HRME_Id": controller.selectedStaffList!.hrmEId,
          // "TTMD_Id": controller.selectedStaffList!.ttmDId,
          // "type": "daily"
        },
      );

      if (response.data['allperiods'] == null) {
        controller.updateIsErrorOccuredWhileLoadingDailyDayTT(true);
        controller.updateIsLoadingDailyDayTT(false);
        return;
      }

      final ManagerDailyDayModel dayList =
          ManagerDailyDayModel.fromJson(response.data['allperiods']);

      // if (dayList.values!.isNotEmpty) {
      // }

      controller.updateDayList(dayList.values!);
      controller.selectedDayList = dayList.values!.first;
      controller.updateIsLoadingDailyDayTT(false);
      controller.updateIsErrorOccuredWhileLoadingDailyDayTT(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingDailyDayTT(true);
      controller.updateIsLoadingDailyDayTT(false);
    }
  }
}
