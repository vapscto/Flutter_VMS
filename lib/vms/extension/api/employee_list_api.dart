import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/extension/controller/extension_controller.dart';
import 'package:m_skool_flutter/vms/extension/model/daily_report_extension.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_employee_model.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_month_model.dart';
import 'package:m_skool_flutter/vms/extension/model/planner_extension.dart';

class ExtensionAPI {
  ExtensionAPI.init();
  static final ExtensionAPI instance = ExtensionAPI.init();

  extensionAPI(
      {required ExtensionController controller,
      required String base,
      required int userId,
      required int miId,
      required int roleId}) async {
    var dio = Dio();
    var api = base + URLS.extensionLoad;
    try {
      controller.employeeLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "UserId": userId, "IVRMRT_Id": roleId});
      if (response.statusCode == 200) {
        ExtensionEmployeeModel extensionEmployeeModel =
            ExtensionEmployeeModel.fromJson(response.data['get_Emplist']);
        controller.employeeList.addAll(extensionEmployeeModel.values!);
        ExtensionMonthModel extensionMonthModel =
            ExtensionMonthModel.fromJson(response.data['get_month']);
        controller.monthsList.addAll(extensionMonthModel.values!);
        ExtensionPlannerModel extensionPlannerModel =
            ExtensionPlannerModel.fromJson(
                response.data['get_PlannerExtension']);
        controller.extensionPlannerList.addAll(extensionPlannerModel.values!);
        ExtensionDailyModel extensionDailyModel =
            ExtensionDailyModel.fromJson(response.data['get_DailyExtension']);
        controller.extensionDrList.addAll(extensionDailyModel.values!);
        controller.employeeLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
