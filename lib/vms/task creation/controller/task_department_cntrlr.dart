import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';

class TaskDepartController extends GetxController{
RxBool tskDeptLoading =RxBool(false);
RxBool tskDeptErrorLoading = RxBool(false);
void taskDeptLoading(bool val){
  tskDeptLoading.value = val;
}
 void taskDeptErrorLoading(bool val){
  tskDeptErrorLoading.value = val;
 }
 RxList<GetDeptsValues> getDeptsList = <GetDeptsValues>[].obs;
}