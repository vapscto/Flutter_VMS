import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/completed_task_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/dr_not_approved_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/leave_approve_popup_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_list_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_status_model.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/leave_approval_model.dart';

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
    var url = base + URLS.plannerList;
    try {
      plannerApprovalController.plannerLoading(true);
      var response = await dio.post(url,
          options: Options(headers: getSession()),
          data: {"IVRMRT_Id": roleId, "UserId": userId, "MI_Id": miId});
      logger.i({"IVRMRT_Id": roleId, "UserId": userId, "MI_Id": miId});
      logger.i(url);
      if (response.statusCode == 200) {
        logger.i(response.data['get_plannerlist']);

        if (response.data['get_leaveDetails'] != null) {
          LeaveApprovePopUp? leaveApprovePopUp =
              LeaveApprovePopUp.fromJson(response.data['get_leaveDetails']);

          plannerApprovalController.leavePopUp
              .addAll(leaveApprovePopUp.values!);
        }

        // logger.d(response.data['get_leaveDetails']);

        // plannerApprovalController.leavePopUp = response.data['get_leaveDetails'];

        PlannerListModel plannerListModel =
            PlannerListModel.fromJson(response.data['get_plannerlist']);
        DrNotApprovedModel drNotApprovedModel =
            DrNotApprovedModel.fromJson(response.data['drnotapprovedmessage']);
        PlannerStatusModelList plannerStatusModel =
            PlannerStatusModelList.fromJson(
                response.data['get_updatedplannerlist']);

        plannerApprovalController.getStatus(plannerStatusModel.values!);
        plannerApprovalController.getPlanner(
            plannerListModel.values!, drNotApprovedModel.values!);
        plannerApprovalController.completedCount =
            response.data['completdcount'] ?? 0;
        plannerApprovalController.ivrmrtId = response.data['ivrmrT_Id'] ?? 0;
        plannerApprovalController.effort =
            response.data['ismtcrastO_EffortInHrs'] ?? 0.0;
        plannerApprovalController.ismmcId = response.data['ismmaC_Id'] ?? 0;
        plannerApprovalController.flag = response.data['ismtcrastO_ActiveFlg'];
        plannerApprovalController.hrmdId = response.data['hrmD_Id'] ?? 0;
        if (response.data['completedcreatedbyme'] != null) {
          CompletedTaskCountModel completedTaskCountModel =
              CompletedTaskCountModel.fromJson(
                  response.data['completedcreatedbyme']);
          plannerApprovalController.completeTaskCount
              .addAll(completedTaskCountModel.values!);
        }
        plannerApprovalController.plannerLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
