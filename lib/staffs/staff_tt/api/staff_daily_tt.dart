import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/staff_tt/controller/staff_tt_controller.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_classes_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';

class StaffDailyTTApi {
  StaffDailyTTApi.init();
  static final StaffDailyTTApi instance = StaffDailyTTApi.init();
  getDays({
    required int miId,
    required int asmayId,
    required int userId,
    required String base,
    String? day,
    required StaffTTController controller,
  }) async {
    final String apiUrl = base + URLS.staffDailyTTGetDays;
    final Dio ins = getGlobalDio();
    controller.updateIsErrorOccuredWhileLoadingPage(false);
    controller.updateIsWholePageLoading(true);

    try {
      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "UserId": userId,
          "ASMAY_Id": asmayId,
        },
      );

      if (response.data['allperiods'] == null) {
        controller.updateIsErrorOccuredWhileLoadingPage(true);
        controller.updateErrorOccuredAt("Error Occured while Loading day's");
        return Future.error({
          "errorTitle": "Unable to load time table",
          "errorMsg":
              "We are unable to load your daily timetable, because data are null in db .. If problem persist.. tell your technical team to check allperiods array",
        });
      }

      final DailyTTDaysModel dttDays =
          DailyTTDaysModel.fromJson(response.data['allperiods']);

      if (dttDays.values!.isNotEmpty) {
        if (day == null) {
          controller.updateSelectedDayForDailyTT(dttDays.values!.first);
        } else {
          controller.updateSelectedDayForDailyTT(dttDays.values!.firstWhere(
            (element) => element.ttmDDayName == day,
          ));
          //
        }
      }

      // logger.d(dttDays.toJson());
      controller.updateDailyTTDays(dttDays.values!);
      controller.updateIsWholePageLoading(false);
      //return Future.value(dttDays.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingPage(true);
      controller.updateErrorOccuredAt(
          "We are unable to load your daily timetable, because server returned an error.");
      return Future.error({
        "errorTitle": "Server Returned an error",
        "errorMsg":
            "We are unable to load your daily timetable, because server returned an error.",
      });
    }
  }

  getDailyTT({
    required int miId,
    required int asmayId,
    required int userId,
    required String base,
    required StaffTTController controller,
    required int ttMiID,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getStaffDailyTT;
    controller.updateLoadingStatus(
        "Loading ${controller.selectedDayForDailyTT.value.ttmDDayName} Timetable");
    controller.updateIsErrorOcurredAtLoadingTT(false);
    controller.updateIsTTLoading(true);

    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmayId,
      "TTMD_Id": ttMiID
    });

    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "UserId": userId,
          "ASMAY_Id": asmayId,
          "TTMD_Id": ttMiID,
        },
      );
      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "UserId": userId,
        "ASMAY_Id": asmayId,
        "TTMD_Id": ttMiID,
      });
      if (response.data['class_sectons'] == null) {
        controller.updateLoadingStatus("Error Occured");
        controller.updateIsErrorOcurredAtLoadingTT(true);
        controller.updateIsTTLoading(false);
        controller.updateErrorOccuredAt(
            "Error Occured while loading timetable, try with another day");
        return;
      }

      final DailyTTClassesModel dailyTT =
          DailyTTClassesModel.fromJson(response.data['class_sectons']);

      controller.updateDailyTT(dailyTT.values!);
      controller.updateIsTTLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateErrorOccuredAt(
          "While Loading timetable we encountered an error");
      controller.updateIsErrorOcurredAtLoadingTT(true);
      controller.updateIsTTLoading(false);
    }
  }
}
