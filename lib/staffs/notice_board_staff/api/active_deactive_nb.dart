import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';

class ActivateDeactivateNbApi {
  ActivateDeactivateNbApi.init();
  static ActivateDeactivateNbApi instance = ActivateDeactivateNbApi.init();

  activateDeactivate({
    required int miId,
    required int intBId,
    required bool flag,
    required String base,
  }) async {
    final String apiUrl = base + URLS.activeDeactiveNb;
    final Dio ins = getGlobalDio();
    try {
      final Response response = await ins.post(apiUrl,
          options: Options(headers: getSession()),
          data: {"intB_ActiveFlag": flag, "INTB_Id": intBId, "MI_Id": miId});
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Operation Successfully executed");
        return;
      }

      Fluttertoast.showToast(msg: "Something went wrong");
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }
}
