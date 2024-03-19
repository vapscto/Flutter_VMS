import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/indent_approval.model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/indent_details_model.dart';

 Future <int?> getpurchasedetailsApi({
  required String base,
  required int miId,
  required int asmaYId,
  required int userId,
  required  String flag,
  required int invmpRId,
  
  required PurchaseRequisitionController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.onpurchaseviewapi;

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
    "ASMAY_Id": asmaYId,
    "UserId": userId,
    "INVMPR_Id": invmpRId,
    "Flag": flag
});
  logger.d(response.data);
    if (response.data['get_Details'] != null) {
      controller.updateIsErrorOccuredRequestRequisition(true);
      controller.updateIsLoadingRequestRequisition(false);
      IndentDetailsModel purchaseontaplist =
          IndentDetailsModel.fromJson(response.data['get_Details']);
      controller.getpurchaseontapList(purchaseontaplist.values!);
      PurchaseApprovalModel purchaseApprovalModel = 
          PurchaseApprovalModel.fromJson(response.data['get_Details']);
      controller.getpurchaseapprovaltapList(purchaseApprovalModel.values!);

    }
    controller.updateIsLoadingRequestRequisition(false);



   


    return response.statusCode;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredRequestRequisition(true);
  }
  return 0;
}
