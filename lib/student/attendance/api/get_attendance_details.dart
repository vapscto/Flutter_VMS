import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/attendance/controller/attendance_handler.dart';
import 'package:m_skool_flutter/student/attendance/model/attendance_detail_model.dart';

class GetAttendanceDetails {
  GetAttendanceDetails.init();
  static final GetAttendanceDetails instance = GetAttendanceDetails.init();

  getAttendance(
      {required int miId,
      required int asmayId,
      required int amstId,
      required String base,
      required AttendanceHandler handler}) async {
    final Dio dio = getGlobalDio();
    String apiUrl = base + URLS.getAttendanceDetails;

    try {
      Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "mI_ID": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
      });
      final AttendanceDetailModel attendanceDetailModel =
          AttendanceDetailModel.fromJson(response.data['attList']);

      handler.updateAttendanceData(attendanceDetailModel.values!);
      logger.d(attendanceDetailModel.toJson());
      handler.updateIsLoadingAttendanceDetails(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server.",
        "errorMsg":
            "We are unable to process your request right now, try again later"
      });
    }
  }
}
