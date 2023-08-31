import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/forgotpassword/controller/opt_sent_controller.dart';
import 'package:m_skool_flutter/main.dart';

class SendOtpToEmail {
  SendOtpToEmail.init();
  static final SendOtpToEmail instance = SendOtpToEmail.init();

  sendOtpNow(
      {required int miId,
      required String email,
      required String base,
      required OtpSentStatusController statusController}) async {
    final String api = base + URLS.emailOtp;
    final Dio ins = getGlobalDio();
    if (statusController.isOtpSent.value == true) {
      statusController.updateOptSent(false);
    }
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "mi_id": miId,
        "mobileno": email,
      });

      if (response.data['displaymessage'] == null) {
        return Future.error({
          "errorTitle": "Unable to send otp",
          "errorMsg":
              "Sorry! but we are unable to send otp to this email right now.",
        });
      }
      statusController.updateOtp(response.data['displaymessage']);
      statusController.updateOptSent(true);
      logger.d(statusController.otp.value);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to send otp",
        "errorMsg":
            "We are unable to send otp to $email, because server is not working right now, try again later",
      });
    }
  }
}
