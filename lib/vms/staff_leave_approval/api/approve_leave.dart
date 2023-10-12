import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class ApproveLeaveApi {
  ApproveLeaveApi.init();
  static final ApproveLeaveApi instance = ApproveLeaveApi.init();

  Future<bool> approveNow({
    required String remark,
    required String status,
    required String base,
    required int miId,
    required int loginId,
    required List<Map<String, dynamic>> getLeaveStatus,
  }) async {
    final String api = base + URLS.approveLeave;
    final Dio ins = getGlobalDio();
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "HRELAPA_Remarks": remark,
        "HRELT_Status": status,
        "MI_Id": miId,
        "LoginId": loginId,
        "get_leave_status": getLeaveStatus
      });

      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        logger.d(response.data);

        Fluttertoast.showToast(msg: "What you want is done...");
        return Future.value(true);
      }

      return Future.value(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.error);
      return Future.error({
        "errorTitle": "Server Error Occured",
        "errorMsg": e.message,
      });
    }
  }
}
