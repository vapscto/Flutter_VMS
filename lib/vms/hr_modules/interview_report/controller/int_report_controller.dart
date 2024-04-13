import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/model/completed_intvw_model.dart';

class IntviewGridController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxList<CompletedIntvwModelValues> completedList =
      <CompletedIntvwModelValues>[].obs;
  RxList<CompletedIntvwModelValues> upComingList =
      <CompletedIntvwModelValues>[].obs;
  RxList<CompletedIntvwModelValues> inProgressList =
      <CompletedIntvwModelValues>[].obs;
}
