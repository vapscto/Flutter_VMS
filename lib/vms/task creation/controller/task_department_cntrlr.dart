import 'dart:io';

import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/created_task_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/employee_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';

class TaskDepartController extends GetxController {
  RxBool tskDeptLoading = RxBool(false);
  RxBool employeeloading = RxBool(false);
  RxBool tskDeptErrorLoading = RxBool(false);
  RxBool employeeTasksloading = RxBool(false);
  RxString taskAssingn = "N".obs;
  RxString typesTask = "B".obs;
  RxBool disableSubmitButton = RxBool(true);

  var totalDaysController;

  var daysController;
  void updateDisbleSubmitButton(bool val){
    disableSubmitButton.value = val;
  }
  void taskDeptLoading(bool val) {
    tskDeptLoading.value = val;
  }
   void employeeloadingg(bool val) {
    employeeloading.value = val;
  }

  void taskDeptErrorLoading(bool val) {
    tskDeptErrorLoading.value = val;
  }

   void employeetaskLoading(bool val) {
    tskDeptErrorLoading.value = val;
  }

  RxList<GetDeptsValues> getDeptsList = <GetDeptsValues>[].obs;
  RxList<EmplyeeEnhancementModelValues> getemployeelist = <EmplyeeEnhancementModelValues>[].obs;
  RxList<GetPriorityModelValues> getPriorityModelList =
      <GetPriorityModelValues>[].obs;
  RxList<TaskEmployeeListModelValues> getTaskEmployeeList =
      <TaskEmployeeListModelValues>[].obs;

  searchEmp(String emp) {
    var result = getTaskEmployeeList.where((p0) => p0.employeeName == emp);
    result.forEach((element) {
      getTaskEmployeeList.add(element);
    });
  }

  void updateTaskAssign(String val) {
    taskAssingn.value = val;
  }

  void updateTypeOfTask(String val) {
    typesTask.value = val;
  }

  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
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

  RxBool isCreatedTaskLoading = RxBool(false);
  void createdTask(bool loading) {
    isCreatedTaskLoading.value = loading;
  }

  String maxPlannerDate = '';

  void setFilteredEmployeeList(List<EmplyeeEnhancementModelValues> filteredEmployeeList) {}
}
