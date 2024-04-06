import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/candidate_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/interviewer_list_model.dart';

class InterviewScController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxList<CandidateListModelValues> candidateList =
      <CandidateListModelValues>[].obs;
  RxList<InterviewerListModelValues> interviewerList =
      <InterviewerListModelValues>[].obs;
  RxBool isSaving = RxBool(false);
  void saveing(bool b) {
    isSaving.value = b;
  }
}
