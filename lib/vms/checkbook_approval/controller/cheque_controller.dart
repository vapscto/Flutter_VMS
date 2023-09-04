import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/company_model.dart';

class ChequeController extends GetxController {
  RxBool isErrorOccuredWhileLoading = RxBool(false);
  RxBool isLoading = RxBool(false);

  final RxList<CompanyListValues> companiesList = RxList();

  updateErrorLoading(bool val) {
    isErrorOccuredWhileLoading.value = val;
  }

  updateisLoading(bool val) {
    isLoading.value = val;
  }
}
