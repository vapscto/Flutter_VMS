import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_period_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_tt_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/weekly_tt_class_section.dart';

class StaffWeeklyTTApi {
  StaffWeeklyTTApi.init();
  static final StaffWeeklyTTApi instance = StaffWeeklyTTApi.init();

  Future<WeeklyTTDataModel> getWeeklyTT({
    required int miId,
    required int asmayId,
    required int userId,
    required String base,
  }) async {
    final String api = base + URLS.getWeeklyTT;
    final Dio ins = getGlobalDio();
    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmayId,
    });

    final DailyTTDaysModel dailyTTDaysModel =
        DailyTTDaysModel.fromJson(response.data['allperiods']);

    final StaffWeeklyTTPeriods staffWeeklyTTPeriods =
        StaffWeeklyTTPeriods.fromJson(response.data['periods']);

    final WeeklyTTClassSectionModel weeklyTTClassSectionModel =
        WeeklyTTClassSectionModel.fromJson(response.data['class_sectons']);

    // final StaffWeeklyTTModel staffWeeklyTTModel = StaffWeeklyTTModel(
    //   classSections: weeklyTTClassSectionModel,
    //   days: dailyTTDaysModel,
    //   periods: staffWeeklyTTPeriods,
    // );

    final List<StaffWeeklyTTModel> tt =
        dailyTTDaysModel.values!.map<StaffWeeklyTTModel>((e) {
      List<WeeklyTTDayWise> dayWise = [];
      for (int i = 0; i < weeklyTTClassSectionModel.values!.length; i++) {
        if (weeklyTTClassSectionModel.values!
                .elementAt(i)
                .pDays!
                .toLowerCase()
                .trim() ==
            e.ttmDDayName!.toLowerCase().trim()) {
          dayWise.add(
            WeeklyTTDayWise(
                className: weeklyTTClassSectionModel.values!
                    .elementAt(i)
                    .asmcLClassName!,
                subjectName: weeklyTTClassSectionModel.values!
                    .elementAt(i)
                    .ismSSubjectName!,
                sectionName: weeklyTTClassSectionModel.values!
                    .elementAt(i)
                    .asmCSectionName!,
                periodName:
                    weeklyTTClassSectionModel.values!.elementAt(i).period!,
                dayName: weeklyTTClassSectionModel.values!.elementAt(i).pDays!),
          );
        }
      }
      return StaffWeeklyTTModel(dayName: e.ttmDDayCode!, classesAt: dayWise);
    }).toList();

    // for(int i =0; i<tt.length;i++){
    //   for(int j = 0;j<tt.elementAt(i).classesAt.length;i++){
    //     if()
    //   }
    // }

    return WeeklyTTDataModel(
        periods: staffWeeklyTTPeriods, days: dailyTTDaysModel, tt: tt);

    //return Future.value(staffWeeklyTTModel);
  }
}
