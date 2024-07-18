import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/api_url_constants.dart';
import '../controller/global_utilities.dart';
import '../main.dart';
import '../model/success_response_model.dart';
import '../model/success_with_message_model.dart';

class LoginServices {
  static Future<SuccessResponseModel?> login(
      {required String mobileNumber,
      required String passWord,
      required String hashCode}) async {
    var dio = Dio();
    SuccessResponseModel logInData = SuccessResponseModel();
    try {
      Map<String, String> body = {
        "email": mobileNumber,
        "password": passWord,
        "hashCode": hashCode
      };
      final response = await dio.post(
        URLS.base + URLS.userPath + URLS.passWordLogin,
        options: Options(
          headers: getSession(),
        ),
        data: body,
      );
      if (response.statusCode == 200) {
        cookieBox!.put("session", response.headers.map['set-cookie']?[0]);
        logInData = SuccessResponseModel.fromJson(response.data);
        logger.d(response.data);
      }
    } catch (e) {
      isPageLoading.value = false;
      Fluttertoast.showToast(msg: "Something went wrong");
      logger.e(e);
    }
    return logInData;
  }

  static Future<SuccessResponseModel?> signUp(
      {required String firstName,
      required String lastName,
      required String mobileNumber,
      required String email}) async {
    var dio = Dio();
    SuccessResponseModel logInData = SuccessResponseModel();
    try {
      Map<String, String> body = {
        "fname": firstName,
        "lname": lastName,
        "mobileNo": mobileNumber,
        "email": email,
        "userName": mobileNumber,
      };
      final response = await dio.post(URLS.base + URLS.userPath + URLS.signUp,
          data: body,
          options: Options(
            headers: getSession(),
          ));
      if (response.statusCode == 200) {
        logInData = SuccessResponseModel.fromJson(response.data);
      }
    } catch (e) {
      logger.e(e);
    }
    return logInData;
  }

  static Future<SuccessResponseModel?> otpVerification(
      {required String otpValue}) async {
    var dio = Dio();
    SuccessResponseModel logInData = SuccessResponseModel();
    try {
      Map<String, String> body = {"otpVal": otpValue};
      final response =
          await dio.post(URLS.base + URLS.userPath + URLS.otpVerification,
              data: body,
              options: Options(
                headers: getSession(),
              ));
      if (response.statusCode == 200) {
        logInData = SuccessResponseModel.fromJson(response.data);
      }
    } catch (e) {
      logger.e(e);
    }
    return logInData;
  }

  static Future<SuccessWithMessageModel?> logout() async {
    var dio = Dio();
    SuccessWithMessageModel logoutSuccessData = SuccessWithMessageModel();
    var url = URLS.base + URLS.userPath + URLS.loginVerification;
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: getSession(),
        ),
      );
      if (response.statusCode == 200) {
        logoutSuccessData = SuccessWithMessageModel.fromJson(response.data);
      }
    } catch (e) {
      logger.e(e);
    }
    return logoutSuccessData;
  }
}
