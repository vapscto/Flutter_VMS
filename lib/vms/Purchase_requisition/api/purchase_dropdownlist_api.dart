
import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_Model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';

 

  getPurchaseRequisitionApi({
    required String base,
    required int miIdnew,
    required PurchaseRequisitionController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.purchaserequisitionapi;
const String api2 = "https://vmsinventoryservicehub.azurewebsites.net/api/INV_PurchaseRequisitionFacade/GetOnchangeData/";

    if (controller.isErrorOccuredRequestRequisition.value) {
      controller.updateIsErrorOccuredRequestRequisition(false);
    }

    controller.updateIsLoadingRequestRequisition(true);

    logger.d(api);

    try {
      final Response response =
          await ins.post(api2, options: Options(headers: getSession()), data: {
     "MI_IdNew": miIdnew
        //  options: Options(headers: getSession())
      });


      // logger.i(response.data['get_mi_list']);
      logger.i(response.data['get_item']);

      if (response.data['get_mi_list']!= null) {
        controller.updateIsErrorOccuredRequestRequisition(true);
        controller.updateIsLoadingRequestRequisition(false);
        PurchaseRequisitionModel pValues =
            PurchaseRequisitionModel.fromJson(response.data['get_mi_list']);
        controller.getrequestRequisitionList.addAll(pValues.values!);

  /////////////////////////////////////////////////////////////////////////////////////// 
      }
      PurchaseGetItemModel purchaseGetItemModel = PurchaseGetItemModel.fromJson(response.data['get_item']);
controller.getrequestGetItemList.addAll(purchaseGetItemModel.values!);

      controller.updateIsLoadingRequestRequisition(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredRequestRequisition(true);
      controller.updateIsLoadingRequestRequisition(false);
    }
  }
 
