import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/notification_model.dart';

class PushNotification {
  PushNotification.init();
  static final PushNotification instance = PushNotification.init();

  Future<List<NotificationDataModelValues>> getAllNotification({
    required int miId,
    required int userId,
    required String openFor,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.pushNotification;
    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "userid": userId,
          "flag": openFor,
        },
      );

      logger.d(api);
      logger.d({
        "MI_Id": miId,
        "userid": userId,
        "flag": openFor,
      });

      if (response.data['getpushnotifications'] == null) {
        return Future.error({
          "errorTitle": "Unexpected error occured",
          "errorMsg":
              "There are no getpushnotifications array in the api .... contact your tech team",
        });
      }

      final NotificationDataModel notificationDataModel =
          NotificationDataModel.fromJson(response.data['getpushnotifications']);
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
