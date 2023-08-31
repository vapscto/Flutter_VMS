import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/designation_model.dart';

class NoticeBoardGetDesignation {
  NoticeBoardGetDesignation.init();
  static NoticeBoardGetDesignation instance = NoticeBoardGetDesignation.init();

  getDesignation({
    required int miId,
    required int asmayId,
    required int userId,
    required int ivrmrtId,
    required List<Map<String, dynamic>> departmentList,
    required String base,
    required NoticeBoardController noticeBoardController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getDesignation;

    if (noticeBoardController.isErrorOccuredWhileLoadingDesignation.value) {
      noticeBoardController.updateIsErrorOccuredWhileLoadingDesignation(false);
    }

    noticeBoardController.updateIsDesignationLoading(true);
    // logger.d({
    //   "ASMAY_Id": asmayId,
    //   "UserId": userId,
    //   "IVRMRT_Id": ivrmrtId,
    //   "MI_Id": miId,
    //   "departmentlist": departmentList,
    // });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "departmentlist": departmentList,
      });

      logger.d(api);
      logger.d(response.data);

      if (response.data['designation'] == null) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingDesignation(true);
        noticeBoardController.updateIsDesignationLoading(false);
        return;
      }

      final DesignationDataModel designationDataModel =
          DesignationDataModel.fromJson(response.data['designation']);

      if (designationDataModel.values!.isNotEmpty) {
        noticeBoardController
            .addToSelectedDesignation(designationDataModel.values!.first);
      }

      noticeBoardController.updateDesignation(designationDataModel.values!);
      noticeBoardController.updateIsDesignationLoading(false);
    } on DioError catch (e) {
      logger.e(e.message, e.stackTrace);
      noticeBoardController.updateIsErrorOccuredWhileLoadingDesignation(true);
      noticeBoardController.updateIsDesignationLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingDesignation(true);
      noticeBoardController.updateIsDesignationLoading(false);
    }
  }
}
