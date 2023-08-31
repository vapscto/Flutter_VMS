import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/feedback/model/submit_feedback_model.dart';

class SaveFeedBackApi {
  SaveFeedBackApi.init();
  static final SaveFeedBackApi instance = SaveFeedBackApi.init();

  Future<bool> getSaveFeedBack({
    required int miId,
    required int asmayId,
    required int amstId,
    required String feedBack,
    required String baseUrl,
  }) async {
    final Dio ins = getGlobalDio();
    final saveFeedApiUrl = baseUrl + URLS.saveFeedBack;

    try {
      Response response = await ins.post(
        saveFeedApiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
          "AMST_Id": amstId,
          "ASGFE_FeedBack": feedBack,
        },
      );

      //logger.d(response.data);
      final SubmitFeedbackModel submitFeedbackModel =
          SubmitFeedbackModel.fromJson(response.data);

      if (submitFeedbackModel.returnval == false) {
        return Future.error({
          "errorTitle": "Unable to submit feedback",
          "errorMsg":
              "Sorry!! Currently we are unable to submit feedback, you can try again later",
        });
      }

      return Future.value(true);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error(
        {
          "errorTitle": "Unable to submit feedback",
          "errorMsg":
              "Sorry!! Right Now We are unable to connect to server, please try again later",
        },
      );
    }
  }
}
