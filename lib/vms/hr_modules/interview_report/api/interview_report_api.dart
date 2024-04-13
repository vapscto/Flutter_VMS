import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/controller/int_report_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/model/completed_intvw_model.dart';

class InterviewReportAPI {
  InterviewReportAPI.init();
  static final InterviewReportAPI instance = InterviewReportAPI.init();
  getList({
    required String base,
    required Map<String, dynamic> body,
    required String status,
    required IntviewGridController controller,
  }) async {
    var dio = Dio();
    var api = base;
    controller.loading(true);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['completedintvw'] != null) {
          CompletedIntvwModel completedIntvwModel =
              CompletedIntvwModel.fromJson(response.data['completedintvw']);
          controller.completedList.clear();
          controller.completedList.addAll(completedIntvwModel.values!);
        } else if (response.data['upcomingintvw'] != null) {
          CompletedIntvwModel completedIntvwModel =
              CompletedIntvwModel.fromJson(response.data['upcomingintvw']);
          controller.upComingList.clear();
          controller.upComingList.addAll(completedIntvwModel.values!);
        } else if (response.data['inprogressintvw'] != null) {
          CompletedIntvwModel completedIntvwModel =
              CompletedIntvwModel.fromJson(response.data['inprogressintvw']);
          controller.inProgressList.clear();
          controller.inProgressList.addAll(completedIntvwModel.values!);
        }
        controller.loading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
