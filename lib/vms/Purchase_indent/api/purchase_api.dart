import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/purchase_indent_model.dart';

class PurchaseIndentApi {
  PurchaseIndentApi.init();

  static final PurchaseIndentApi instance = PurchaseIndentApi.init();

  getPurchaseIndentApiApi({
    required String base,
    required int userId,
    required PurchaseController controller,
  }) async {
    final Dio ins = getGlobalDio();
    // final String api = base + URLS.purchaseindentapi;
     String api2 =
        base + URLS.purchaseLoadData;

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsLoadingApproval(true);

    logger.d(api2);
    logger.d({
      "UserId": userId,
    });

    try {
      final Response response =
          await ins.post(api2, options: Options(headers: getSession()), data: {
        "UserId": userId,
      });

      logger.d(response.data['get_prNo']);
      PurchaseIndentModel purchaseIndentModelValues =
          PurchaseIndentModel.fromJson(response.data['get_prNo']);
      controller.purchaseIndentList.addAll(purchaseIndentModelValues.values!);

      controller.updateIsLoadingApproval(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoadingApproval(false);
    }
  }
}
