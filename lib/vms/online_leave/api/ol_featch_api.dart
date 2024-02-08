import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/optional_leave_model.dart';

Future<void> getOptionalLeave(
    {required int miId,
    required int userId,
    required int asmayId,
    required String base,
    required OpetionLeaveController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.appliedLeaves;
  logger.e(apiUrl);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId, "asmay_id": asmayId});
    OpetionLeaveModel olList =
        OpetionLeaveModel.fromJson(response.data['optionalleavedata']);
    controller.getOptionalLeave(olList.values!);
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e);
  }
}
