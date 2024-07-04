import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/created_task_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_emp_details.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_module.dart';
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
        GetEmployeeId getEmployeeId = GetEmployeeId.fromJson(response.data);
        logInBox!.put("EmpId", getEmployeeId.hrmEId);
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
        CreatedTaskListModel createdTaskListModel =
            CreatedTaskListModel.fromJson(response.data['get_taskdetails']);
        controller.getTaskList(createdTaskListModel.values!);
        controller.maxPlannerDate = response.data['plannerMaxdate'];
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
    logger.v(apiUrl);
    logger.w(body);
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

  Future<int> getTskPrjtCatgryList(
      {required String base,
      required TaskCreationController controller,
      required int userId,
      required int ivrmrtId,
      required int miId,
      required int hRMEId,
      required int hRMDId}) async {
    final Dio ins = getGlobalDio();

    final String apiUrl = base + URLS.taskGetProjects;
    logger.d(base + URLS.taskGetDetails);
    logger.v({
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": miId,
      "HRME_Id": hRMEId,
      "HRMD_Id": hRMDId
    });
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "IVRMRT_Id": ivrmrtId,
        "UserId": userId,
        "MI_Id": miId,
        "HRME_Id": hRMEId,
        "HRMD_Id": hRMDId
      });
      GetEmployeeId getEmployeeId = GetEmployeeId.fromJson(response.data);
      logInBox!.put("HRMDID", getEmployeeId.hrmDId);
      logger.v(response.data['get_project']);
      GeTskProjects project =
          GeTskProjects.fromJson(response.data['get_project']);
      controller.projectList.value = project.values!;
      for (var i in controller.projectList) {
        if (i.ismmpRProjectName!.contains("VAPS - GENERAL")) {
          controller.projectId = controller.projectList.first.ismmpRId ?? 0;
        }
      }
      logger.i(controller.projectId);
      GeTskCategory category =
          GeTskCategory.fromJson(response.data['get_category']);
      controller.categoryList.value = category.values!;
      for (var i in controller.categoryList) {
        if (i.ismmtcaTTaskCategoryName!.contains("General")) {
          controller.categoryId = controller.categoryList.first.ismmtcaTId ?? 0;
        }
      }
      return response.statusCode!;
    } on DioError catch (e) {
      logger.e(e.message);
      return 0;
    } on Exception catch (e) {
      logger.e(e.toString());

      return 0;
    }
  }

  Future<bool> geTskClientApi({
    required String base,
    required TaskCreationController controller,
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
    logger.e(apiUrl);
    logger.e({
      "IVRMRT_Id": ivrmrtId,
      "UserId": userId,
      "MI_Id": miId,
      "HRME_Id": hRMEId,
      "HRMD_Id": hRMDId,
      "roletype": roleflag,
      "ISMMPR_Id": iSMMPRId
    });
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "IVRMRT_Id": ivrmrtId,
        "UserId": userId,
        "MI_Id": miId,
        "HRME_Id": hRMEId,
        "HRMD_Id": hRMDId,
        "roletype": roleflag,
        "ISMMPR_Id": iSMMPRId
      });
      logger.v(response.data['get_client']);
      logger.i(response.data['get_module']);
      GeTskClient geTskClient =
          GeTskClient.fromJson(response.data['get_client']);
      Getmodule getmoduleList = Getmodule.fromJson(response.data['get_module']);

      controller.clientList.value = geTskClient.values!;
      for (var i in controller.clientList) {
        if (i.ismmclTClientName!.contains("HO")) {
          controller.clientId = controller.clientList.first.ismmclTId ?? 0;
          logger.v(controller.clientId);
        }
      }
      controller.moduleList.value = getmoduleList.values!;
      for (var i in controller.moduleList) {
        if (i.ivrmMModuleName!.contains("All")) {
          controller.moduleId = controller.moduleList.first.ivrmMId ?? 0;
          logger.v(controller.moduleId);
        }
      }
      return true;
    } on DioError catch (e) {
      logger.e(e.message);
      return false;
    } on Exception catch (e) {
      logger.e(e.toString());

      return false;
    }
  }
}
