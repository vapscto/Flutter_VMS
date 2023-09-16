
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_Model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';

class PurchaseRequisitionController extends GetxController {

  RxBool isFromDataRequestPurchase = RxBool(false);
  RxBool isLoadingRequestPurchase = RxBool(false);

  void updateIsFromDataRequest(bool isProvided) {
    isFromDataRequestPurchase.value = isProvided;
  }

  void updateIsLoadingRequestRequisition(bool isLoading) {
    isLoadingRequestPurchase.value = isLoading;
  }

  RxList<PurchaseRequisitionModelValues> getrequestRequisitionList = <PurchaseRequisitionModelValues> [].obs;

   

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

  RxList<PurchaseGetItemModelValues> getrequestGetItemList = <PurchaseGetItemModelValues> [].obs;


  RxBool isErrorOccuredRequestGetItem = RxBool(false);

  void updateIsErrorOccuredRequestGetItem(bool error) {
    isErrorOccuredRequestGetItem.value = error;
  }
}
