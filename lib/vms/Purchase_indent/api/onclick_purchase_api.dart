import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/get_pi_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/purchase_request_comment.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/view_comment_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/screen/purchase_indent_details.dart';

class OnclickPurchaseApi {
  OnclickPurchaseApi.init();

  static final OnclickPurchaseApi instance = OnclickPurchaseApi.init();

  Future<void>  getOnclickPurchaseApiApi({
    required String base,
    required int userId,
    required int invmpiId,
    required PurchaseController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.onclickpurchaseapi;
    // const String api2 =
    //     "https://vmsstaging.vapssmartecampus.com:40016/api/IndentApprovalFacade/getpidetails/";

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsLoadingOnclick(true);

    logger.d(api);
    logger.d({"UserId": userId, "INVMPI_Id": invmpiId});
    
    try {
      final Response response =
          await ins.post(api, data: {"UserId": userId, "INVMPI_Id": invmpiId});
      logger.e(api);    
      logger.w({"UserId": userId, "INVMPI_Id": invmpiId});    
     if (response.data['get_pimodel'] != null) {
        controller.updateIsErrorOccured(true);
        controller.updateIsLoadingOnclick(false);
        GetPiModel getPiModelValues =
            GetPiModel.fromJson(response.data['get_pimodel']);
        controller.updateOnclickList(getPiModelValues.values!);

        ViewCommentModel viewCommentModel =
            ViewCommentModel.fromJson(response.data['viewcomments']);
        controller.getcommentList(viewCommentModel.values);

        PurchaseRequestModel purchaseRequestModel =
            PurchaseRequestModel.fromJson(
                response.data['purchaserequisitioncomments']);
        controller.getrequestList(purchaseRequestModel.values);
          controller.selectedValue.value = List.generate(
        
     controller.getOnclickList.length,
      (index) =>
          controller.getOnclickList.elementAt(index).iNVMPIAPPRejectFlg == true?
                Item(isApproved: false, isRejected: true)
                :Item(isApproved: true, isRejected: false)
              ,
    );
        return;
      }

      controller.updateIsLoadingOnclick(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoadingOnclick(false);
    }
  }
}
