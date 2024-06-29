import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/controller/deviation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/model/dev_details_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/model/dev_emp_list_model.dart';

class DeviationAPI {
  DeviationAPI.init();
  static final DeviationAPI i = DeviationAPI.init();
  var dio = Dio();
  empList(
      {required String base,
      required int miId,
      required int userId,
      required DeviationController controller}) async {
    var api = base + URLS.devEmpList;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId, "UserId": userId},
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['get_userEmplist'] != null) {
          DeviationEmpModel deviationEmpModel =
              DeviationEmpModel.fromJson(response.data['get_userEmplist']);
          controller.empList.addAll(deviationEmpModel.values!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  reportDetails(
      {required String base,
      required Map<String, dynamic> body,
      required DeviationController controller}) async {
    var api = base + URLS.devReport;
    logger.i(api);
    logger.v(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        controller.startDate = response.data['startdate'];
        controller.endDate = response.data['enddate'];
        if (response.data['get_deviationreport'] != null) {
          DeviationDetailsModel deviationDetailsModel =
              DeviationDetailsModel.fromJson(
                  response.data['get_deviationreport']);
          controller.getDeviation(deviationDetailsModel.values!);
        }
        logger.w(response.data);
      }
    } on DioError catch (e) {
      logger.e(e);
    }
  }
}
