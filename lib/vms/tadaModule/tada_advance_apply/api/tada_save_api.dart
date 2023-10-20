import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/save_tada.dart';

class TadaSaveApi {
  TadaSaveApi.init();
  static final TadaSaveApi instance = TadaSaveApi.init();
  tadaSave({
    required String base,
    required int ctId,
    required String fromDate,
    required String toDate,
    required int clintId,
    required double totalAppliedAmount,
    required String toAddress,
    required String remarks,
    required int vtadaaaId,
    required String departureTime,
    required String arrivalTime,
    required String clintMultiple,
    required List<Map<String, dynamic>> allowanceArray,
    required TadaApplyController tadaApplyController,
  }) async {
    var dio = Dio();
    var url = base + URLS.saveTada;
    try {
      if (tadaApplyController.isErrorLoading.value = false) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.saveData(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "IVRMMCT_Id": ctId,
        "VTADAAA_FromDate": fromDate,
        "VTADAAA_ToDate": toDate,
        "VTADAAA_ClientId": clintId,
        "VTADAAA_TotalAppliedAmount": totalAppliedAmount,
        "VTADAAA_ToAddress": toAddress,
        "VTADAAA_Remarks": remarks,
        "AllowenceArray": allowanceArray,
        "VTADAAA_Id": vtadaaaId,
        "VTADAAA_DepartureTime": departureTime,
        "VTADAAA_ArrivalTime": arrivalTime,
        "VTADAAA_ClientMultiple": clintMultiple,
      });
      logger.i({
        "IVRMMCT_Id": ctId,
        "VTADAAA_FromDate": fromDate,
        "VTADAAA_ToDate": toDate,
        "VTADAAA_ClientId": clintId,
        "VTADAAA_TotalAppliedAmount": totalAppliedAmount,
        "VTADAAA_ToAddress": toAddress,
        "VTADAAA_Remarks": remarks,
        "AllowenceArray": allowanceArray,
        "VTADAAA_Id": vtadaaaId,
        "VTADAAA_DepartureTime": departureTime,
        "VTADAAA_ArrivalTime": arrivalTime,
        "VTADAAA_ClientMultiple": clintMultiple,
      });
      logger.i(response);
      logger.i(response.statusCode);
      if (response.statusCode == 200) {
        SaveTadaModel saveTadaModel = SaveTadaModel.fromJson(response.data);
        if (saveTadaModel.duplicate == '0') {}

        tadaApplyController.saveData(false);
        Fluttertoast.showToast(msg: "TA-DA saved successfully");
        return;
      }
    } on DioError catch (e) {
      tadaApplyController.errorLoading(true);
      logger.e(e.message);
    } on Exception catch (e) {
      logger.i(e.toString());
    }
  }
}
