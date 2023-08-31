import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/academic_history_model.dart';

class GetAcademicHistoryApi {
  GetAcademicHistoryApi.init();
  static final GetAcademicHistoryApi instance = GetAcademicHistoryApi.init();
  getHistory({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
    required ViewStudentDetailsController controller,
  }) async {
    final Dio ins = getGlobalDio();
    String apiUrl = base + URLS.getAcademicHistory;
    if (controller.isErrorOccuredInHistory.value) {
      controller.updateIsErrorOccured(false);
    }
    controller.updateIsHistoryLoading(true);
    controller.updateHistoryStatus("Loading your academic History....");
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "AMST_Id": amstId,
        "ASMAY_Id": asmayId,
      });

      if (response.data['viewstudentfeedetails'] == null) {
        controller.updateIsErrorOccuredInHistory(true);
        controller.updateIsHistoryLoading(false);
        controller.updateStatus(
            "There is no details available... array is not available");
        return;
      }

      final AcademicHistory history =
          AcademicHistory.fromJson(response.data['viewstudentfeedetails']);

      controller.updateAcademicHistoryModel(history.values!);
      controller.updateIsHistoryLoading(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccuredInHistory(true);
      controller.updateIsHistoryLoading(false);
      controller.updateStatus(e.message);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredInHistory(true);
      controller.updateIsHistoryLoading(false);
      controller.updateStatus(
          "An internal error Occured while trying to create a view for you");
      return;
    }
  }
}
