import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/model/payment_charges.dart';

class PaymentChargesApi {
  PaymentChargesApi.init();
  static final PaymentChargesApi instance = PaymentChargesApi.init();

  Future<List<PaymentChargesValues>> loadPaymentCharges(
      {required int miId,
      required fmotPaymentType,
      required String base}) async {
    try {
      final Dio ins = getGlobalDio();
      String api = base + URLS.paymentCharges;
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "FMOT_PayGatewayType": fmotPaymentType,
      });
      if (response.data['gatewayRatedetails'] == null) {
        return Future.error({
          "errorTitle": "Sorry!! We are unable to show payment charges",
          "errorMsg":
              "Currently we are not getting gatewayRatedetails array, contact tech team to get this details",
        });
      }

      final PaymentCharges paymentCharges =
          PaymentCharges.fromJson(response.data['gatewayRatedetails']);

      return paymentCharges.values!;
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Sorry!! We are unable to connect to server",
        "errorMsg":
            "Currently server is not responding properly, try again later",
      });
    }
  }
}
