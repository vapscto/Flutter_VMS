

import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/new_candidate/model/new_candidate_model.dart';

class NewCandidateController extends GetxController {
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

  RxList<NewCandidateListModelValues> getnewcandiateList = RxList();

  void updatecandiadateeditList(List<NewCandidateListModelValues> candiedit) {
    if (getnewcandiateList.isNotEmpty) {
      getnewcandiateList.clear();
    }
    getnewcandiateList.addAll(candiedit);
  }

}
