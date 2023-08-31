import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class DoAfterEaseBuzzApi {
  DoAfterEaseBuzzApi.init();
  static final DoAfterEaseBuzzApi instance = DoAfterEaseBuzzApi.init();

  Future<bool> doAfterPaymentMade(
      Map<Object?, Object?> resp, String base) async {
    final String api = base + URLS.easeBuzzPaymentResponseCall;
    final Dio ins = getGlobalDio();
    logger.d(api);
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: resp);
      logger.d(response.data);
      return Future.value(true);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "Your amount is been deducted but still not updated in our record.. Contact to school adminstrator and query with this transaction Id : ${resp['txnid']} ",
      });
    }
  }
}
