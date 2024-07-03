import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "UserId": userId, "IVRMRT_Id": roleId});
      if (response.statusCode == 200) {
        if (response.data['get_Emplist'] != null) {
          ExtensionEmployeeModel extensionEmployeeModel =
              ExtensionEmployeeModel.fromJson(response.data['get_Emplist']);
          controller.employeeList.clear();
          controller.employeeList.addAll(extensionEmployeeModel.values!);
        }
        if (response.data['get_month'] != null) {
          ExtensionMonthModel extensionMonthModel =
              ExtensionMonthModel.fromJson(response.data['get_month']);
          controller.monthsList.clear();
          controller.monthsList.addAll(extensionMonthModel.values!);
        }
        if (response.data['get_PlannerExtension'] != null) {
          ExtensionPlannerModel extensionPlannerModel =
              ExtensionPlannerModel.fromJson(
                  response.data['get_PlannerExtension']);
          controller.extensionPlannerList.clear();
          controller.extensionPlannerList.addAll(extensionPlannerModel.values!);
        }
        if (response.data['get_DailyExtension'] != null) {
          ExtensionDailyModel extensionDailyModel =
              ExtensionDailyModel.fromJson(response.data['get_DailyExtension']);
          controller.extensionDrList.clear();
          controller.extensionDrList.addAll(extensionDailyModel.values!);
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}

class ApproveAPI {
  ApproveAPI.init();
  static final ApproveAPI a = ApproveAPI.init();
  approveAPI(
      {required ExtensionController controller,
      required String base,
      required Map<String, dynamic> body}) async {
    var dio = Dio();
    var api = base + URLS.extensionSave;
    try {
      controller.approve(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      logger.i(body);
      logger.i(api);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Approved Successfully");
        controller.approve(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
