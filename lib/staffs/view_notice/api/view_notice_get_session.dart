import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

class ViewNoticeGetSession {
  ViewNoticeGetSession.init();
  static final ViewNoticeGetSession instance = ViewNoticeGetSession.init();

  getViewNoticeSession({
    required int miId,
    required int asmayId,
    required int amstId,
    required String flag,
    required String base,
    required ViewNoticeDataController dataController,
  }) async {
    final String api = base + URLS.viewNoticeGetSession;
    final Dio ins = getGlobalDio();

    if (dataController.isErrorOccuredWhileLoadingCircular.value) {
      dataController.updateIsErrorOccuredWhileLoadingCircular(false);
    }

    dataController.updateIsCircularPageLoading(true);

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "flag": flag,
      });

      final ViewNoticeSessionModel sessionModel =
          ViewNoticeSessionModel.fromJson(response.data['yearlist']);
      dataController.updateSelectedSession(sessionModel.values!.first);
      dataController.updateCircularSession(sessionModel.values!);
      dataController.updateIsCircularPageLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      dataController.updateIsErrorOccuredWhileLoadingCircular(true);
    }
  }
}
