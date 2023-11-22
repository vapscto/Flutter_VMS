import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/controller/tada_apply_controller.dart';

class TadaEditAPI {
  TadaEditAPI.init();
  static final TadaEditAPI instance = TadaEditAPI.init();
  tadaEditData(
      {required String base,
      required int userId,
      required int miId,
      required int vtadaaaId,
      required TadaApplyController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.tadaDeactive;

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
      logger.i(api);
      logger.i(response.statusCode);
      logger.i(response.data);
      if (response.statusCode == 200) {
        // EditModel editModel = EditModel.fromJson(response.data['editArray']);
        if (response.data['returnvalue'] == true) {
          Fluttertoast.showToast(msg: "TA-DA Deactivated successfully");
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
