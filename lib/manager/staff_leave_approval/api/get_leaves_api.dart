import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/model/leave_approval_model.dart';

class GetAppliesLeavesApi {
  GetAppliesLeavesApi.init();
  static final GetAppliesLeavesApi instance = GetAppliesLeavesApi.init();

  Future<List<LeaveApprovalModelValues>> getAppliedLeaves({
    required String base,
    required int miId,
    required int loginId,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getLeaves;
    logger.d(api);
    try {
      final Response response = await ins.post(api, options: Options(), data: {
        "MI_Id": miId,
        "LoginId": loginId,
      });

      if (response.data['get_leavestatus'] == null) {
        return Future.error({
          "errorTitle": "No Leave Found",
          "errorMsg": "There are no leave available to show, or may be deleted"
        });
      }

      final LeaveApprovalModel appliedLeaves =
          LeaveApprovalModel.fromJson(response.data['get_leavestatus']);

      return Future.value(appliedLeaves.values);
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
