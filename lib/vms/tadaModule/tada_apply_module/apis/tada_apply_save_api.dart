import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/save_tada.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class TadaSaveApi {
  TadaSaveApi.init();
  static final TadaSaveApi instance = TadaSaveApi.init();
  tadaApplySave({
    required String base,
    required int ctId,
    required String fromDate,
    required String toDate,
    required int clintId,
    required double totalAppliedAmount,
    required String toAddress,
    required String remarks,
    required int vtadaaaId,
    required int vtadaaId,
    required String departureTime,
    required String arrivalTime,
    required String clintMultiple,
    required List<Map<String, dynamic>> allowanceArray,
    required TadaApplyDataController tadaApplyController,
    required List<Map<String, dynamic>> fileList,
    required int userId,
    required int miId,
    required double extraBalance,
    required bool finalDocument,
  }) async {
    logger.i({
      "UserId": userId,
      "MI_Id": miId,
      "IVRMMCT_Id": ctId,
      "VTADAA_FromDate": fromDate,
      "VTADAA_ToDate": toDate,
      "VTADAA_ClientId": clintId,
      "VTADAA_TotalAppliedAmount": totalAppliedAmount,
      "VTADAA_ToAddress": toAddress,
      "VTADAA_Remarks": remarks,
      "AllowenceArray": allowanceArray,
      "VTADAAA_Id": vtadaaaId,
      "VTADAA_Id": vtadaaId,
      "VTADAA_DepartureTime": departureTime,
      "VTADAA_ArrivalTime": arrivalTime,
      // "vtadaaA_ClientMultiple": clintMultiple,
      "filelist": fileList,
      "VTADAA_BalanceHRMS": extraBalance,
      "VTADAA_Finaldocument": finalDocument,
    });
    var dio = Dio();
    var url = base + URLS.applyTada;
    try {
      if (tadaApplyController.isErrorLoading.value = false) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.saveData(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "MI_Id": miId,
        "IVRMMCT_Id": ctId,
        "VTADAA_FromDate": fromDate,
        "VTADAA_ToDate": toDate,
        "VTADAA_ClientId": clintId,
        "VTADAA_TotalAppliedAmount": totalAppliedAmount,
        "VTADAA_ToAddress": toAddress,
        "VTADAA_Remarks": remarks,
        "AllowenceArray": allowanceArray,
        "VTADAAA_Id": vtadaaaId,
        "VTADAA_Id": vtadaaId,
        "VTADAA_DepartureTime": departureTime,
        "VTADAA_ArrivalTime": arrivalTime,
        // "vtadaaA_ClientMultiple": clintMultiple,
        "filelist": fileList
      });

      logger.i(url);
      logger.i(response.data);
      logger.i(response.statusCode);
      if (response.statusCode == 200) {
        if (response.data['returnvalue'] == true) {
          if (response.data['returnval'] == "Insert") {
            Fluttertoast.showToast(msg: "Record Saved Successfully");
            return Get.back();
          } else if (response.data['returnval'] == "Failed") {
            Fluttertoast.showToast(msg: "Record Not saved");
          } else if (response.data['returnval'] == "DuplicateAdavance") {
            Fluttertoast.showToast(msg: "Record Already Exist");
          } else if (response.data['returnval'] == "Update") {
            Fluttertoast.showToast(msg: "Record Update Successfully");
            return Get.back();
          } else if (response.data['returnval'] == "UpdateFailed") {
            Fluttertoast.showToast(msg: "Record Not Update");
          } else if (response.data['returnval'] == "") {
            Fluttertoast.showToast(msg: "please contact administrator !");
          } else {
            Fluttertoast.showToast(msg: "Record is not Saved");
          }
        }
        tadaApplyController.saveData(false);
      }
    } on DioError catch (e) {
      tadaApplyController.errorLoading(true);
      logger.e(e.message);
    } on Exception catch (e) {
      logger.i(e.toString());
    }
  }
}
