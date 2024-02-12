import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/item_details_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';

class PurchaseRequisitionController extends GetxController {
  RxBool isFromDataRequestPurchase = RxBool(false);
  RxBool isLoadingRequestPurchase = RxBool(false);
  RxBool isSaveLoading = RxBool(false);
  RxBool isErrorLoading = RxBool(false);
  void error(bool loading) {
    isErrorLoading.value = loading;
  }

  void saveLoading(bool loading) {
    isSaveLoading.value = loading;
  }

  void updateIsFromDataRequest(bool isProvided) {
    isFromDataRequestPurchase.value = isProvided;
  }

  void updateIsLoadingRequestRequisition(bool isLoading) {
    isLoadingRequestPurchase.value = isLoading;
  }

  RxList<PurchaseRequisitionModelValues> getrequestRequisitionList =
      <PurchaseRequisitionModelValues>[].obs;

  getList(List<PurchaseRequisitionModelValues> list) {
    if (getrequestRequisitionList.isNotEmpty) {
      getrequestRequisitionList.clear();
    }
    for (int i = 0; i < list.length; i++) {
      getrequestRequisitionList.add(list.elementAt(i));
    }
  }

  RxBool isErrorOccuredRequestRequisition = RxBool(false);

  void updateIsErrorOccuredRequestRequisition(bool error) {
    isErrorOccuredRequestRequisition.value = error;
  }

///////////////////////////////////////////////////////////////////////////////////////
  RxBool isFromDataRequestGetItem = RxBool(false);
  RxBool isLoadingRequesGetItem = RxBool(false);

  void updateIsFromDataGetItem(bool isProvided) {
    isFromDataRequestGetItem.value = isProvided;
  }

  void updateIsLoadingRequestGetItem(bool isLoading) {
    isLoadingRequesGetItem.value = isLoading;
  }

  RxList<PurchaseGetItemModelValues> getrequestGetItemList =
      <PurchaseGetItemModelValues>[].obs;

  RxBool isErrorOccuredRequestGetItem = RxBool(false);

  void updateIsErrorOccuredRequestGetItem(bool error) {
    isErrorOccuredRequestGetItem.value = error;
  }

  RxList<String> statusList = <String>[].obs;
  RxList<TextEditingController> statusET = <TextEditingController>[].obs;
  RxInt selecInt = RxInt(0);
  RxString selecString = RxString("");
  ////////////////////////////////

  RxBool isErrorOccuredWhileLoadingIndentItem = RxBool(false);
  RxBool isLoadingIndentItem = RxBool(false);

  final RxList<PurchaseItemDetailsModelValues> itemDetailsPurchase = RxList();

  updateErrorLoadingIndentItem(bool val) {
    isErrorOccuredWhileLoadingIndentItem.value = val;
  }

  updateisLoadingIndentItem(bool val) {
    isLoadingIndentItem.value = val;
  }
}
