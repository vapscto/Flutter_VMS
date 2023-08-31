import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class SubmitCertRequestApi {
  SubmitCertRequestApi.init();
  static final SubmitCertRequestApi instance = SubmitCertRequestApi.init();

  Future<bool> submitRequest(
      {required int miId,
      required int asmayId,
      required int amstId,
      required int acertapId,
      required String ascaReason,
      required String applyDate,
      required int ascaId,
      required String baseUrl}) async {
    final Dio ins = getGlobalDio();

    String apiUrl = baseUrl + URLS.applyCertificate;

    try {
      Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "ACERTAPP_Id": acertapId,
        "ASCA_Reason": ascaReason,
        "ASCA_ApplyDate": applyDate,
        "ASCA_Id": 0
      });
      logger.d(response.data);
      if (response.data['duplicate'] == true) {
        return Future.error({
          "errorTitle": "Already applied",
          "errorMsg":
              "We already have request to generate this certificate, you cannot reapply."
        });
      }
      return Future.value(true);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to submit certificate request",
        "errorMsg":
            "Sorry! We are unable to connect to the server, try again later",
      });
    }
  }
}
