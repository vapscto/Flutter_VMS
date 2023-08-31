import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/notice/model/notice_data_model.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';

class GetDateWiseNotice {
  GetDateWiseNotice.init();
  static final GetDateWiseNotice instance = GetDateWiseNotice.init();

  getNotices({
    required int miId,
    required int amstId,
    required int asmayId,
    required String startDate,
    required String endDate,
    required String base,
    required HwCwNbController nbController,
  }) async {
    final Dio dio = getGlobalDio();
    if (nbController.isErrorHappendWhileLoadingNotice.value == true) {
      nbController.updateIsErrorHappendWhileLoadingNotice(false);
    }
    nbController.updateIsNoticeDataLoading(true);

    String apiUrl = base + URLS.noticeDatewise;
    logger.d(apiUrl);
    // logger.d("Notice Reached");
    // logger.d({
    //   "MI_Id": miId.toString(),
    //   "AMST_Id": amstId.toString(),
    //   "ASMAY_Id": asmayId.toString(),
    //   "INTB_StartDate": startDate,
    //   "INTB_EndDate": endDate,
    //   "flag": "O",
    // });
    try {
      Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId.toString(),
        "AMST_Id": amstId.toString(),
        "ASMAY_Id": asmayId.toString(),
        "INTB_StartDate": startDate,
        "INTB_EndDate": endDate,
        "flag": "O",
      });
      final NoticeDataModel noticeDataModel =
          NoticeDataModel.fromJson(response.data['noticelist']);
      nbController.updateNoticeDataModelValues(noticeDataModel.values!);
      nbController.updateIsNoticeDataLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      nbController.updateIsErrorHappendWhileLoadingNotice(true);
      nbController.updateIsNoticeDataLoading(false);
    }
  }
}
