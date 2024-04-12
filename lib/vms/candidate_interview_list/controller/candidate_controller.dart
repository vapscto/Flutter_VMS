import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/candidate_model.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/edit_candidate_model.dart';

class CandidateController extends GetxController {
  RxBool isFromDataRequest = RxBool(false);
  RxBool isLoadingRequest = RxBool(false);

  void updateIsFromDataRequest(bool isProvided) {
    isFromDataRequest.value = isProvided;
  }

  RxBool isUpdateLoading = RxBool(false);
  void updateLoading(bool l) {
    isUpdateLoading.value = l;
  }

  void updateIsLoadingRequest(bool isLoading) {
    isLoadingRequest.value = isLoading;
  }

  RxList<CandidateListModelValues> getcandiateList = RxList();

  void updatecandiadateList(List<CandidateListModelValues> candi) {
    if (getcandiateList.isNotEmpty) {
      getcandiateList.clear();
    }
    getcandiateList.addAll(candi);
  }


  RxList<DataChangeCandidateModelValues> getcandiateeditList = RxList();

  // void updatecandiadateeditList(List<DataChangeCandidateModelValues> candiedit) {
  //   if (getcandiateeditList.isNotEmpty) {
  //     getcandiateeditList.clear();
  //   }
  //   getcandiateeditList.addAll(candiedit);
  // }


  RxList<DataChangeCandidateModelValues> updateeditData =
      <DataChangeCandidateModelValues>[].obs;


  RxBool isSaveeLoading = RxBool(false);
  void saveeLoading(bool l) {
    isSaveeLoading.value = l;
  }


}
