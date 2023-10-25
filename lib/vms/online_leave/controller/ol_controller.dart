import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_count_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/optional_leave_model.dart';

class OpetionLeaveController extends GetxController{
  RxList<OpetionLeaveModelValues> optionalLeaveList = <OpetionLeaveModelValues>[].obs;
  RxList<LeaveCountModelValues> leaveCountList = <LeaveCountModelValues>[].obs;
}