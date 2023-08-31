import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_weekly_gridweeks_model.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_weekly_periodlist_model.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_weekly_tt_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_tt_model.dart';

class GetManagerWeeklyTTApi {
  GetManagerWeeklyTTApi.init();

  static final GetManagerWeeklyTTApi instance = GetManagerWeeklyTTApi.init();

  getWeeklyTTApi(
      {required int miId,
      required int hrmEId,
      required String base,
      required int asmaYId,
      required ManagerTimeTableController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerWeeklyTT;

    if (controller.isErrorOccuredWhileLoadingWeeklyTT.value) {
      controller.updateIsErrorOccuredWhileLoadingWeeklyTT(false);
    }

    controller.updateIsLoadingWeeklyTT(true);

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmaYId,
        "HRME_Id": controller.selectedStaffList!.hrmEId,
        "type": "weekly"
      });

      logger.d(api);

      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmaYId,
        "HRME_Id": controller.selectedStaffList!.hrmEId,
        "type": "weekly"
      });

      final ManagerWeeklyPeriodlistModel dailyTTDaysModel =
          ManagerWeeklyPeriodlistModel.fromJson(
              response.data['periodslst']); //periods ref from staff

      final ManagerWeeklyGridWeeksModel staffWeeklyTTPeriods =
          ManagerWeeklyGridWeeksModel.fromJson(
              response.data['gridweeks']); // class_sectons

      List<dynamic> weekly = response.data['tt']; // allperiods
      List<Tt> ttList = [];
      for (int i = 0; i < weekly.length; i++) {
        ttList.add(Tt.fromJson(weekly.elementAt(i)));
      }
// for() {

// }
      final List<StaffWeeklyTTModel> tt = ttList.map<StaffWeeklyTTModel>((e) {
        List<WeeklyTTDayWise> dayWise = [];
        for (int i = 0; i < staffWeeklyTTPeriods.values!.length; i++) {
          logger.d(staffWeeklyTTPeriods.values!
              .elementAt(i)
              .ttmDDayName!
              .toLowerCase()
              .trim());
          logger.d(e.ttmDDayName!.toLowerCase().trim());
          if (staffWeeklyTTPeriods.values!
                  .elementAt(i)
                  .ttmDDayName!
                  .toLowerCase()
                  .trim() ==
              e.ttmDDayName!.toLowerCase().trim()) {
            dayWise.add(
              WeeklyTTDayWise(
                   className: e.asmcLClassName!,
                  subjectName: e.ismSSubjectName!,
                  periodName: e.ttmPPeriodName!,
                  sectionName: e.asmCSectionName!,
                  dayName: e.ttmDDayName!),
            );
          }
        }

        return StaffWeeklyTTModel(dayName: e.ttmDDayName!, classesAt: dayWise);
      }).toList();

      // Logger.d({
      //   "MI_Id": miId,
      //   "ASMAY_Id": controller.selectedStaffList!.asmaYId,
      //   "HRME_Id": controller.selectedStaffList!.hrmEId,
      //   "type": "weekly"
      // });

      // final ManagerTimeTableStaffList staffList =
      //     ManagerTimeTableStaffList.fromJson(response.data['stafflist']);

      // controller.updatestaffList(staffList.values!);
      for (int i = 0; i < tt.length; i++) {
        logger.d(tt.elementAt(i).toJson());
      }

      final WeeklyTTData data = WeeklyTTData(
          periods: dailyTTDaysModel, days: staffWeeklyTTPeriods, tt: tt);
// final WeeklyTTData data = WeeklyTTData(
//            periods: StaffWeeklyTTModel, days: staffWeeklyTTPeriods, tt: tt);

      controller.updateWeeklyTT(data);

      controller.updateIsLoadingWeeklyTT(false);
      controller.updateIsErrorOccuredWhileLoadingWeeklyTT(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingWeeklyTT(true);
      controller.updateIsLoadingWeeklyTT(false);
    }
  }
}
