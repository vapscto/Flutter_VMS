import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_daily_class_section.dart';
// import 'package:m_skool_flutter/staffs/staff_tt/controller/staff_tt_controller.dart';
// import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_classes_model.dart';
// import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';

class ManagerDailyTTApi {
  ManagerDailyTTApi.init();
  static final ManagerDailyTTApi instance = ManagerDailyTTApi.init();

  getDailyTT({
    required int miId,
    required int asmayId,
    required String base,
    required ManagerTimeTableController controller,
    required int ttMiID,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerDailyTT;
    controller.updateIsErrorOccuredWhileLoadingDailyTT(false);
    controller.updateIsLoadingDailyTT(true);

    // logger.d({"MI_Id": miId, "ASMAY_Id": asmayId, "TTMD_Id": ttMiID});

    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "HRME_Id": controller.selectedStaffList!.hrmEId,
          "ASMAY_Id": asmayId,
          "TTMD_Id": controller.selectedDayList!.ttmDId,
          "type": "daily"
        },
      );
      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "HRME_Id": controller.selectedStaffList!.hrmEId,
        "ASMAY_Id": asmayId,
        "TTMD_Id": controller.selectedDayList!.ttmDId,
        "type": "daily"
      });
      if (response.data['class_sectons'] == null) {
        controller.updateIsLoadingDailyTT(false);
        controller.updateIsErrorOccuredWhileLoadingDailyTT(true);
        // controller.updateIsLoadingDailyTT(false);
        return;
      }

      final ManagerDailyClassSectionModel classSection =
          ManagerDailyClassSectionModel.fromJson(
              response.data['class_sectons']);

      controller.updateDailyTT(classSection.values!);
      controller.updateIsLoadingDailyTT(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingDailyTT(true);
      controller.updateIsLoadingDailyTT(false);
    }
  }
}
