import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/attendance/controller/attendance_handler.dart';
import 'package:m_skool_flutter/student/attendance/model/academic_year_model.dart';

class GetAttendanceAcademicYear {
  GetAttendanceAcademicYear.init();
  static final GetAttendanceAcademicYear instance =
      GetAttendanceAcademicYear.init();

  Future<List<AttyearlistValues>> getAcademicYear({
    required int miId,
    required int amstId,
    required String base,
    required AttendanceHandler handler,
  }) async {
    handler.updateErrorHappend(false);
    handler.updateIsLoadingWholeScreen(true);
    final Dio ins = getGlobalDio();
    String getAcadmeicApiUrl = base + URLS.getAttAcademicYear;

    try {
      Response response = await ins.post(
        getAcadmeicApiUrl,
        options: Options(headers: getSession()),
        data: {
          "mI_ID": miId,
          "AMST_Id": amstId,
        },
      );

      //logger.d(response.data);

      AcademicYearModel academicYearModel =
          AcademicYearModel.fromJson(response.data);

      handler.updateAcademicYearList(academicYearModel.attyearlist!.values!);
      handler.updateSelectedInDropDown(
          academicYearModel.attyearlist!.values!.first);
      handler
          .updateAsmayId(academicYearModel.attyearlist!.values!.first.asmaYId!);
      handler.updateIsLoadingWholeScreen(false);
      handler.updateIsLoadingAttendanceDetails(true);
      return Future.value(academicYearModel.attyearlist!.values!);
    } on Exception catch (e) {
      logger.e(e);
      handler.updateErrorHappend(true);
      return Future.error(
        {
          "errorTitle": "Unable to connect to server",
          "errorMsg": "Sorry! we are unable to connect you to server",
        },
      );
    }
    //logger.d(academicYearModel.toJson());
  }
}
