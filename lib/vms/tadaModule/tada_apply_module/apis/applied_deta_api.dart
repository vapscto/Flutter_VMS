import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_applied_data_model.dart';

class AppliedDataAPI {
  AppliedDataAPI.init();
  static final AppliedDataAPI instance = AppliedDataAPI.init();
  tadaAppliedListAPI(
      {required int miId,
      required int userId,
      required String base,
      required TadaApplyDataController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.stateAndClintList;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.appliedData(true);
      var response = await dio.post(
        api,
        options: Options(headers: getSession()),
        data: {"UserId": userId, "MI_Id": miId},
      );
      logger.i(api);
      logger.i({"UserId": userId, "MI_Id": miId});
      if (response.statusCode == 200) {
        logger.i(response.data['getArray']);
        TadaSavedDataModel tadaSavedDataModel =
            TadaSavedDataModel.fromJson(response.data['getArray']);
        tadaApplyController.appliedSaved(tadaSavedDataModel.values!);
        tadaApplyController.appliedData(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
