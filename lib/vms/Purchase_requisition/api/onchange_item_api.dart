import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/item_details_model.dart';

  Future<String>  getIndentItemDetails(
    {required int miId,
    required String base,
    required int userId,
    required int itemId,
    required PurchaseRequisitionController controller}) async {
  final Dio ins = getGlobalDio();
  final api = base + URLS.indentItem;
  logger.d(api);
  logger.d({"MI_Id": miId, "Userid": userId, "INVMI_Id": itemId});

  try {
    controller.updateisLoadingIndentItem(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "Userid": userId, "INVMI_Id": itemId});

    // logger.d(response.data['get_itemDetail']);
    if (response.data['get_itemDetail'] == null) {
      controller.updateErrorLoadingIndentItem(true);
      // return 0;
    } else if (response.data['get_itemDetail'] != null) {
      controller.updateErrorLoadingIndentItem(false);
      controller.updateisLoadingIndentItem(false);
    }
    PurchaseItemDetailsModel organizationListResponse =
        PurchaseItemDetailsModel.fromJson(response.data['get_itemDetail']);
    controller.itemDetailsPurchase.addAll(organizationListResponse.values!);
   // controller.selecString.value = organizationListResponse.values!.first.invmuoMUOMName!;
    return organizationListResponse.values!.first.invmuoMUOMName!;
  } on DioError catch (e) {
    controller.updateErrorLoadingIndentItem(true);

    logger.e(e.message);
     return "Null";
  } on Exception catch (e) {
    logger.e(e.toString());
    return "Null";
  }
}
