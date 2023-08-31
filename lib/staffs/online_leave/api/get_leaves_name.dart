import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/online_leave/model/leave_name_model.dart';

class GetLeaveNameApi {
  GetLeaveNameApi.init();
  static GetLeaveNameApi instance = GetLeaveNameApi.init();

  Future<List<LeaveNamesModelValues>> getLeaves({
    required int miId,
    required int userId,
    required String base,
  }) async {
    String api = base + URLS.getLeaveName;
    final Dio ins = getGlobalDio();
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "UserId": userId,
      });
      if (response.data['leave_name'] == null) {
        return Future.error({
          "errorTitle": "No Leaves Found",
          "errorMsg":
              "Sorry but we didn't find any leave which you can apply, it is deleted from db ask them to add leaves array",
        });
      }
      final LeaveNamesModel leaveNames =
          LeaveNamesModel.fromJson(response.data['leave_name']);

      return Future.value(leaveNames.values);
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
