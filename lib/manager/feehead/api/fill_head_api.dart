import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/feehead/controller/fee_head_details_controller.dart';
import 'package:m_skool_flutter/manager/feehead/model/fill_head_data_model.dart';

class GetFillHeadDataApi {
  GetFillHeadDataApi.init();
  static final GetFillHeadDataApi instance = GetFillHeadDataApi.init();

  getFeeHead(
      {required int miId,
      required int asmayId,
      required String base,
      required FeeheadDetailsController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.FeeHeadData;
    if (controller.isErrorOccuredWhileLoadingFillHeadDetails.value) {
      controller.updateIsErrorOccuredWhileLoadingFillHeadDetails(false);
    }
    logger.d(api);
    controller.updateIsLoadingFillHeadDetails(true);

    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "ASMAY_Id": asmayId});
      logger.d({
        "MI_ID": miId,
        "ASMAY_ID": asmayId,
      });

      if (response.data['fillhead'] == null) {
        controller.updateIsErrorOccuredWhileLoadingFillHeadDetails(true);
        controller.updateIsLoadingFillHeadDetails(false);
      }
      final FillHeadDataModel fillheaddetails =
          FillHeadDataModel.fromJson(response.data['fillhead']);
      controller.updateFeeheadDetails(fillheaddetails.values!);
      controller.updateIsErrorOccuredWhileLoadingFillHeadDetails(false);
      controller.updateIsLoadingFillHeadDetails(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingFillHeadDetails(true);
      controller.updateIsLoadingFillHeadDetails(false);
    }
  }
}
