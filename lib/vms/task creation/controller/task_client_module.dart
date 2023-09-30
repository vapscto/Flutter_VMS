import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_Tsk_Client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';

class TaskClientModuleCntroller extends GetxController {
RxBool clientLoading = RxBool(false);
RxBool clientErrorloading = RxBool(false);

void updateTskClientLoading(bool val)
 {
  clientLoading.value=val;
 }

void updateTskClientErrorLoading(bool val){
  clientErrorloading.value=val;
}

RxList<GeTskClientValues> taskClientList = <GeTskClientValues>[].obs;

}