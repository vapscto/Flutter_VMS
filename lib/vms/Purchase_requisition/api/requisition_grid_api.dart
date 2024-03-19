import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_requisition_grid.model.dart';

getPurchaseRequisitionGridApi({
  required String base,
  required int miId,
  required int userId,
  required PurchaseRequisitionController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.purchaserequisitiongridapi;
  // const String api2 =
  //     "https://vmsinventoryservicehub.azurewebsites.net/api/INV_PurchaseRequisitionFacade/GetOnchangeData/";

  if (controller.isErrorOccuredRequestRequisition.value) {
    controller.updateIsErrorOccuredRequestRequisition(false);
  }

  controller.updateIsLoadingRequestRequisition(true);

  logger.d(api);

  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()), 

        data: {
    "MI_Id": miId,
    "Userid": userId
        });
        logger.w(api);
        logger.w({
    "MI_Id": miId,
    "Userid": userId
        });
    if (response.data['get_purchaserequisition'] != null) {
      controller.updateIsErrorOccuredRequestRequisition(true);
      controller.updateIsLoadingRequestRequisition(false);
      PurchaseRequsitionGridModel gridlist =
          PurchaseRequsitionGridModel.fromJson(response.data['get_purchaserequisition']);
      controller.getgridList(gridlist.values!);

    }

    controller.updateIsLoadingRequestRequisition(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredRequestRequisition(true);
  }
}
