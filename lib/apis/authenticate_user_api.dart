import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';

class AuthenticateUserApi {
  AuthenticateUserApi.init();
  static AuthenticateUserApi instance = AuthenticateUserApi.init();

  Future<LoginSuccessModel> authenticateNow(
    String userName,
    String password,
    int miId,
    String loginBaseUrl,
    String mobiledeviceid,
  ) async {
    final Dio ins = getGlobalDio();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String loginApiUrl = loginBaseUrl + URLS.login;
    String mobileUniqueID = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
      mobileUniqueID = deviceInfo.id;
      //debugPrint(deviceInfo.toString());
    } else {
      IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo.identifierForVendor!;
    }

    if (mobiledeviceid.isEmpty) {
      mobiledeviceid = await getDeviceToken();
    }

    Response response = await ins.post(loginApiUrl, data: {
      "MI_Id": miId,
      "username": userName,
      "password": password,
      "Logintype": "Mobile",
      "mobiledeviceid": mobiledeviceid,
    });

    if (response.data['message'] != null) {
      if (response.data['message'] == "expired") {
        // gT.Get.dialog(
        //   Dialog(
        // child: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     children: [
        //       const Text(
        //         "Remainder",
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 20.0,
        //         ),
        //       ),
        //       SvgPicture.asset(
        //         "assets/svg/remainder.svg",
        //         height: 100,
        //       ),
        //       const Text("Your password is expired!\nReset password now "),
        //       const SizedBox(
        //         height: 12.0,
        //       ),
        //       MSkollBtn(
        //         onPress: () {
        //           final MskoolController mskoolController =
        //               gT.Get.find<MskoolController>();
        //           gT.Get.offAll(ResetPassword(
        //             mskoolController: mskoolController,
        //             loginSuccessModel:
        //                 mskoolController.loginSuccessModel!.value,
        //           ));
        //         },
        //         title: 'Update Password',
        //       ),
        //     ],
        //   ),
        //     ),
        //   ),
        // );

        return Future.error({
          "errorTitle": "Password Expired",
          "type": "exp",
          "errorMsg":
              "Hello! $userName your password is expired you need to update the password before continuing further",
          "userName": userName,
        });
      }

      // if (response.data['staffanalyticalprivileges'] == null) {
      //   return Future.error({
      //     "errorTitle": "Staff Analytical Privileges not mapped",
      //     "type": "oth",
      //     "errorMsg":
      //         "Staff Analytics Privlages Not found, we can't open dashboard",
      //     "userName": userName,
      //   });
      // }

      return Future.error({
        "errorTitle": response.data['message'],
        "type": "oth",
        "errorMsg": "I think your${response.data['message']}.",
      });
    }

    final LoginSuccessModel loginSuccessModel =
        LoginSuccessModel.fromJson(response.data);
    //logger.d(loginSuccessModel.toJson());
    // logger.d(response.data);

    logger.d(loginSuccessModel.roleId);
    cookieBox!.put("cookie", response.headers.map['set-cookie']![0]);
    await importantIds!.put(URLS.miId, loginSuccessModel.mIID);
    await importantIds!.put(URLS.userId, loginSuccessModel.userId);

    await importantIds!.put(URLS.asmayId, loginSuccessModel.asmaYId);
    await importantIds!.put(URLS.ivrmrtId, 0);
    await importantIds!.put(URLS.amstId, loginSuccessModel.amsTId);
    await logInBox!.put("userName", userName);
    await logInBox!.put("password", password);
    // await logInBox!.put("logBasUrl", loginBaseUrl);
    return Future.value(loginSuccessModel);
  }

  Future getDeviceToken() async {
    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessage.getToken();
    logger.d(deviceToken);
    return (deviceToken == null) ? "" : deviceToken;
  }
}
