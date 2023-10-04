import 'dart:io';

import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';

class TaskDepartController extends GetxController{
RxBool tskDeptLoading =RxBool(false);
RxBool tskDeptErrorLoading = RxBool(false);
RxString taskAssingn = "N".obs;
RxString typesTask = "B".obs;
 void taskDeptLoading(bool val){
  tskDeptLoading.value = val;
}
 void taskDeptErrorLoading(bool val){
  tskDeptErrorLoading.value = val;
 }
 RxList<GetDeptsValues> getDeptsList = <GetDeptsValues>[].obs;
 RxList<GetPriorityModelValues> getPriorityModelList = <GetPriorityModelValues>[].obs;
 RxList<TaskEmployeeListModelValues> getTaskEmployeeList = <TaskEmployeeListModelValues>[].obs;

 searchEmp(String emp){
 var result  = getTaskEmployeeList.where((p0) => p0.employeeName == emp );
   result.forEach((element) {
    getTaskEmployeeList.add(element);
    });
 }

 void updateTaskAssign(String val){
  taskAssingn.value = val;
 }
 void updateTypeOfTask(String val){
 typesTask.value=val;
 }
RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs ;
RxList<bool>checkBox =<bool>[].obs;
 }