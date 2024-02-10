import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/get_tada_model.dart';

class GetDetailedToDo extends GetxController {
  RxList<GetTaDaModelValues> getTaDaModelList = RxList();
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccuredLoading = RxBool(false);
  RxBool approveOrreject = RxBool(false);
  RxList<TextEditingController> tEControllerListOfSncAmount =
      <TextEditingController>[].obs;
  RxList<TextEditingController> tEControllerListOfNarration =
      <TextEditingController>[].obs;
  RxList<TextEditingController> tEControllerListOfApprovalRemark =
      <TextEditingController>[].obs;
  RxList<bool> checkList = <bool>[].obs;
  RxList<int> radioSelect = <int>[].obs;

  void updateisLoading(bool val) {
    isLoading.value = val;
  }

  void updateisErrorOccuredLoading(bool val) {
    isErrorOccuredLoading.value = val;
  }

  void updateApprovReject(bool val) {
    approveOrreject.value = val;
  }
}
