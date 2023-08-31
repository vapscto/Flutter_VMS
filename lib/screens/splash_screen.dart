import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/authenticate_user_api.dart';
import 'package:m_skool_flutter/apis/institutional_code_api.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/forgotpassword/screens/change_expired_password.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/institutional_code_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/common_home_screen.dart';
import 'package:m_skool_flutter/screens/institutional_login.dart';
import 'package:m_skool_flutter/screens/login_screen.dart';
import 'package:m_skool_flutter/screens/on_board.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MskoolController mskoolController = Get.put(MskoolController());
  String deviceToken = '';
  late FirebaseMessaging messaging;
  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    // institutionalCode!.delete("institutionalCode");

    super.initState();
  }

  getDeviceTokenForFCM(
      {required LoginSuccessModel loginSuccessModel,
      required MskoolController mskoolController}) async {
    deviceToken = await getDeviceToken();
    logger.d('Device Id : $deviceToken');
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        logger.d(message.data);
        logger.d(message.notification);
        logger.d(message.notification!.body);
        logger.d(message.notification!.title);

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
        // notificationController.getNotificationsCount();
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
      // AuthenticationController().loginVerification(fcmToken: token ?? "").then(
      // (value) async {
      // await checkVersionPermission();
      // notificationController.getNotificationsCount();
      messaging.getInitialMessage().then((message) async {
        if (message != null) {
          pushNotificationNavigator(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController);
          logger.d(message.data);
        }
      });
      initializeFCMNotification().then((value) => null);
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

  @override
  Widget build(BuildContext context) {
    //InstitutionalCodeApi.instance.loginWithInsCode("DEMOBGH");
    CustomThemeData.changeStatusBarColor(context);
    // version();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: FutureBuilder<Widget>(
            future: handleAuth(),
            builder: (context, snapshot) {
              // if (snapshot.hasData) {
              //   if (snapshot.data!.get("institutionalCode") == null) {
              //     return const InstitutionalLogin();
              //   }
              //   return LoginScreen();
              // }

              if (snapshot.hasData) {
                return snapshot.data!;
              }
              if (snapshot.hasError) {
                dynamic err = snapshot.error;

                if (err['type'] != null &&
                    err['type'] == "exp" &&
                    err['userName'] != null) {
                  return Center(
                    child: Container(
                        margin: const EdgeInsets.all(24.0),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Remainder",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/svg/remainder.svg",
                              height: 100,
                            ),
                            const Text(
                                "Your password is expired!\nReset password now "),
                            const SizedBox(
                              height: 12.0,
                            ),
                            MSkollBtn(
                              onPress: () {
                                final MskoolController mskoolController =
                                    Get.find<MskoolController>();
                                Get.offAll(ResetExpiredPassword(
                                  fromSplash: "yes",
                                  base: baseUrlFromInsCode(
                                      "login", mskoolController),
                                  userName: err['userName'],
                                  mskoolController: mskoolController,
                                ));
                              },
                              title: 'Update Password',
                            ),
                          ],
                        )),
                  );
                  // return ErrWidget(
                  //   err: err,
                  //   btnTitle: "Update Password",
                  //   onPressed: () {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (_) {
                  //       return ResetExpiredPassword(
                  //           base: baseUrlFromInsCode("login", mskoolController),
                  //           userName: err['userName']);
                  //     }));
                  //   },
                  // );
                }
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          err['errorTitle'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                                const TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          err['errorMsg'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(color: Colors.white),
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }

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
                      "M Skool",
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
      String loginBaseUrl = "";
      for (int i = 0; i < codeModel.apiarray.values.length; i++) {
        final CategoriesApiItem apiItem =
            codeModel.apiarray.values.elementAt(i);
        if (apiItem.iivrscurLAPIName.toLowerCase() == "login") {
          loginBaseUrl = apiItem.iivrscurLAPIURL;
        }
      }
      final LoginSuccessModel loginSuccessModel = await AuthenticateUserApi
          .instance
          .authenticateNow(userName, password, miId, loginBaseUrl, deviceToken);
      mskoolController.updateLoginSuccessModel(loginSuccessModel);
      getDeviceTokenForFCM(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController);

      logger.d(loginSuccessModel.roleId);

      // if (loginSuccessModel.roleforlogin!.toLowerCase() ==
      //         URLS.staff.toLowerCase() ||
      //     loginSuccessModel.roleforlogin!.toLowerCase() ==
      //         URLS.hod.toLowerCase()) {
      //   return Future.value(StaffHomeScreen(
      //       loginSuccessModel: loginSuccessModel,
      //       mskoolController: mskoolController));
      // }

      // if (loginSuccessModel.roleforlogin!.toLowerCase() ==
      //     URLS.manager.toLowerCase()) {
      //   return Future.value(ManagerHome(
      //     loginSuccessModel: loginSuccessModel,
      //     mskoolController: mskoolController,
      //   ));
      // }

      // if (loginSuccessModel.roleforlogin!.toLowerCase() ==
      //     URLS.student.toLowerCase()) {
      //   return Future.value(Home(
      //     loginSuccessModel: loginSuccessModel,
      //     mskoolController: mskoolController,
      //   ));
      // }

      // return Future.value(Center(
      //   child: Scaffold(
      //     body: Center(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           const Text("This app is not used to manage this ID"),
      //           Padding(
      //             padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      //             child: SizedBox(
      //               width: 180,
      //               height: 40,
      //               child: CustomElevatedButton(
      //                   isGradient: false,
      //                   boxShadow: const BoxShadow(),
      //                   color: const Color(0xFFFFDFD6),
      //                   child: Row(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: const [
      //                         Icon(
      //                           Icons.logout,
      //                           color: Color(0xffF24E1E),
      //                         ),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         Text(
      //                           "Log Out",
      //                           style: TextStyle(
      //                               color: Color(0xffF24E1E),
      //                               fontSize: 16,
      //                               fontWeight: FontWeight.w600),
      //                         )
      //                       ]),
      //                   onPressed: () {
      //                     Get.dialog(const LogoutConfirmationPopup());
      //                   }),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ));
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
