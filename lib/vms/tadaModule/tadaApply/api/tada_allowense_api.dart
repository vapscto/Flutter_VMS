import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/allowence_table_model.dart';

class TadaAllowenceAPI {
  TadaAllowenceAPI.init();
  static final TadaAllowenceAPI instance = TadaAllowenceAPI.init();
  getAllowense({
    required String base,
    required int userId,
    required int miId,
    required int ivrmCtId,
    required TadaApplyController tadaApplyController,
  }) async {
    var dio = Dio();
    var url = 'https://vmsstaging.vapssmartecampus.com:40015/${URLS.allowense}';
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.allowenseLoading(true);
      var response = await dio.post(
        url,
        // options: Options(headers: getSession()),
        data: {"UserId": userId, "MI_Id": miId, "IVRMMCT_Id": ivrmCtId}, //122
      );
      if (response.statusCode == 200) {
        AllowenseTableModel allowenseTableModel =
            AllowenseTableModel.fromJson(response.data['allowense']);
        // logger.i('===${response.data['allowense']}');
        // if (allowenseTableModel.allowense!.values != null) {
        tadaApplyController.getAllowense(allowenseTableModel.values!);
        // }

        tadaApplyController.allowenseLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Error catch (e) {
      logger.e(e);
    }
  }
}
