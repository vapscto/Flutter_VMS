import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class TadaEditAPI {
  TadaEditAPI.init();
  static final TadaEditAPI instance = TadaEditAPI.init();
  tadaApplyEditData(
      {required String base,
      required int userId,
      required int miId,
      required int vtadaaaId,
      required TadaApplyDataController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.tadaApplyDeactive;

    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.editData(true);
      var response = await dio.post(
        api,
        options: Options(headers: getSession()),
        data: {"UserId": userId, "MI_Id": miId, "VTADAAA_Id": vtadaaaId},
      );
      logger.i({"UserId": userId, "MI_Id": miId, "VTADAAA_Id": vtadaaaId});
      logger.i(response.statusCode);
      logger.i(response.data);
      if (response.statusCode == 200) {
        if (response.data['returnvalue'] == true) {
          if (response.data['returnval'] == 'Delete') {
            Fluttertoast.showToast(msg: "Record Deactivated successfully");
            Get.back();
          } else if (response.data['returnval'] == 'NotDelete') {
            Fluttertoast.showToast(msg: "Record Activated successfully");
            Get.back();
          } else if (response.data['returnval'] == 'Firststage') {
            Fluttertoast.showToast(msg: "Result is Waiting for Authrization!");
          }
        } else {
          Fluttertoast.showToast(msg: "Please Contact Administrator!!!");
        }
        tadaApplyController.editData(false);
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Error catch (e) {
      logger.e(e);
    }
  }
}
