import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/forgotpassword/controller/opt_sent_controller.dart';
import 'package:m_skool_flutter/forgotpassword/model/opt_verification_model.dart';
import 'package:m_skool_flutter/main.dart';

import '../../constants/api_url_constants.dart';

class SendOtpToMobile {
  SendOtpToMobile.init();
  static SendOtpToMobile instance = SendOtpToMobile.init();

  Future<OptVerificationModel> sendOtp(
      {required int miId,
      required int mobileNo,
      required String base,
      required OtpSentStatusController statusController}) async {
    final String apiUrl = base + URLS.sendOtp;

    final Dio dio = getGlobalDio();
    if (statusController.isOtpSent.value == true) {
      statusController.updateOptSent(false);
    }
    try {
      final Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "MobileNo": mobileNo,
      });

      if (response.data['displaymessage'] == null) {
        return Future.error({
          "errorTitle": "Unable to send otp",
          "errorMsg": "We are unable to send otp to $mobileNo",
        });
      }

      OptVerificationModel optVerificationModel =
          OptVerificationModel.fromJson(response.data);
      logger.d(response.data['displaymessage']);
      statusController.updateOtp(response.data['displaymessage']);
      statusController.updateOptSent(true);
      return Future.value(optVerificationModel);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to send otp",
        "errorMsg":
            "We are unable to send otp to $mobileNo, because server is not working right now, try again later",
      });
    }
  }
}
