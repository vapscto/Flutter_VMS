import 'dart:io';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/security/controller/security_controller.dart';

 

Future<bool> savedataSecurityTask(
    {required int miId,
    required int userId,
    required String base,
    required int hrmarId,
    required int hrmaractId,
    required int hracttId,
    required String remark,
    required String status,
    required SecurtyWorkController securtyWorkController,
    }) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.seacurityTaskSave;
 // logger.e(apiUrl);
 
 
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "User_Id": userId,
      "HRMAR_Id": hrmarId,
      "HRMA_QRCODEPath": securtyWorkController.uploadImagePath.value,
      "tasklistarray": [
        {
          "HRMARACT_Id": hrmaractId,
          "HRMARACTT_Id": hracttId,
          "HRMAR_Id": hrmarId,
          "HRSTARACTRCD_Remarks": remark,
          "HRSTARACTRCD_Status": status
        }
      ]
    });
    // logger.i(
    //   {
    //   "MI_Id": miId,
    //   "User_Id": userId,
    //   "HRMAR_Id": hrmarId,
    //   "HRMA_QRCODEPath": securtyWorkController.uploadImagePath.value,
    //   "tasklistarray": [
    //     {
    //       "HRMARACT_Id": hrmaractId,
    //       "HRMARACTT_Id": hracttId,
    //       "HRMAR_Id": hrmarId,
    //       "HRSTARACTRCD_Remarks": remark,
    //       "HRSTARACTRCD_Status": status
    //     }
    //   ]
    // }
    // );
    if (response.statusCode == 200) {
      //logger.e(response.data); 
       return true;
    }
    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e);
    return false;
  }
}

 