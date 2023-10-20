
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/visitor_approval/model/visitor_approval_model.dart';

class VisitorApprovalController extends GetxController {
 

  RxBool isFromDataVisitor = RxBool(false);
  RxBool isLoadingVisitor = RxBool(false);

  void updateIsFromDataVisitor(bool isProvided) {
    isFromDataVisitor.value = isProvided;
  }

  void updateIsLoadingVisitor(bool isLoading) {
    isLoadingVisitor.value = isLoading;
  }

  RxList<VisitorApprovalModelValues> getvisitorList = RxList();

  void updatevisitorlist(List<VisitorApprovalModelValues> visitor) {
    if (getvisitorList.isNotEmpty) {
      getvisitorList.clear();
    }
    getvisitorList.addAll(visitor);
  }

  RxBool isErrorOccuredvisitor = RxBool(false);

  void updateIsErrorOccured(bool bool) {}
  

}
