import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/principal/Fee_collection/controller/fee_controller.dart';
import 'package:m_skool_flutter/principal/Fee_collection/model/fees_detaills_model.dart';
 

class GetFillGroupApi {
  GetFillGroupApi.init();

  static final GetFillGroupApi instance = GetFillGroupApi.init();

  getfeecollectionApi({
    required int miId,
    required int asmay,
    required String fromDate,
    required String toDate,
    required String base,
    required String eventId,
    required FeeController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.fillgroupfee;

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsLoadingFee(true);

    logger.d(api);

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {

      "fromdate":  fromDate,
      "MI_Id": miId,
      "todate": toDate,
      "ASMAY_Id": asmay,
      "eventName": "C"
      
      });
      logger.e(
        {
      
      "fromdate":  fromDate,
      "MI_Id": miId,
      "todate": toDate,
      "ASMAY_Id": asmay,
      "eventName": "C"
      
      }
      );

      logger.e(fromDate, toDate);
      logger.e(eventId);

      logger.i(response.data['fillgroupfee']);

      if (response.data['fillgroupfee'] != null) {
        controller.updateIsErrorOccured(true);
        controller.updateIsLoadingFee(false);
        FeesDetails feeGroupValues =
            FeesDetails.fromJson(response.data['fillgroupfee']);
        controller.FeeGroupList.addAll(feeGroupValues.values!);
        return;
      }

      controller.updateIsLoadingFee(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoadingFee(false);
    }
  }
}
