import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/modal_view_model.dart';

class ModalViewController extends GetxController {
  /// **  MODAL CONTROLLER VIEW DATA  **  ///

  RxBool isErrorOccuredWhileLoadingModalView = RxBool(false);
  RxBool isLoadingModalView = RxBool(false);

  RxList<ModalViewPcReqModelValues> getModalView = RxList();
  void getData(List<ModalViewPcReqModelValues> data){
    if(getModalView.isNotEmpty)
    {
      getModalView.clear();
    }
    getModalView.addAll(data);
  }

  updateErrorLoadingModalView(bool val) {
    isErrorOccuredWhileLoadingModalView.value = val;
  }

  updateisLoadingModalView(bool val) {
    isLoadingModalView.value = val;
  }
}