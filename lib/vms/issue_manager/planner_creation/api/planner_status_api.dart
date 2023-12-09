import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_list.dart';

class PlannerStatusList {
  PlannerStatusList.init();
  static final PlannerStatusList instance = PlannerStatusList.init();
  plannerStatusAPI({
    required String base,
    required int miId,
    required int userId,
    required PlannerCreationController plannerCreationController,
  }) async {
    var url = base + URLS.planStatusList;
    var dio = Dio();
    try {
      if (plannerCreationController.isErrorLoading.value) {
        plannerCreationController.errorLoading(false);
      }
      plannerCreationController.statusLoading(true);
      var response = await dio.post(url,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "UserId": userId});
      logger.i(url);
      logger.i({"MI_Id": miId, "UserId": userId});
      if (response.statusCode == 200) {
        PlannerStatusListModel plannerStatusList =
            PlannerStatusListModel.fromJson(response.data['get_plannerlist']);
        plannerCreationController.getPlannerStatus(plannerStatusList.values!);
        plannerCreationController.isPlannerCreate.value =
            response.data['plannerextapproval'];
        logger.i(plannerCreationController.isPlannerCreate.value);
        plannerCreationController.maxDate = response.data['plannerMaxdate'];
        plannerCreationController.statusLoading(false);
      }
    } on DioError catch (e) {
      logger.i(e.message);
      plannerCreationController.errorLoading(true);
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
