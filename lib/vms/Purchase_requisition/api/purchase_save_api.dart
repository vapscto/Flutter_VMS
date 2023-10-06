import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';

class PurchaseSaveAPI {
  PurchaseSaveAPI.init();
  static final PurchaseSaveAPI instance = PurchaseSaveAPI.init();
  purchaseSave({
    required String base,
    required PurchaseRequisitionController purchaseRequisitionController,
    required Map<String, dynamic> body,
  }) async {
    var dio = Dio();
    var url = base + URLS.purchaseRequisitionSave;
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
        Fluttertoast.showToast(msg: "Purchase Requisition Saved Successfully");
        purchaseRequisitionController.saveLoading(false);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } on DioError catch (e) {
      logger.i(e.message);
      purchaseRequisitionController.error(true);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
