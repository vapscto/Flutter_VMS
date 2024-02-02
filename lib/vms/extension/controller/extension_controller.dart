import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_employee_model.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_month_model.dart';

class ExtensionController extends GetxController {
  RxBool isEmployeeLoading = RxBool(false);
  void employeeLoading(bool l) {
    isEmployeeLoading.value = l;
  }

  RxList<ExtensionEmployeeModelValues> employeeList =
      <ExtensionEmployeeModelValues>[].obs;
  RxList<ExtensionMonthModelValues> monthsList =
      <ExtensionMonthModelValues>[].obs;
}
