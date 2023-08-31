import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class UpdateClassworkSeenApi {
  UpdateClassworkSeenApi.init();
  static final UpdateClassworkSeenApi instance = UpdateClassworkSeenApi.init();

  updateSeen({
    required int amstId,
    required int miId,
    required int asmayId,
    required int userId,
    required int roleId,
    required int icwId,
    required int asmclId,
    required int asmsId,
    required String base,
  }) async {
    final String api = base + URLS.updateCwSeen;
    final Dio ins = getGlobalDio();
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "AMST_Id": amstId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "User_Id": userId,
        "roleid": roleId,
        "flag": "Classwork",
        "ICW_Id": icwId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
      });
      logger.d(response.data);
      //logger.d(response.data['classworklist_byid']['\$values']);
    } catch (e) {
      logger.e(e.toString());
      Fluttertoast.showToast(msg: "Error Occurred while updating seen flag");
    }
  }
}
