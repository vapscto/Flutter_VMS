import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<void> saveFinalTadaApprovalApi(
    {required String base,
    required int hrmeId,
    required int miID,
    required int vtadaaId,
    required int userId,
    required String vtadaaRemark,
    required int vtadaaTotalSancatinedAmount,
    required int approvecnt,
    required int level,
    required BuildContext context}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.saveFinalTadaApproval;
  try {
    logger.w({
      "UserId": userId,
      "VTADAA_Remarks": vtadaaRemark,
      "VTADAA_TotalSactionedAmount": vtadaaTotalSancatinedAmount,
      "VTADAA_Id": vtadaaId,
      "MI_Id": miID,
      "approvecnt": approvecnt,
      "level": level,
      "HRME_Id": hrmeId
    });
    var response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "UserId": userId,
      "VTADAA_Remarks": vtadaaRemark,
      "VTADAA_TotalSactionedAmount": vtadaaTotalSancatinedAmount,
      "VTADAA_Id": vtadaaId,
      "MI_Id": miID,
      "approvecnt": approvecnt,
      "level": level,
      "HRME_Id": hrmeId,
      "headarray": []
    });
    if (response.statusCode == 200) {
      logger.w(response.data);
      if (response.data['returnvalue'] == true) {
        Fluttertoast.showToast(msg: "You have successfully Applied");
        Get.back();
        Get.back();
        // Navigator.pop(context);
        // Navigator.pop(context);
      }
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
