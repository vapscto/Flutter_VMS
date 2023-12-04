import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/check_planner.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class CheckPlannerAPI {
  CheckPlannerAPI.init();
  static final CheckPlannerAPI instance = CheckPlannerAPI.init();
  applyCheckPlannerAPI({
    required String base,
    required int userId,
    required int miId,
    required String fromDate,
    required String toDate,
    required TadaApplyDataController tadaApplyController,
  }) async {
    var dio = Dio();
    var url = base + URLS.tadaAllowense;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.plannerCreate(true);
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
        data: {
          "UserId": userId,
          "MI_Id": miId,
          "VTADAA_FromDate": fromDate,
          "VTADAA_ToDate": toDate,
        },
      );
      if (response.statusCode == 200) {
        CheckPlannerModel checkPlannerModel =
            CheckPlannerModel.fromJson(response.data['getArray']);
        tadaApplyController.checkPlan(checkPlannerModel.values!);
        tadaApplyController.plannerCreate(false);
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Error catch (e) {
      logger.e(e);
    }
  }
}
