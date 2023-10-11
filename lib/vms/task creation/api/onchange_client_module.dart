import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
 
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';

Future<bool> onChangeModuleListApi(
    {required String base,
    required TaskDepartController controller,
    required int userId,
    required int ivrmrtId,
    required int miId,
    required int HRME_Id,
    required int hrmdId,
    required String roleType,
    required int ismmprId,
    required int ismmcltId}) async {
  final Dio ins = getGlobalDio();

  final String apiUrl = base + URLS.onchangeMoudleChange;
  logger.d(base + URLS.taskGetDetails);

  try {
    controller.taskDeptLoading(true);
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": miId,
      "HRMD_Id": hrmdId,
      "roletype":  roleType,
      "ISMMPR_Id": ismmprId,
      "ISMMCLT_Id": ismmcltId
    });
    
     GetPriorityModel priorityModelList =
        GetPriorityModel.fromJson(response.data['get_priority']);
    controller.getPriorityModelList.addAll(priorityModelList.values!);
     
    return true;
  } on DioError catch (e) {
     logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
 
    return false;
  }
}
