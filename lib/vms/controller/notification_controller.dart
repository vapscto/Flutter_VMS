import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/model/vms_notification_model.dart';

class NotificationController extends GetxController {
  RxBool isNotificationLoadig = RxBool(false);
  void notificationLoading(bool loading) {
    isNotificationLoadig.value = loading;
  }

  RxList<NotificationListModelValues> notificationList =
      <NotificationListModelValues>[].obs;
  void getNotification(List<NotificationListModelValues> notification) {
    if (notificationList.isNotEmpty) {
      notificationList.clear();
    }
    for (int i = 0; i < notification.length; i++) {
      notificationList.add(notification.elementAt(i));
    }
  }
}
