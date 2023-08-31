import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/coe/controller/coe_data_handler.dart';
import 'package:m_skool_flutter/staffs/coe/model/staff_coe_model.dart';

class StaffCoeApi {
  StaffCoeApi.init();
  static final StaffCoeApi instance = StaffCoeApi.init();

  Future<void> getCoeList({
    required int miId,
    required int asmayId,
    required String base,
    required int month,
    required int asmclId,
    required CoeDataHandler coeDataHandler,
  }) async {
    if (coeDataHandler.isWholePageLoading.value) {
      coeDataHandler.updateIsWholePageLoading(false);
    }
    if (coeDataHandler.errorOccuredWhileLoadingCoe.value) {
      coeDataHandler.updateIsErrorOccuredWhileLoadingCoe(false);
    }
    if (!coeDataHandler.isCoeLoading.value) {
      coeDataHandler.updateIsCoeLoading(true);
    }

    coeDataHandler.updateCoeLoadingStatus(coeDataHandler.loadingCoeData);

    final String apiUrl = base + URLS.staffCoe;

    logger.d(apiUrl);
    logger.d({
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "month": month,
      "type": 1,
      "ASMCL_Id": asmclId,
    });
    final Dio ins = getGlobalDio();
           
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "month": month,
        "type": 1,
        "ASMCL_Id": asmclId,
      });

      if (response.data['coereport'] == null) {
        coeDataHandler.updateIsErrorOccuredWhileLoadingCoe(true);
        return;
      }
       
      final StaffCoeModel coeModel =
          StaffCoeModel.fromJson(response.data['coereport']);

      coeDataHandler.updateCoeLists(coeModel.values!);
      coeDataHandler.updateIsErrorOccuredWhileLoadingCoe(false);
      coeDataHandler.updateIsCoeLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      coeDataHandler.updateIsErrorOccuredWhileLoadingCoe(true);
    }
  }
}
