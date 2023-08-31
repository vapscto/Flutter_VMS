import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

class HwCwGetAcademicYear {
  HwCwGetAcademicYear.init();
  static final HwCwGetAcademicYear instance = HwCwGetAcademicYear.init();

  Future<void> getAcademicYear({
    required int miId,
    required int userId,
    required int loginId,
    required int ivrmrtId,
    required int asmayId,
    required int hrmeId,
    required String base,
    required HwCwController hwCwController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String apiUrl = base + URLS.getHwYear;

      if (hwCwController.isErrorOccuredLoadingAcademicYear.value) {
        hwCwController.updateIsErrorOccuredLoadingAcademicYear(false);
      }
      hwCwController.updateLoadingStatus(
          "We are loading Academic Year for you, your view will appear here.");
      hwCwController.updateIsAcademicYearLoading(true);

      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "userId": userId,
        "login_Id": userId,
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
        "HRME_Id": hrmeId,
      });

      if (response.data['yearlist'] == null) {
        hwCwController.updateIsAcademicYearLoading(false);
        hwCwController.updateErrorStatus(
            "No Academic year available in record, Contact your technical team for assitance");
        hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
        return;
      }
      final ViewNoticeSessionModel sessionModel =
          ViewNoticeSessionModel.fromJson(response.data['yearlist']);
      if (sessionModel.values!.isNotEmpty) {
        hwCwController.updateSelectedSession(sessionModel.values!.first);
      }
      hwCwController.updateSession(sessionModel.values!);
      hwCwController.updateIsAcademicYearLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      hwCwController.updateIsAcademicYearLoading(false);
      hwCwController.updateErrorStatus(e.message);
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      hwCwController.updateIsAcademicYearLoading(false);
      hwCwController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    }
  }
}
