import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';

import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/feedback/model/feedback_details_model.dart';
import 'package:m_skool_flutter/student/feedback/model/get_feed_model.dart';

class GetFeedBackApi {
  GetFeedBackApi.init();
  static final GetFeedBackApi instance = GetFeedBackApi.init();
  Future<FeedBacksModel> getStuFeedBack({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String getFeedBackApiUrl = base + URLS.getFeedBack;
    try {
      Response response = await ins.post(
        getFeedBackApiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
          "AMST_Id": amstId,
        },
      );

      final FeedbackDetailsModel feedbackDetailsModel =
          FeedbackDetailsModel.fromJson(response.data);
      // logger.d(response.data['get_feedback']);
      // logger.d(feedbackDetailsModel.instname!.toJson());
      // logger.d(feedbackDetailsModel.getFeedback!.toJson());
      //logger.e(response.data);
      return Future.value(feedbackDetailsModel.getFeedback);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry!! we are unable to get your feedback's, you can try it later",
      });
    }
  }
}
