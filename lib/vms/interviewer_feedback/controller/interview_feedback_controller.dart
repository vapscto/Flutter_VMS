import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/model/interview_grid_list_model.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/model/update_data_model.dart';

class InterviewFeedbackController extends GetxController {
  RxBool isListLoading = RxBool(false);
  void listLoading(bool l) {
    isListLoading.value = l;
  }

  RxBool isUpdateLoading = RxBool(false);
  void updateLoading(bool l) {
    isUpdateLoading.value = l;
  }

  RxBool isSaveLoading = RxBool(false);
  void saveLoading(bool l) {
    isSaveLoading.value = l;
  }

  RxList<InterviewModelListValues> interviewList =
      <InterviewModelListValues>[].obs;

  RxBool detailsLoading = RxBool(false);
  void getUpdate(bool l) {
    detailsLoading.value = l;
  }

  RxList<InterviewUPdateModelValues> updateData =
      <InterviewUPdateModelValues>[].obs;
}
