import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/ontapdetails_model.dart';

 Future <int?> getOntapdetailsApi({
  required String base,
  required int mIIdNew,
  required int userId,
  required int invmpRId,
  required PurchaseRequisitionController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.ontapviewapi;

  if (controller.isErrorOccuredRequestRequisition.value) {
    controller.updateIsErrorOccuredRequestRequisition(false);
  }

  controller.updateIsLoadingRequestRequisition(true);

  logger.d(api);

  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()), 

        data: {
    "MI_IdNew": mIIdNew,
    "UserId": userId,
    "INVMPR_Id": invmpRId
});
        logger.w(api);
        logger.w({
    "MI_IdNew": mIIdNew,
    "UserId": userId,
    "INVMPR_Id": invmpRId
});
    if (response.data['get_prDetail'] != null) {
      controller.updateIsErrorOccuredRequestRequisition(true);
      controller.updateIsLoadingRequestRequisition(false);
      GetPrDetailModel viewontaplist =
          GetPrDetailModel.fromJson(response.data['get_prDetail']);
      controller.getontapList(viewontaplist.values!);

    }
    controller.updateIsLoadingRequestRequisition(false);
    return response.statusCode;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredRequestRequisition(true);
  }
  return 0;
}
