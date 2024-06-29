import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/employee_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
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
}
