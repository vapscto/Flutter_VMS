import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_details/model/designationModel.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/getTaDaModel.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/mc_home_screen.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/department_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/designation.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_model_list.dart';

Future<int> feachDesignation(
    {required int userId,
    required int mi_id,
    required MakerCheckerController controller,
    required List<Map<String, dynamic>> list}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =
      "https://vmsissuemanager.azurewebsites.net/${URLS.designationsListapi}";

  logger.d(apiUrl);

  try {
    controller.dsgloading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": 11,
      "UserId": 60934,
      "MI_Id": 17,
      "DRApprovalTypeFlag": "DRApproval",
      "departmentlist": list
    });
    logger.d(list);
    if (response.data['designation'] != null) {
      controller.dsgloading(false);

      dsgnModel dsgnList = dsgnModel.fromJson(response.data['designation']);

      controller.designationList.addAll(dsgnList.values!);

      return response.statusCode!;
    }
    return 0;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}
