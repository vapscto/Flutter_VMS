import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/model/vms_notification_model.dart';

class VMSPushNotification {
  VMSPushNotification.init();
  static final VMSPushNotification instance = VMSPushNotification.init();

  Future<List<NotificationListModelValues>> getAllNotification({
    required int miId,
    required int asmayId,
    required int userId,
    required int ivrmrtId,
    required String flag,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.vMSNotification;
    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
          "UserId": userId,
          "Role_flag": flag,
          "IVRMRT_Id": ivrmrtId
        },
      );

      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": flag,
        "IVRMRT_Id": ivrmrtId
      });

      if (response.data['get_feedbacklist'] == null) {
        return Future.error({
          "errorTitle": "Unexpected error occured",
          "errorMsg":
              "There are no getVMSPushNotifications array in the api .... contact your tech team",
        });
      }

      final NotificationListModel notificationDataModel =
          NotificationListModel.fromJson(response.data['get_feedbacklist']);
      return Future.value(notificationDataModel.values);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected error occured",
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
