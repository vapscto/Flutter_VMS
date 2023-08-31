import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class UpdateHwSeenApi {
  UpdateHwSeenApi.init();
  static final UpdateHwSeenApi instance = UpdateHwSeenApi.init();

  markAsSeen({
    required int amstId,
    required int miId,
    required int asmayId,
    required int userId,
    required int roleId,
    required String flag,
    required int ihwId,
    required int asmclId,
    required int asmsId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.updateHwSeen;

    logger.d({
      "AMST_Id": amstId,
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "User_Id": userId,
      "roleid": roleId,
      "flag": "Homework",
      "IHW_Id": ihwId,
      "OnClickOrOnChange": "OnClick",
      "ASMCL_Id": asmclId,
      "ASMS_Id": asmsId
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "AMST_Id": amstId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "User_Id": userId,
        "roleid": roleId,
        "flag": "Homework",
        "IHW_Id": ihwId,
        "OnClickOrOnChange": "OnClick",
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId
      });

      logger.d(response.data);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
