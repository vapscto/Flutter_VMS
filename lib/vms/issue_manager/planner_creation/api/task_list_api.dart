import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';

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
    var url =
        'https://vmsissuemanager.azurewebsites.net/${URLS.assignTaskList}';
    try {
      if (plannerCreationController.isErrorLoading.value) {
        plannerCreationController.errorLoading(false);
      }
      plannerCreationController.taskLoading(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": 60730,
        "MI_Id": 21,
        "ASMAY_Id": 129,
        "Role_flag": "S",
        "ISMTPL_StartDate": "2023-10-03T00:00:00",
        "ISMTPL_EndDate": "2023-10-07T00:00:00"
      });
      if (response.statusCode == 200) {
        CategoryWisePlanModel categoryWisePlanModel =
            CategoryWisePlanModel.fromJson(response.data['categorylist']);
        plannerCreationController.categoryList(categoryWisePlanModel.values!);
        AssignedTaskList assignedTaskList =
            AssignedTaskList.fromJson(response.data['get_Assignedtasklist']);
        plannerCreationController.assignedTask(assignedTaskList.values!);
      }
    } on DioError catch (e) {
      logger.e(e.message);
      plannerCreationController.errorLoading(true);
    } on Exception catch (e) {
      logger.i(e);
    }
  }
}
