import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/approved_list_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_approval_check_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_approved_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_list_model.dart';

class NocApprovedController extends GetxController {
  RxBool isApprovedLoading = RxBool(false);
  RxBool isListLoading = RxBool(false);

  void approved(bool l) {
    isApprovedLoading.value = l;
  }

  void listData(bool l) {
    isListLoading.value = l;
  }

  RxList<NocApprovedModelValues> approvedList = <NocApprovedModelValues>[].obs;
  RxInt maxLevel = 0.obs;
  String remarks = '';
  RxList<NocApprovalChekListModelValues> checkListModel =
      <NocApprovalChekListModelValues>[].obs;

  RxList<NocAppliedListModelValues> nocList = <NocAppliedListModelValues>[].obs;
  RxList<NocApprovedListModelValues> approvedListModel =
      <NocApprovedListModelValues>[].obs;
}
