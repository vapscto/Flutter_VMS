import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';
import 'package:m_skool_flutter/vms/task_creation_md_sir/controller/task_controller.dart';

class TaskCreateNewAPI {
  TaskCreateNewAPI.init();
  static final TaskCreateNewAPI instance = TaskCreateNewAPI.init();
  var dio = Dio();
  getDepartment(
      {required TaskCreationController controller,
      required String base,
      required Map<String, dynamic> body}) async {
    var api = base + URLS.taskGetDetails;
    logger.e(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['get_department'] != null) {
          GetDepts getDepts =
              GetDepts.fromJson(response.data['get_department']);
          controller.departmentList.clear();
          controller.departmentList.addAll(getDepts.values!);
        }
        if (response.data['get_priority'] != null) {
          GetPriorityModel priorityModelList =
              GetPriorityModel.fromJson(response.data['get_priority']);
          controller.priorityList.clear();
          controller.priorityList.addAll(priorityModelList.values!);
        }
        // if (response.data['emplyeeEnhancements'] != null) {
        //   EmplyeeEnhancementModel emplyeeEnhancementModel =
        //       EmplyeeEnhancementModel.fromJson(
        //           response.data['emplyeeEnhancements']);
        //   controller.employeeList.clear();
        //   controller.employeeList.addAll(emplyeeEnhancementModel.values!);
        // }
        if (response.data['get_employeelist'] != null) {
          TaskEmployeeListModel employeeListModel =
              TaskEmployeeListModel.fromJson(response.data['get_employeelist']);
          controller.employeeListData.clear();
          controller.employeeListData.addAll(employeeListModel.values!);
          for (int i = 0; i < employeeListModel.values!.length; i++) {
            controller.checkBox.add(false);
          }
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<bool?> taskSave(
      {required String base, required Map<String, dynamic> body}) async {
    final String apiUrl = base + URLS.saveTaskCreation;
    try {
      var response = await dio.post(apiUrl,
          data: body, options: Options(headers: getSession()));
      logger.d(response.data);
      return true;
    } catch (e) {
      logger.e(e);
    }
    return false;
  }
}
