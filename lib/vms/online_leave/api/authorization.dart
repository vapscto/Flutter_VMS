import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';

Future<void> checkAuthorizationLeave(
    {required int miId,
    required String base,
    required int userId,
    required int hrmlId,
    required OpetionLeaveController opetionLeaveController}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.leaveAuthorization;
  logger.d(api);

  logger.d({
    "MI_Id": miId,
    "UserId": userId,
    "HRML_Id": hrmlId,
  });

  try {
    // controller.updateisLoadingOnloadEmployee(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "HRML_Id": hrmlId,
    });

    opetionLeaveController.particularLeaveAuthorization =
        response.data["authorizationmessage"];
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
