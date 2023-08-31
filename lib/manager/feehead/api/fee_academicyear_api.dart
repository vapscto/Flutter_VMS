import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/feehead/controller/fee_head_details_controller.dart';
import 'package:m_skool_flutter/manager/feehead/model/fee_details_selected_year_model.dart';

class GetFeeAcademicYearDataApi {
  GetFeeAcademicYearDataApi.init();

  static final GetFeeAcademicYearDataApi instance =
      GetFeeAcademicYearDataApi.init();

  getSelectedYear(
      {required int miId,
      required String base,
      required FeeheadDetailsController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.feeAcademicYearData;
    if (controller.isErrorOccurredWhileLoadingSelectedYear.value) {
      controller.updateIsErrorOccuredWhileLoadingSelectedYear(false);
    }
    controller.updateIsLoadingSelectedYear(true);
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
      });
      logger.d({
        "MI_ID": miId,
      });
      logger.d(api);
      if (response.data['yearlist'] == null) {
        controller.updateIsErrorOccuredWhileLoadingSelectedYear(true);
        controller.updateIsLoadingSelectedYear(false);
        return;
      }
      final FeeDetailsSelectedYear selectedYear =
          FeeDetailsSelectedYear.fromJson(response.data['yearlist']);
      if (selectedYear.values!.isNotEmpty) {
        controller.selectedacademicyear = selectedYear.values!.first;
      }

      controller.updateSelectedYear(selectedYear.values!);
      controller.updateIsErrorOccuredWhileLoadingSelectedYear(false);
      controller.updateIsLoadingSelectedYear(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingSelectedYear(true);
      controller.updateIsLoadingSelectedYear(false);
    }
  }
}
