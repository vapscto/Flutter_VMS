import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_count_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/optional_leave_model.dart';

class OpetionLeaveController extends GetxController {
  RxList<OpetionLeaveModelValues> optionalLeaveList =
      <OpetionLeaveModelValues>[].obs;
  void getOptionalLeave(List<OpetionLeaveModelValues> optionalLeave) {
    if (optionalLeaveList.isNotEmpty) {
      optionalLeaveList.clear();
    }
    for (int i = 0; i < optionalLeave.length; i++) {
      optionalLeaveList.add(optionalLeave.elementAt(i));
      logger.i(optionalLeaveList.first.fOMHWDDFromDate);
    }
  }

  RxList<LeaveCountModelValues> leaveCountList = <LeaveCountModelValues>[].obs;

  final List<XFile?> attachment = RxList();
  final List<PlatformFile> attFiles = RxList();

  void addMultipleAttachment(List<XFile?> att) {
    attachment.addAll(att);
  }

  void addToAttachment(XFile f) {
    attachment.add(f);
  }

  void removeAttachment(int index) {
    attachment.removeAt(index);
  }

  void addMultipleAttFiles(List<PlatformFile> att) {
    attFiles.addAll(att);
  }

  void addToFile(PlatformFile f) {
    attFiles.add(f);
  }

  void removeAtt(int index) {
    attFiles.removeAt(index);
  }

  List<LeaveNamesModelValues> leaveNameList = <LeaveNamesModelValues>[].obs;
  RxBool isLeaveloading = RxBool(false);
  void leaveloading(bool loading) {
    isLeaveloading.value = loading;
  }

  void leaveName(List<LeaveNamesModelValues> leaveName) {
    if (leaveNameList.isNotEmpty) {
      leaveNameList.clear();
    }
    for (int i = 0; i < leaveName.length; i++) {
      leaveNameList.add(leaveName.elementAt(i));
    }
  }

    String particularLeaveAuthorization = "";

  
}
