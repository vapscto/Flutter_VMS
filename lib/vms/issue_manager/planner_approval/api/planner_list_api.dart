import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/dr_not_approved_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_list_model.dart';

class PlannerListAPI {
  PlannerListAPI.init();
  static final PlannerListAPI instance = PlannerListAPI.init();
  plannerListAPI({
    required String base,
    required PlannerApprovalController plannerApprovalController,
    required int userId,
    required int miId,
    required int roleId,
  }) async {
    var dio = Dio();
    var url = 'https://vmsissuemanager.azurewebsites.net/${URLS.plannerList}';
    try {
      plannerApprovalController.plannerLoading(true);
      var response = await dio.post(url,
          options: Options(headers: getSession()),
          data: {"IVRMRT_Id": 11, "UserId": 60933, "MI_Id": 17});
      if (response.statusCode == 200) {
        PlannerListModel plannerListModel =
            PlannerListModel.fromJson(response.data['get_plannerlist']);
        DrNotApprovedModel drNotApprovedModel =
            DrNotApprovedModel.fromJson(response.data['drnotapprovedmessage']);
        plannerApprovalController.getPlanner(
            plannerListModel.values!, drNotApprovedModel.values!);
        plannerApprovalController.plannerLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
