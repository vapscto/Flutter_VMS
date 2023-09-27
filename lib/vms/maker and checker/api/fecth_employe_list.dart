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

Future<int> feachEmpolyee(
    { required String base,
      required int userId,
    required int mi_id,
    required  int ivrmrtId,
    required MakerCheckerController controller,
    required List<Map<String, dynamic>> list}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =
      "${base}${URLS.employee_model_list}";

  logger.d(apiUrl);

  try {
    controller.emloading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": mi_id,
      "DRApprovalTypeFlag": "DRApproval",
      "designationlist": list
    });
    logger.d(list);
    if (response.data['get_userEmplist'] != null) {
      controller.empErrorrorLoading(false);
      controller.emloading(false);
      EmployeeModelList employeeModelList =
          EmployeeModelList.fromJson(response.data['get_userEmplist']);
      controller.employeeList.addAll(employeeModelList.values!);

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
