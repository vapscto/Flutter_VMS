import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_model.dart';

class ViewCircularNoticeApi {
  ViewCircularNoticeApi.init();
  static final ViewCircularNoticeApi instance = ViewCircularNoticeApi.init();

  getCircularNotice({
    required int miId,
    required int userId,
    required int asmayId,
    required String flag,
    required String base,
    required ViewNoticeDataController dataController,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.viewNoticeCircular;
    logger.d(apiUrl);
    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmayId,
      "message": flag,
    });
    if (dataController.isErrorOccuredWhileLoadingCircularContent.value) {
      dataController.updateIsErrorOccuredWhileLoadingCircularContent(false);
    }

    dataController.updateIsLoadingCircularContent(true);
    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmayId,
      "message": flag,
    });
    //logger.d(apiUrl);
    try {
      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "UserId": userId,
          "ASMAY_Id": asmayId,
          "message": flag,
        },
      );

      if (response.data['noticeboard'] == null) {
        dataController.updateIsLoadingCircularContent(false);
        dataController.updateIsErrorOccuredWhileLoadingCircularContent(true);

        return;
        // return Future.error(
        //   {
        //     "errorTitle": "Unable to load notices",
        //     "errorMsg":
        //         "Sorry! but right now, we are unable to show notices because of data is not available.",
        //   },
        // );
      }

      final ViewNoticeModel notices =
          ViewNoticeModel.fromJson(response.data['noticeboard']);

      dataController.updateCircularList(notices.values!);
      dataController.updateIsLoadingCircularContent(false);
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "Something went wrong in server side.. You can try later",
      });
    }
  }
}
