import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/authenticate_user_api.dart';
import 'package:m_skool_flutter/apis/institutional_code_api.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/institutional_code_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/common_home_screen.dart';
import 'package:m_skool_flutter/screens/institutional_login.dart';
import 'package:m_skool_flutter/screens/login_screen.dart';
import 'package:m_skool_flutter/screens/on_board.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/profile/api/profile_api.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  final int miIdNew;
  const SplashScreen({super.key, required this.miIdNew});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MskoolController mskoolController = Get.put(MskoolController());
  final GetEmpDetailsController controller = Get.put(GetEmpDetailsController());
  late FirebaseMessaging messaging;
  late FirebaseMessaging firebaseMessage;
  Future getDeviceToken() async {
    String deviceToken = '';
    firebaseMessage = FirebaseMessaging.instance;
    await firebaseMessage.getToken().then((value) {
      (value == null) ? "" : deviceToken = value;
      deviceid = deviceToken;
    });
    return deviceToken;
  }

  // Future<void> requestLocationPermission() async {
  //   final status = await Permission.location.request();
  //   if (status.isGranted) {
  //   } else if (status.isDenied) {
  //     await Permission.location.request();
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    initializeFCMNotification();
    // requestLocationPermission();
    getDeviceToken();
    controller.getLocation();
    super.initState();
  }

  getDeviceTokenForFCM(
      {required LoginSuccessModel loginSuccessModel,
      required MskoolController mskoolController}) async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        var initializationSettingsAndroid =
            const AndroidInitializationSettings('@mipmap/launcher_icon');
        var initializationSettingsIOS = const DarwinInitializationSettings();
        var initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
        flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveBackgroundNotificationResponse: notificationCallback,
          onDidReceiveNotificationResponse: notificationCallback,
        );
        RemoteNotification? notification = message.notification;
        AndroidNotificationChannel channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          importance: Importance.high,
        );
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          styleInformation: const BigTextStyleInformation(''),
          icon: "@mipmap/launcher_icon",
        );
        var iOSPlatformChannelSpecifics =
            const DarwinNotificationDetails(sound: "slow_spring_board.aiff");
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      },
    );
    messaging.getToken().then((token) async {
      messaging.getInitialMessage().then((message) async {
        if (message != null) {
          pushNotificationNavigator(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController);
          logger.d(message.data);
        }
      });
      initializeFCMNotification().then((value) => null);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          messaging = FirebaseMessaging.instance;
          pushNotificationNavigator(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController);
        },
      );
    });
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

  @override
  Widget build(BuildContext context) {
    CustomThemeData.changeStatusBarColor(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: FutureBuilder<Widget>(
            future: handleAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              }
              if (snapshot.hasError) {}

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 36,
                      child: Icon(
                        Icons.school_outlined,
                        size: 46,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Vaps Management System",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(fontSize: 30.0, color: Colors.white)),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<Widget> handleAuth() async {
    try {
      if (logInBox!.get("firstOpened") == null ||
          logInBox!.get("firstOpened") == true) {
        logInBox!.put("firstOpened", false);
        return OnBoardScreen(
          mskoolController: mskoolController,
        );
      }
      if (institutionalCode!.get("institutionalCode") == null) {
        return Future.value(
          InstitutionalLogin(
            mskoolController: mskoolController,
          ),
        );
      }
      final InstitutionalCodeModel codeModel = await InstitutionalCodeApi
          .instance
          .loginWithInsCode(institutionalCode!.get("institutionalCode"), true);
      mskoolController.updateUniversalInsCodeModel(codeModel);
      if (logInBox!.get("isLoggedIn") == null || !logInBox!.get("isLoggedIn")) {
        return Future.value(LoginScreen(
          mskoolController: mskoolController,
        ));
      }
      String userName = logInBox!.get("userName");
      String password = logInBox!.get("password");
      int miId = importantIds!.get(URLS.miId);
      logger.v(miId);
      // ignore: unused_local_variable
      String loginBaseUrl = "";
      for (int i = 0; i < codeModel.apiarray.values.length; i++) {
        final CategoriesApiItem apiItem =
            codeModel.apiarray.values.elementAt(i);
        if (apiItem.iivrscurLAPIName.toLowerCase() == "login") {
          loginBaseUrl = apiItem.iivrscurLAPIURL;
        }
      }
      final LoginSuccessModel loginSuccessModel =
          await AuthenticateUserApi.instance.authenticateNow(
              userName,
              password,
              (widget.miIdNew == 0) ? miId : widget.miIdNew,
              loginBaseUrl,
              deviceid);

      mskoolController.updateLoginSuccessModel(loginSuccessModel);
      ProfileController profileController = Get.put(ProfileController());
      await lateIn(
          base: baseUrlFromInsCode("issuemanager", mskoolController),
          miId: loginSuccessModel.mIID!,
          roleId: loginSuccessModel.roleId!,
          controller: profileController,
          userId: loginSuccessModel.userId!);
      getDeviceTokenForFCM(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController);
      return Future.value(CommonHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(
        {
          "errorTitle": "Something went wrong",
          "errorMsg":
              "An error occured in server side, may be currently it is down or page is not available."
        },
      );
    }
  }
}
