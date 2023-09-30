import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/check_planner.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/controller/tada_apply_controller.dart';

class CheckPlannerAPI {
  CheckPlannerAPI.init();
  static final CheckPlannerAPI instance = CheckPlannerAPI.init();
  checkPlannerAPI({
    required String base,
    required int userId,
    required int miId,
    // required int ivrmCtId,
    required String fromDate,
    required String toDate,
    required TadaApplyController tadaApplyController,
  }) async {
    var dio = Dio();
    var url = base + URLS.allowense;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.plannerCreate(true);
      var response = await dio.post(
        url,
        // options: Options(headers: getSession()),
        data: {
          "UserId": userId,
          "MI_Id": miId,
          // "IVRMMCT_Id": 122,
          "VTADAAA_FromDate": fromDate,
          "VTADAAA_ToDate": toDate,
        },
      );

      if (response.statusCode == 200) {
        CheckPlannerModel checkPlannerModel =
            CheckPlannerModel.fromJson(response.data['client_Master']);
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
