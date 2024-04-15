import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/candidate_model.dart';

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

  void updatecandiadateeditList(List<CandidateListModelValues> candiedit) {
    if (getcandiateList.isNotEmpty) {
      getcandiateList.clear();
    }
    getcandiateList.addAll(candiedit);
  }

}
