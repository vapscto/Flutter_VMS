import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/online_leave/model/applied_leave_model.dart';

class GetAppliedLeave {
  GetAppliedLeave.init();
  static final GetAppliedLeave instance = GetAppliedLeave.init();

  Future<List<AppliedLeaveModelValues>> getAppliedLeave({
    required int miId,
    required int userId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.appliedLeaves;
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "UserId": userId,
      });

      final AppliedLeaveModel leaveModel =
          AppliedLeaveModel.fromJson(response.data['leave_name']);

      return Future.value(leaveModel.values);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);

      return Future.error({
        "errorTitle": "An error occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "An error occured",
        "errorMsg":
            "An internal error occured while trying to create a view for you.",
      });
    }
  }
}
