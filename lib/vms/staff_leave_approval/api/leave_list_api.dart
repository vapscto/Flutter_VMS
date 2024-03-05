import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/controller/leave_approve_controller.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/leave_approval_model.dart';

class GetAppliedLeavesApi {
  GetAppliedLeavesApi.init();
  static final GetAppliedLeavesApi instance = GetAppliedLeavesApi.init();

  getAppliedLeaves({
    required String base,
    required int miId,
    required int loginId,
    required LeaveApproveController leaveApproveController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getLeaves;
    logger.d(api);
    try {
      leaveApproveController.leaveLoading(true);
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "LoginId": loginId,
      });
      if (response.statusCode == 200) {
        if (response.data['get_leavestatus'] != null) {
          LeaveApprovalModel appliedLeaves =
              LeaveApprovalModel.fromJson(response.data['get_leavestatus']);
          leaveApproveController.getLeaves(appliedLeaves.values!);
        }

        leaveApproveController.leaveLoading(false);
      }

      if (response.data['get_leavestatus'] == null) {
        return Future.error({
          "errorTitle": "No Leave Found",
          "errorMsg": "There are no leave available to show, or may be deleted"
        });
      }
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "Server Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "An internal error occured while trying to create a view for you",
      });
    }
  }
}
