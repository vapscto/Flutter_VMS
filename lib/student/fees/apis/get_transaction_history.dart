import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/model/transaction_his_model.dart';

class GetTransactionHistory {
  GetTransactionHistory.init();
  static final GetTransactionHistory instance = GetTransactionHistory.init();

  Future<List<TransDetailHisModelValues>> getHistory({
    required int miId,
    required int asmayId,
    required int amstId,
    required String fmotGateWayType,
    required String base,
  }) async {
    final String api = base + URLS.transHistory;

    final Dio ins = getGlobalDio();
    try {
      final Response res =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "FMOT_PayGatewayType": fmotGateWayType
      });
      final TransDetailHisModel transDetailHisModel =
          TransDetailHisModel.fromJson(res.data['transactionsdetails']);
      return Future.value(transDetailHisModel.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "Server is not responding properly, Try again later"
      });
    }
  }
}
