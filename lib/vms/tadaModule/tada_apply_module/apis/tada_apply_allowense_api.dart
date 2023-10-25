import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/allowence_table_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class TadaAllowenceAPI {
  TadaAllowenceAPI.init();
  static final TadaAllowenceAPI instance = TadaAllowenceAPI.init();
  getApplyAllowense({
    required String base,
    required int userId,
    required int miId,
    required int ivrmCtId,
    required TadaApplyDataController tadaApplyController,
  }) async {
    var dio = Dio();
    var url = base + URLS.tadaAllowense;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.allowenseLoading(true);
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
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
