import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/leave_approval_model.dart';

class LeaveApproveController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  RxBool isLeaveLoading = RxBool(false);
  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  void leaveLoading(bool loading) {
    isLeaveLoading.value = loading;
  }

  RxList<LeaveApprovalModelValues> leaveApprovesList =
      <LeaveApprovalModelValues>[].obs;
  void getLeaves(List<LeaveApprovalModelValues> leaves) {
    if (leaveApprovesList.isNotEmpty) {
      leaveApprovesList.clear();
    }
    for (int i = 0; i < leaves.length; i++) {
      leaveApprovesList.add(leaves.elementAt(i));
    }
  }
}
