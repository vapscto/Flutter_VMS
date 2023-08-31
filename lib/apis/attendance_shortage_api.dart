import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/attendance_shortage_model.dart';
import 'package:m_skool_flutter/widget/attendance_shortage_widget.dart';

class AttendanceShortageApi {
  AttendanceShortageApi.init();
  static final AttendanceShortageApi instance = AttendanceShortageApi.init();

  getShortage({
    required int asmayId,
    required int miId,
    required int amstId,
    required int percentage,
    required String base,
    required BuildContext context,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.attendanceShortage;

    logger.d(api);

    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "ASMAY_Id": asmayId,
            "MI_Id": miId,
            "AMST_Id": amstId,
            "percentage": percentage
          });

      if (response.data['studentAttendanceList'] != null) {
        final AttendanceShortageModel attendanceShortageModel =
            AttendanceShortageModel.fromJson(
                response.data['studentAttendanceList']);
        if (attendanceShortageModel.values != null &&
            attendanceShortageModel.values!.isNotEmpty) {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  insetPadding: const EdgeInsets.all(16.0),
                  child: AttendanceShortage(
                    percentage: attendanceShortageModel.values!.first.per!,
                  ),
                );
              });
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return;
    }
  }
}
