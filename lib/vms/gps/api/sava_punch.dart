import 'package:m_skool_flutter/constants/api_url_constants.dart';
// import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';

Future<bool> save({
  required String base,
  required int userId,
  required int miId,
  required int clientId,
  required int salesId,
  required String address,
  required String latlng,
  required String remark,
  required bool pFlag,
  required DrDetailsCtrlr controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.savePunchApi;
  logger.d(apiUrl);
  controller.updateTabLoading(true);
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "ISMMCLT_Id": clientId,
      "ISMSLE_Id": salesId,
      "VMSATGPSL_Address": address,
      "VMSATGPSL_LATLONGValue": latlng,
      "VMSATGPSL_Remarks": remark,
      "punchflag": pFlag
    });
    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ISMMCLT_Id": clientId,
      "ISMSLE_Id": salesId,
      "VMSATGPSL_Address": address,
      "VMSATGPSL_LATLONGValue": latlng,
      "VMSATGPSL_Remarks": remark,
      "punchflag": pFlag
    });
    if (response.statusCode == 200) {
      controller.updateTabLoading(false);
    }

    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.v(e.toString());
    return false;
  }
}
