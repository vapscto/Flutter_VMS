import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/model/trans_status_model.dart';

class TransApiStatus {
  TransApiStatus.init();
  static final TransApiStatus instance = TransApiStatus.init();

  Future<List<TransLogResultValues>> getStatus(
      {required int miId,
      required int asmayId,
      required int amstId,
      required String transId,
      required String base,
      required String gateway}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.transStatus;
    logger.d({
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "AMST_Id": amstId,
      "FMOT_PayGatewayType": gateway,
      "trans_id": transId
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "FMOT_PayGatewayType": gateway,
        "trans_id": transId
      });

      final TransLogResult transLogResult =
          TransLogResult.fromJson(response.data['translogresults']);
      //logger.d(transLogResult.toJson());
      return Future.value(transLogResult.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg": "Sorry! but we are unable to connect to server"
      });
    }
  }
}
