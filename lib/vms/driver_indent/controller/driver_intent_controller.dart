import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/driver_ind_approve.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/indent_approved_model.dart';

class DriverIndentController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loadingData(bool loading) {
    isLoading.value = loading;
  }

  RxList<DriverloadModelValues> indentApprovalList =
      <DriverloadModelValues>[].obs;
  RxList<DriverIndentApprovedModelValues> indentApprovedListData =
      <DriverIndentApprovedModelValues>[].obs;
}
