import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class PaymentSuccessfullApi {
  PaymentSuccessfullApi.init();
  static final PaymentSuccessfullApi instance = PaymentSuccessfullApi.init();

  Future<bool> doAfterPaymentMade({
    required int miId,
    required String paymentId,
    required String orderId,
    required String base,
  }) async {
    final Dio dio = getGlobalDio();

    final String apiUrl = base + URLS.razorPayResponse;

    try {
      // final Response response2 = await dio.post(
      //   "https://jnujaipur.vapssmartecampus.com:61005/api/FeeOnlinePaymentFacade/razorresponse",
      //   options: Options(headers: getSession()),
      //   data: {
      //     "IVRMOP_MIID": miId,
      //     "razorpay_payment_id": paymentId,
      //   },
      // );

      final Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "IVRMOP_MIID": miId,
        "razorpay_payment_id": paymentId,
        "order_id": orderId,
      });

      if (response.statusCode != 200) {
        return Future.error(
          {
            "errorTitle": "Server Error Occured",
            "errorMsg":
                "Server did not responded correctly for this request. Your money is deducted contact school adminstration and share your payment details. \n\nStatus Code ${response.statusCode}\nPayment Id : $paymentId",
          },
        );
      }

      logger.d(response.data);
      return Future.value(
        true,
      );
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error(
        {
          "errorTitle": "Unable to connect to server",
          "errorMsg":
              "Sorry but we are unable to full fill this request. Your money is deducted contact school adminstration and share your payment details.\nPayment Id : $paymentId",
        },
      );
    }
  }
}
