import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/salary_details/models/salary_model.dart';

class SalaryDetailsController extends GetxController {
  RxBool isLoading = RxBool(false);
  void salaryLoading(bool loading) {
    isLoading.value = loading;
  }

  RxList<SalaryModel> salaryListModel = <SalaryModel>[].obs;
  void salaryData(SalaryModel data) {
    if (salaryListModel.isNotEmpty) {
      salaryListModel.clear();
    }
    salaryListModel.add(data);
  }
}
