import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_edit_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_time.dart';

class TadaApprovalController extends GetxController {
  RxBool isDataLoading = RxBool(false);
  RxBool isDetailsLoading = RxBool(false);
  void updateIsLoading(bool loading) {
    isDetailsLoading.value = loading;
  }

  void dataLoading(bool loading) {
    isDataLoading.value = loading;
  }

  RxList<TadaApprovalListModelValues> tadaApprovalList =
      <TadaApprovalListModelValues>[].obs;
  void getTada(List<TadaApprovalListModelValues> tada) {
    if (tadaApprovalList.isNotEmpty) {
      tadaApprovalList.clear();
    }
    for (int index = 0; index < tada.length; index++) {
      tadaApprovalList.add(tada.elementAt(index));
    }
  }

  RxList<TadaApprovalTimeArrayModelValues> timeArray =
      <TadaApprovalTimeArrayModelValues>[].obs;
  void getTimeArray(List<TadaApprovalTimeArrayModelValues> time) {
    if (timeArray.isNotEmpty) {
      timeArray.clear();
    }
    for (int i = 0; i < time.length; i++) {
      timeArray.add(time.elementAt(i));
    }
  }

  RxList<TadaApprovaEditArrayModelValues> editArrayList =
      <TadaApprovaEditArrayModelValues>[].obs;
  void getEditArray(List<TadaApprovaEditArrayModelValues> time) {
    if (editArrayList.isNotEmpty) {
      editArrayList.clear();
    }
    for (int i = 0; i < time.length; i++) {
      editArrayList.add(time.elementAt(i));
    }
  }
}
