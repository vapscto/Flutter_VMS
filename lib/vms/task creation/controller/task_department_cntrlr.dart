import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';

class TaskDepartController extends GetxController{
RxBool tskDeptLoading =RxBool(false);
RxBool tskDeptErrorLoading = RxBool(false);
RxString taskAssingn = "Y".obs;
RxString typesTask = "B".obs;
 void taskDeptLoading(bool val){
  tskDeptLoading.value = val;
}
 void taskDeptErrorLoading(bool val){
  tskDeptErrorLoading.value = val;
 }
 RxList<GetDeptsValues> getDeptsList = <GetDeptsValues>[].obs;
 RxList<GetPriorityModelValues> getPriorityModelList = <GetPriorityModelValues>[].obs;

 void updateTaskAssign(String val){
  taskAssingn.value = val;
 }
 void updateTypeOfTask(String val){
typesTask.value=val;
 }
}