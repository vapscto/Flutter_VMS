import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';

class PurchaseSaveAPI {
  PurchaseSaveAPI.init();
  static final PurchaseSaveAPI instance = PurchaseSaveAPI.init();
  Future<bool> purchaseSave({
    required String base,
    required PurchaseRequisitionController purchaseRequisitionController,
    required DrDetailsCtrlr controller,
    required Map<String, dynamic> body,
  }) async {
    var dio = Dio();
    var url = base + URLS.purchaseRequisitionSave;
    //  var url = "https://vmsstaging.vapssmartecampus.com:40016/api/INV_PurchaseRequisitionFacade/savedetails/";
    logger.d(body);
    logger.d(url);
    try {
      if (purchaseRequisitionController.isErrorLoading.value) {
        purchaseRequisitionController.error(false);
      }
      purchaseRequisitionController.saveLoading(true);
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
        data: body,
      );
      if (response.statusCode == 200) {
        logger.d("show $response");
        Fluttertoast.showToast(msg: "Purchase Requisition Saved Successfully");
        purchaseRequisitionController.saveLoading(false);
        controller.updateTabLoading(false);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      return true;
    } on DioError catch (e) {
      logger.e(e.message);
      purchaseRequisitionController.error(true);
      return true;
    } on Exception catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
