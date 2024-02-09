import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/mc_home_screen.dart';

import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_model_list.dart';

Future<int> feachEmpolyee(
    {required String base,
    required int userId,
    required int miId,
    required int ivrmrtId,
    required MakerCheckerController controller,
    required List<Map<String, dynamic>> list}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = "$base${URLS.employee_model_list}";

  logger.d(apiUrl);

  try {
    controller.emloading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": miId,
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
