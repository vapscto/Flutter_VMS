import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_model.dart';
// import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';

getPurchaseRequisitionApi({
  required String base,
  required int miIdnew,
  required PurchaseRequisitionController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.purchaserequisitionapi;
  // const String api2 =
  //     "https://vmsinventoryservicehub.azurewebsites.net/api/INV_PurchaseRequisitionFacade/GetOnchangeData/";

  if (controller.isErrorOccuredRequestRequisition.value) {
    controller.updateIsErrorOccuredRequestRequisition(false);
  }

  controller.updateIsLoadingRequestRequisition(true);

  logger.d(api);

  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()), data: {"MI_IdNew": miIdnew});
    if (response.data['get_mi_list'] != null) {
      controller.updateIsErrorOccuredRequestRequisition(true);
      controller.updateIsLoadingRequestRequisition(false);
      PurchaseRequisitionModel pValues =
          PurchaseRequisitionModel.fromJson(response.data['get_mi_list']);
      controller.getList(pValues.values!);

      ///////////////////////////////////////////////////////////////////////////////////////
    }

    controller.updateIsLoadingRequestRequisition(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredRequestRequisition(true);
  }
}
