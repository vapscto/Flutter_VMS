import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/notice_student_data_model.dart';

class NoticeGetStudent {
  NoticeGetStudent.init();
  static final NoticeGetStudent instance = NoticeGetStudent.init();

  getStudents({
    required int asmayId,
    required int userId,
    required int ivrmrtId,
    required int miId,
    required List<Map<String, dynamic>> sectionListArray,
    required List<Map<String, dynamic>> classlsttwo,
    required String base,
    required NoticeBoardController noticeBoardController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getNoticeStudent;

    if (noticeBoardController.isErrorOccuredWhileLoadingStudent.value) {
      noticeBoardController.updateIsErrorOccuredWhileLoadingStudent(false);
    }

    noticeBoardController.updateIsStudentLoading(true);
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "sectionlistarray": sectionListArray,
        "classlsttwo": classlsttwo,
        "defarray": null
      });
      logger.d(api);
      logger.d({
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "sectionlistarray": sectionListArray,
        "classlsttwo": classlsttwo,
        "defarray": null
      });
      final NoticeStudentDetailsModel detailsModel =
          NoticeStudentDetailsModel.fromJson(response.data['studentlist']);

      noticeBoardController.updateStudents(detailsModel.values!);
      noticeBoardController.updateIsStudentLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      noticeBoardController.updateIsErrorOccuredWhileLoadingStudent(true);
      noticeBoardController.updateViewWorkLoadingStatus(e.message);
      noticeBoardController.updateIsStudentLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingStudent(true);
      noticeBoardController.updateViewWorkLoadingStatus(
          "An internal error occured while creating view for you");
      noticeBoardController.updateIsStudentLoading(false);
    }
  }
}
