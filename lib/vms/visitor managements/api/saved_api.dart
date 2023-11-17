// ignore_for_file: unused_local_variable

import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';

Future<bool> getsavedApi({
  required String base,
  required int miId,
  required int userId,
  required int vmmvId,
  required String vmvtmtdate,
  required int vmvtmtId,
  required String vmvtmtlocation,
  required bool vmvtmtmetflag,
  required String vmvtmtremarks,
  required int vmvtmttomeethrmeId,
  required String fhrors,
  required String fminutes,
  required VisitorManagementsController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.saveapi;
  const String api2 =
      "https://vmsstaging.vapssmartecampus.com:40020/api/AddVisitorsFacade/saveAssignedData/";

  logger.i({
    "MI_Id": miId,
    "UserId": userId,
    "VMMV_Id": vmmvId,
    "VMVTMT_DateTime": vmvtmtdate,
    "VMVTMT_Id": vmvtmtId,
    "VMVTMT_Location": vmvtmtlocation,
    "VMVTMT_MetFlg": vmvtmtmetflag,
    "VMVTMT_Remarks": vmvtmtremarks,
    "VMVTMT_ToMeet_HRME_Id": vmvtmttomeethrmeId,
    "fhrors": fhrors,
    "fminutes": fminutes,
  });

  try {
    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "VMMV_Id": vmmvId,
      "VMVTMT_DateTime": vmvtmtdate,
      "VMVTMT_Id": vmvtmtId,
      "VMVTMT_Location": vmvtmtlocation,
      "VMVTMT_MetFlg": vmvtmtmetflag,
      "VMVTMT_Remarks": vmvtmtremarks,
      "VMVTMT_ToMeet_HRME_Id": vmvtmttomeethrmeId,
      "fhrors": fhrors,
      "fminutes": fminutes,
    });
    logger.i(response.data);
    return true;
  } on Exception catch (e) {
    logger.e(e.toString());

    controller.updateIsErrorOccuredsave(true);
    controller.updateIsLoadingsave(false);
    return false;
  }
}
