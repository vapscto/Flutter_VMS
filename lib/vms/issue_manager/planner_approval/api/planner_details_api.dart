import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_approval_model.dart';

class PlannerDetailsAPI {
  PlannerDetailsAPI.init();
  static final PlannerDetailsAPI instance = PlannerDetailsAPI.init();
  plannerDetails({
    required String base,
    required PlannerApprovalController plannerApprovalController,
    required String roleFlag,
    required bool flag,
    required int userId,
    required int ismmacId,
    required int miId,
    required int completedCount,
    required int ivrmrtId,
    required int asmayId,
    required double effort,
    required int ismtplId,
  }) async {
    var url = base + URLS.plannerApprovelist;
    var dio = Dio();
    try {
      plannerApprovalController.approvalLoading(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "ISMMAC_Id": ismmacId,
        "MI_Id": miId,
        "completdcount": completedCount,
        "Role_flag": "S",
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
        "ISMTCRASTO_EffortInHrs": effort,
        "ISMTCRASTO_ActiveFlg": flag,
        "ISMTPL_Id": ismtplId
      });
      if (response.statusCode == 200) {
        PlannerApprovalListModel plannerApprovalListModel =
            PlannerApprovalListModel.fromJson(
                response.data['get_plannerdetails']);
        plannerApprovalController
            .getPlannerList(plannerApprovalListModel.values!);
        plannerApprovalController.approvalLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
