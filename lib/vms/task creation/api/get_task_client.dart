import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_module.dart';

Future<bool> geTskClientApi({
  required String base,
  required TaskClientModuleCntroller controller,
  required int userId,
  required int ivrmrtId,
  required int miId,
  required int hRMEId,
  required int hRMDId,
  required String roleflag,
  required int iSMMPRId,
}) async {
  final Dio ins = getGlobalDio();

  final String apiUrl = base + URLS.getTskClinet;
  //final String apiUrl = "https://vmsstaging.vapssmartecampus.com:40015/api/ISM_TaskCreationFacade/getmodule/";
  logger.d(apiUrl);
  logger.d({
    "IVRMRT_Id": ivrmrtId,
    "UserId": userId,
    "MI_Id": miId,
    "HRME_Id": hRMEId,
    "HRMD_Id": hRMDId,
    "roletype": roleflag,
    "ISMMPR_Id": iSMMPRId
  });
  try {
    controller.updateTskClientLoading(true);
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": miId,
      "HRME_Id": hRMEId,
      "HRMD_Id": hRMDId,
      "roletype": roleflag,
      "ISMMPR_Id": iSMMPRId
    });

    GeTskClient geTskClient = GeTskClient.fromJson(response.data['get_client']);
    Getmodule getmoduleList = Getmodule.fromJson(response.data['get_module']);

    controller.taskClientList.addAll(geTskClient.values!);
    controller.getModuleValuesList.addAll(getmoduleList.values!);
    controller.updateTskClientLoading(false);
    return true;
  } on DioError catch (e) {
    controller.updateTskClientErrorLoading(true);
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateTskClientErrorLoading(true);

    return false;
  }
}
