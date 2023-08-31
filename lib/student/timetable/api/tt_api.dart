import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/timetable/model/daywise_tt.dart';
import 'package:m_skool_flutter/student/timetable/model/grid_week_model.dart';
import 'package:m_skool_flutter/student/timetable/model/periods_lst_model.dart';
import 'package:m_skool_flutter/student/timetable/model/time_table_load_data_model.dart';
import 'package:m_skool_flutter/student/timetable/model/tt.dart';
import 'package:m_skool_flutter/student/timetable/model/tt_model.dart';

class TTApi {
  TTApi.init();
  static final TTApi instance = TTApi.init();

  Future<TT> getTimeTable({
    required int miId,
    required int asmayId,
    required int asmtId,
    required String base,
    // required CreatePdfController pdfTT,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.tt;
      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "AMST_Id": asmtId,
        "ASMAY_Id": asmayId,
      });
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "AMST_Id": asmtId,
        "ASMAY_Id": asmayId,
      });
      if (response.statusCode == 200) {
        //logger.d(response.data);
        // StudentTimeTableModel studentTimeTable =
        //     StudentTimeTableModel.fromJson(response.data);
        // return studentTimeTable;
        if (response.data['tt'] == null) {
          return Future.error({
            "errorTitle": "Data Not Present",
            "errorMsg":
                "We are unable to show timetable because TT array not present in db, ask your technical team to add.",
          });
        }
        if (response.data['gridweeks'] == null) {
          return Future.error({
            "errorTitle": "Data Not Present",
            "errorMsg":
                "We are unable to show timetable because gridweek array not present in db, ask your technical team to add.",
          });
        }
        if (response.data['periodslst'] == null) {
          return Future.error({
            "errorTitle": "Data Not Present",
            "errorMsg":
                "We are unable to show timetable because periodslst array not present in db, ask your technical team to add.",
          });
        }
        final TTModel ttModel = TTModel.fromJson(response.data['tt']);
        final GridWeekModel gridWeek =
            GridWeekModel.fromJson(response.data['gridweeks']);
        final PeriodsListModel periodsListModel =
            PeriodsListModel.fromJson(response.data['periodslst']);

        // List<List<String>> ttDay = [];
        // for (int i = 0; i < gridWeek.values!.length; i++) {
        //   String dayName = gridWeek.values!.elementAt(i).ttmDDayName!;
        //   List<String> dd = [];
        //   for (int j = 0; j < ttModel.values!.length; i++) {
        //     if (dayName.toLowerCase().trim() ==
        //         ttModel.values!
        //             .elementAt(j)
        //             .ttmDDayName!
        //             .toLowerCase()
        //             .trim()) {
        //       dd.add(
        //           "${ttModel.values!.elementAt(j).ismSSubjectName}\n${ttModel.values!.elementAt(j).staffName}");
        //     }
        //   }
        //   ttDay.add(dd);
        // }

        // logger.d(ttDay);

        List<DayWisett> dayWiseTT = [];

        for (int i = 0; i < gridWeek.values!.length; i++) {
          final String dayName = gridWeek.values!.elementAt(i).ttmDDayName!;

          List<DayWisettValue> dayWiseVal = [];

          for (int j = 0; j < ttModel.values!.length; j++) {
            if (dayName.trim().toLowerCase() ==
                ttModel.values!
                    .elementAt(j)
                    .ttmDDayName!
                    .trim()
                    .toLowerCase()) {
              dayWiseVal.add(DayWisettValue(
                  subjectName: ttModel.values!.elementAt(j).ismSSubjectName!,
                  teacher: "",
                  period:
                      int.parse(ttModel.values!.elementAt(j).ttmPPeriodName!)));
            }
          }
          dayWiseVal.sort(
              (a, b) => a.period.toString().compareTo(b.period.toString()));
          dayWiseTT.add(DayWisett(
              dayName: gridWeek.values!.elementAt(i).ttmDDayCode!,
              value: dayWiseVal));
        }

        if (dayWiseTT.last.value.length != periodsListModel.values!.length) {
          for (int i = 0;
              i <
                  (periodsListModel.values!.length -
                          dayWiseTT.last.value.length) +
                      1;
              i++) {
            dayWiseTT.last.value
                .add(DayWisettValue(subjectName: "", teacher: "", period: 0));
          }
        }

        // logger.d(dayWiseTT);
        // Isolate.spawn((message) {
        //   List<List<PdfTTModel>> ttr = [];
        //   for (int i = 0; i < periodsListModel.values!.length; i++) {
        //     String code =
        //         periodsListModel.values!.elementAt(i).ttmPPeriodName!.trim();

        //     List<String> str = [];

        //     for (int j = 0; j < ttModel.values!.length; i++) {
        //       if (code == ttModel.values!.elementAt(j).ttmPPeriodName!.trim()) {
        //         logger.d(
        //             "${ttModel.values!.elementAt(j).ismSSubjectName!}\n${ttModel.values!.elementAt(j).staffName}");
        //         str.add(
        //             "${ttModel.values!.elementAt(j).ismSSubjectName!}\n${ttModel.values!.elementAt(j).staffName}");
        //       }
        //     }
        //     //ttr.add(str);
        //   }
        //   pdfTT.updateTTSub(ttr);
        // }, "message");
        final TT tt = TT(
          tt: ttModel,
          gridWeeks: gridWeek,
          periodsList: periodsListModel,
          dayWise: dayWiseTT,
        );

        return tt;
      } else {
        Fluttertoast.showToast(msg: 'Unable to fetch data');
        return Future.error({
          "errorTitle": "Server Not Working",
          "errorMsg": "Incorrect response from the server, Try again later",
        });
      }
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server Not Working",
        "errorMsg":
            "We are unable to connect to server right now, Try again later",
      });
    }
  }

  Future<TimeTableLoadDataModel?> getTimeTableLoadData({
    required int miId,
    required int asmtId,
    required String base,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.getloaddata;
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "AMST_Id": asmtId,
      });
      if (response.statusCode == 200) {
        logger.d(response.data);
        TimeTableLoadDataModel timeTableLoadResult =
            TimeTableLoadDataModel.fromJson(response.data);
        return timeTableLoadResult;
      } else {
        Fluttertoast.showToast(msg: 'Unable to fetch data');
        return null;
      }
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
