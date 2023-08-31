import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/controller/class_teacher_controller.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/model/teacher_report_yearlist_model.dart';

class GetTeacherYearListApi {
  GetTeacherYearListApi.init();
  static final GetTeacherYearListApi instance = GetTeacherYearListApi.init();

  getYearList({
    required int mIID,
    required int asmayId,
    required String base,
    required ClassTeacherController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.teacherReportYearList;
    logger.d(apiUrl);
    logger.d({
      "MI_Id": mIID,
      "ASMAY_Id": asmayId,
    });
    if (controller.isErrorOccuredWhileLoadingYearList.value) {
      controller.updateIsErrorOccuredWhileLoadingYearList(false);
    }

    try {
      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": mIID,
          "ASMAY_Id": asmayId,
        },
      );

      logger.d(response.data['getyear']);

      if (response.data['getyear'] == null) {
        controller.updateIsLoadingYearList(false);
        controller.updateIsErrorOccuredWhileLoadingYearList(true);

        return;
      }

      final YearListModel yearList =
          YearListModel.fromJson(response.data['getyear']);
      controller.yearList.addAll(yearList.values!);
      controller.updateYearList(yearList.values!);
      controller.updateIsLoadingYearList(false);
    } on Exception catch (e) {
      // logger.e(e.toString());
    }
  }
}
