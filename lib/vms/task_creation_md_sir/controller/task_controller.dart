import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/created_task_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/employee_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';

class TaskCreationController extends GetxController {
  RxBool isDepartmentLoading = RxBool(false);
  void department(bool b) {
    isDepartmentLoading.value = b;
  }

  RxList<GetDeptsValues> departmentList = <GetDeptsValues>[].obs;
  RxList<GetPriorityModelValues> priorityList = <GetPriorityModelValues>[].obs;
  RxList<EmplyeeEnhancementModelValues> employeeList =
      <EmplyeeEnhancementModelValues>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
  RxList<TaskEmployeeListModelValues> employeeListData =
      <TaskEmployeeListModelValues>[].obs;
  String maxPlannerDate = '';
  RxList<CreatedTaskListModelValues> createdTaskList =
      <CreatedTaskListModelValues>[].obs;
  void getTaskList(List<CreatedTaskListModelValues> createdTask) {
    if (createdTaskList.isNotEmpty) {
      createdTaskList.clear();
    }
    for (int i = 0; i < createdTask.length; i++) {
      createdTaskList.add(createdTask.elementAt(i));
    }
  }

  int projectId = 0;
  int categoryId = 0;
  RxList<GeTskProjectsValues> projectList = <GeTskProjectsValues>[].obs;
  RxList<GeTskCategoryValues> categoryList = <GeTskCategoryValues>[].obs;
  int clientId = 0;
  int moduleId = 0;
  RxList<GeTskClientValues> clientList = <GeTskClientValues>[].obs;
  RxList<GetmoduleValues> moduleList = <GetmoduleValues>[].obs;
}
