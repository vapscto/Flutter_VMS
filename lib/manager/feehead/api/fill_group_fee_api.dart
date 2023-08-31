import 'package:dio/dio.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/feehead/controller/fee_head_details_controller.dart';
import 'package:m_skool_flutter/manager/feehead/model/fee_fill_details_model.dart';

import '../../../constants/api_url_constants.dart';

class GetFillGroupFeeDataApi {
  GetFillGroupFeeDataApi.init();

  static final GetFillGroupFeeDataApi instance = GetFillGroupFeeDataApi.init();

  getFeeGroup(
      {required int miId,
      required int asmayId,
      required String base,
      required FeeheadDetailsController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.fillgroupfeedata;
    if (controller.isErrorOccuredWhileLoadingFillFeeDetails.value) {
      controller.updateIsErrorOccuredWhileLoadingFillFeeDetails(false);
    }
    controller.updateIsLoadingFillFeeDetails(true);
    try {
      logger.d({
        "MI_ID": miId,
        "ASMAY_ID": asmayId,
      });
      logger.d(api);
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "ASMAY_Id": asmayId});

      if (response.data['fillgroupfee'] == null) {
        controller.updateIsErrorOccuredWhileLoadingFillFeeDetails(true);
        controller.updateIsLoadingFillFeeDetails(false);
        return;
      }
      final FillFellDetailsModel feefilldetails =
          FillFellDetailsModel.fromJson(response.data['fillgroupfee']);

      controller.updateFeeFillDetails(feefilldetails.values!);
      controller.updateIsErrorOccuredWhileLoadingFillFeeDetails(false);
      controller.updateIsLoadingFillFeeDetails(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingFillFeeDetails(true);
      controller.updateIsLoadingFillFeeDetails(false);
    }
  }
}
