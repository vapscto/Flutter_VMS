import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/get_pi_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/purchase_indent_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/purchase_request_comment.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/view_comment_model.dart';

class PurchaseController extends GetxController {
  RxBool isFromDataProvided = RxBool(false);
  RxBool isLoadingApproval = RxBool(false);
  RxBool isSaveLoaeding = RxBool(false);
  List<String> selectedValue = [];
  RxList<TextEditingController> unitControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> remarkControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> totalApproxAmountControllerList =
      <TextEditingController>[].obs;

  void addToSelectedValueList(List<String> value) {
    selectedValue.add(value.toString());
  }

  void updateIsFromDataProvided(bool isProvided) {
    isFromDataProvided.value = isProvided;
  }

  void updateIsLoadingApproval(bool isLoading) {
    isLoadingApproval.value = isLoading;
  }

  void saveLoading(bool loading) {
    isSaveLoaeding.value = loading;
  }

  RxList<PurchaseIndentModelValues> purchaseIndentList = RxList();

  void updatePurchaseIndentList(List<PurchaseIndentModelValues> nitin) {
    if (purchaseIndentList.isNotEmpty) {
      purchaseIndentList.clear();
    }
    purchaseIndentList.addAll(nitin);
  }

  RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool error) {
    isErrorOccured.value = error;
  }

////////////////////////// ON CLICK ////////////////////////////////////////////////////

  RxBool isFromDataOnclick = RxBool(false);
  RxBool isLoadingOnclick = RxBool(false);

  void updateIsFromDataOnclick(bool isProvided) {
    isFromDataOnclick.value = isProvided;
  }

  void updateIsLoadingOnclick(bool isLoading) {
    isLoadingOnclick.value = isLoading;
  }

  // RxList<GetPiModelValues> getOnclickList = RxList();

  RxList<GetPiModelValues> getOnclickList =
      <GetPiModelValues>[].obs;

  void getunitData(TextEditingController controller) {
    unitControllerList.add(controller);
  }

  void getRemarkData(TextEditingController remarkController) {
    remarkControllerList.add(remarkController);
  }

  void getApproxAmtData(TextEditingController remarkController) {
    totalApproxAmountControllerList.add(remarkController);
  }

  void getSelectedData(String selectedData) {
    selectedValue.add(selectedData);
  }

  void updateOnclickList(List<GetPiModelValues> nitin) {
    if (getOnclickList.isNotEmpty) {
      getOnclickList.clear();
      selectedValue.clear();
      unitControllerList.clear();
      remarkControllerList.clear();
      totalApproxAmountControllerList.clear();
    }

    getOnclickList.addAll(nitin);
    for (int i = 0; i < nitin.length; i++) {
      unitControllerList.add(TextEditingController(
          text: nitin.elementAt(i).iNVTPIPIUnitRate.toString()));
      remarkControllerList
          .add(TextEditingController(text: nitin.elementAt(i).iNVTPIRemarks));
      selectedValue.add(nitin.elementAt(i).type!);
      totalApproxAmountControllerList.add(TextEditingController(
          text: nitin.elementAt(i).iNVTPIApproxAmount.toString()));
    }
  }

  RxBool isErrorOccuredOnclick = RxBool(false);

  void updateIsErrorOccuredOnclick(bool error) {
    isErrorOccured.value = error;
  }

/////////////////////////////////// VIEW COMMENT ///////////////////////////////////////////////////

  RxBool isFromDataComment = RxBool(false);
  RxBool isLoadingcomment = RxBool(false);

  void updateIsFromDatacomment(bool isProvided) {
    isFromDataComment.value = isProvided;
  }

  void updateIsLoadingcomment(bool isLoading) {
    isLoadingcomment.value = isLoading;
  }

  RxList<ViewCommentModelValues> getcommentList = RxList();

  void updatecommentList(List<ViewCommentModelValues> nitin) {
    if (getcommentList.isNotEmpty) {
      getcommentList.clear();
    }
    getcommentList.addAll(nitin);
  }

  RxBool isErrorOccuredcomment = RxBool(false);

  void updateIsErrorOccuredcomment(bool error) {
    isErrorOccured.value = error;
  }

  ///////////////////////////////////////  PURCHASE REQUEST //////////////////////////////////////////////

  RxBool isFromDataRequest = RxBool(false);
  RxBool isLoadingRequest = RxBool(false);

  void updateIsFromDataRequest(bool isProvided) {
    isFromDataRequest.value = isProvided;
  }

  void updateIsLoadingRequest(bool isLoading) {
    isLoadingRequest.value = isLoading;
  }

  RxList<PurchaseRequestModelValues> getrequestList = RxList();

  void updateRequestList(List<PurchaseRequestModelValues> nitin) {
    if (getrequestList.isNotEmpty) {
      getrequestList.clear();
    }
    getrequestList.addAll(nitin);
  }

  RxBool isErrorOccuredRequest = RxBool(false);

  void updateIsErrorOccuredRequest(bool error) {
    isErrorOccured.value = error;
  }
}
