// ignore_for_file: unused_local_variable

import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/gridoption_model.dart';

getAssignedManagaementApi({
  required String base,
  required int miId,
  required int userId,
  required VisitorManagementsController controller,
  required int vmmvId,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.gridoptionapi;
  const String api2 =
      "https://vmsstaging.vapssmartecampus.com:40020/api/AddVisitorsFacade/getVisitorAssignDetails/";

  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {"mI_Id": miId, "UserId": userId, "VMMV_Id": vmmvId});

    logger.i(response.data['gridoptions']);

    if (response.data['gridoptions'] != null) {
      GridOptionslistModel pValues =
          GridOptionslistModel.fromJson(response.data['gridoptions']);
      controller.getrequestGetgridoptionList.addAll(pValues.values!);
    }
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredassigned(true);
    controller.updateIsLoadingassigned(false);
  }
}
