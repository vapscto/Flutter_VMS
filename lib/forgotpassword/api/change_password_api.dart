import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/forgotpassword/model/password_changed_model.dart';
import 'package:m_skool_flutter/main.dart';

class ChangePasswordApi {
  ChangePasswordApi.init();
  static final ChangePasswordApi instance = ChangePasswordApi.init();

  Future<bool> changePassword(
      {required String newPassword,
      required int miId,
      required String userName,
      required String base}) async {
    final Dio dio = getGlobalDio();
    final String apiUrl = base + URLS.changePassword;

    try {
      final Response response = await dio.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "newPassword": newPassword,
          "miId": miId,
          "username": userName,
        },
      );
      final PasswordChangedModel passwordChangedModel =
          PasswordChangedModel.fromJson(response.data);
      if (passwordChangedModel.message!.toLowerCase() == "success") {
        return Future.value(true);
      }

      return Future.error({
        "errorTitle": "Password Change Unsuccessfull",
        "errorMsg": passwordChangedModel.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Password Change Unsuccessfull",
        "errorMsg":
            "Currently we are unable to connect to server, try again later",
      });
    }
  }
}
