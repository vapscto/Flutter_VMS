import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';

class AddToHRMSConttroller extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxBool isSaving = RxBool(false);
  void save(bool l) {
    isSaving.value = l;
  }

  RxList<AddToHrmsCandidateListModelValues> candidateList =
      <AddToHrmsCandidateListModelValues>[].obs;
  RxList<AddToHrmsEmpTypeModelValues> empTypeList =
      <AddToHrmsEmpTypeModelValues>[].obs;
}
