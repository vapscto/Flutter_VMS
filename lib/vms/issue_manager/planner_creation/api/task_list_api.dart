import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/total_effort_data.dart';

class TaskListAPI {
  TaskListAPI.init();
  static final TaskListAPI instance = TaskListAPI.init();
  getList({
    required String base,
    required PlannerCreationController plannerCreationController,
    required int userId,
    required int miId,
    required int asmayId,
    required String flag,
    required String startDate,
    required String endDate,
  }) async {
    var dio = Dio();
    var url = base + URLS.assignTaskList;
    try {
      if (plannerCreationController.isErrorLoading.value) {
        plannerCreationController.errorLoading(false);
      }
      plannerCreationController.taskLoading(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Role_flag": "S",
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate
      });
      logger.i(response.data);
      logger.i(url);
      logger.i({
        "UserId": userId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Role_flag": "S",
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate
      });
      if (response.statusCode == 200) {
        CategoryWisePlanModel categoryWisePlanModel =
            CategoryWisePlanModel.fromJson(response.data['categorylist']);
        plannerCreationController.categoryList(categoryWisePlanModel.values!);
        AssignedTaskList assignedTaskList =
            AssignedTaskList.fromJson(response.data['get_Assignedtasklist']);
        if (assignedTaskList.values!.isNotEmpty) {
          plannerCreationController.assignedTask(assignedTaskList.values!);
        }
        TotalEffortData totalEffortData =
            TotalEffortData.fromJson(response.data['get_effortdetails']);
        plannerCreationController.effortData(totalEffortData.values!);
        plannerCreationController.totalDay = 0;
        plannerCreationController.totalHour = 0;
        for (int e = 0; e < totalEffortData.values!.length; e++) {
          plannerCreationController.totalDay++;
          plannerCreationController.totalHour +=
              double.parse(totalEffortData.values![e].wORKINGHOURS.toString());
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
      plannerCreationController.errorLoading(true);
    } on Exception catch (e) {
      logger.i(e);
    }
  }
}
