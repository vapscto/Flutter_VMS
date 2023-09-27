import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/controller/tada_apply_controller.dart';

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
    var url = 'https://vmsstaging.vapssmartecampus.com:40015/${URLS.saveTada}';
    try {
      if (tadaApplyController.isErrorLoading.value = false) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.saveData(true);
      var response = await dio.post(url,
          // options: Options(headers: getSession())
          data: {
            "IVRMMCT_Id": ctId,
            "VTADAAA_FromDate": fromDate,
            "VTADAAA_ToDate": toDate,
            "VTADAAA_ClientId": clintId,
            "VTADAAA_TotalAppliedAmount": totalAppliedAmount,
            "VTADAAA_ToAddress": toAddress,
            "VTADAAA_Remarks": remarks,
            "AllowanceArray": allowanceArray,
            "VTADAAA_Id": vtadaaaId,
            "VTADAAA_DepartureTime": departureTime,
            "VTADAAA_ArrivalTime": arrivalTime,
            "VTADAAA_ClientMultiple": clintMultiple,
          });
      if (response.statusCode == 200) {
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
