import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_count_model.dart';
 
 
Future<void> getLeaveCount({
    required int miId,
    required int userId,
    required int asmayId,
    required String base,
    required OpetionLeaveController controller
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl =  "https://vmsstaging.vapssmartecampus.com:40013/" + URLS.leaveCountList;
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "UserId": userId,
        "asmay_id": asmayId
   });
     logger.d(apiUrl);
     LeaveCountModel   leaveCountModel = LeaveCountModel.fromJson(response.data['leave_name']);
     controller.leaveCountList.addAll(leaveCountModel.values!);
     } on DioError catch (e) {
     logger.e(e.message); 
    } on Exception catch (e) {
     logger.e(e);
    }
  }