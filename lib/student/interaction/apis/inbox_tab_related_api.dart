import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import '../model/inbox_model.dart';

var dio = Dio();
Future<InboxDataModel?> getInboxData({
  required int miId,
  required int amstId,
  required int asmayId,
  required int userId,
  required int roleId,
  required String role,
  required String base,
}) async {
  var url = base + URLS.getInboxData;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "AMST_Id": amstId,
        "ASMAY_Id": asmayId,
        "Role_flag": "I",
        "IVRMRT_Id": roleId,
        "IVRMRT_Role": role,
        "userId": userId
      },
    );
    if (response.statusCode == 200) {
      InboxDataModel inboxDataModel = InboxDataModel.fromJson(response.data);
      return inboxDataModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
