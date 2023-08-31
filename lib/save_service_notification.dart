import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class SaveServiceNotification {
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializeNotification() {
    localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(
            // requestAlertPermission: true,
            // requestSoundPermission: true,
            ),
      ),
      onDidReceiveBackgroundNotificationResponse: onReceiveNotification,
      onDidReceiveNotificationResponse: onReceiveNotification,
    );
  }

  static Future<void> onReceiveNotification(
      NotificationResponse message) async {
    if (message.payload == null) {
      return;
    }

    String filepath = message.payload!;
    logger.d(filepath);
    await OpenFilex.open(filepath);
  }

  static Future<String> getStoragePathAndSave(
      Uint8List bytes, String fileTitle) async {
    List<Directory>? directory =
        await getExternalStorageDirectories(type: StorageDirectory.pictures);

    String path = directory!.first.path;

    String fileName = "$fileTitle${DateTime.now().microsecondsSinceEpoch}.pdf";
    File file2 = File('$path/$fileName');
    await file2.writeAsBytes(bytes, flush: true);
    return file2.path;
  }

  static void showSaveNotification(String filePath, String title, String body) {
    localNotificationsPlugin.show(
      42500,
      title.capitalize,
      body.capitalize,
      const NotificationDetails(
        android: AndroidNotificationDetails("Download001", "File Download",
            styleInformation: BigTextStyleInformation("")),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          sound: "slow_spring_board.aiff",
        ),
      ),
      payload: filePath,
    );
  }

  static void showProgressNotification(num progress) {
    localNotificationsPlugin.show(
      42500,
      "Downloading File",
      "",
      NotificationDetails(
        android: AndroidNotificationDetails("Download001", "File Download",
            styleInformation: const BigTextStyleInformation(""),
            maxProgress: 100,
            progress: progress.toInt()),
        iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            sound: "slow_spring_board.aiff"),
      ),
    );
  }
}
