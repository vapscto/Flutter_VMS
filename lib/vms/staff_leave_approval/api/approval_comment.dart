import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/controller/leave_approve_controller.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/approval_comment_model.dart';

class LeaveApprovalCummentAPI {
  LeaveApprovalCummentAPI.init();
  static LeaveApprovalCummentAPI instance = LeaveApprovalCummentAPI.init();

  getLeavesComment({
    required int miId,
    required String base,
    required int userId,
    required String hrelapId,
    required int hrmeId,
    required LeaveApproveController leaveApproveController,
  }) async {
    String api = base + URLS.leaveApprovalComment;
    final Dio ins = getGlobalDio();
    try {
      leaveApproveController.dataLoading(true);
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "HRELAP_Id": hrelapId,
            "HRME_Id": hrmeId,
            "MI_Id": miId,
            "LoginId": userId
          });
      logger.e(api);
      logger.e({
        "HRELAP_Id": hrelapId,
        "HRME_Id": hrmeId,
        "MI_Id": miId,
        "LoginId": userId
      });

      if (response.statusCode == 200) {
        if (response.data['commentlist'] == null) {
          return Future.error({
            "errorTitle": "No Leaves Found",
            "errorMsg":
                "Sorry but we didn't find any leave which you can apply, it is deleted from db ask them to add leaves array",
          });
        }
        final ApprovalCommentModel leaveNames =
            ApprovalCommentModel.fromJson(response.data['commentlist']);
        leaveApproveController.dataLoading(false);
        leaveApproveController.getLeaveData(leaveNames.values!);
      }
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "Unexpected error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected error Occured",
        "errorMsg":
            "An internal error occured while trying to create a view for you",
      });
    }
  }
}
