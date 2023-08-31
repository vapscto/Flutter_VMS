import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/forgotpassword/model/verify_user_model.dart';
import 'package:m_skool_flutter/main.dart';

class VerifyUserNameApi {
  VerifyUserNameApi.init();
  static final VerifyUserNameApi instance = VerifyUserNameApi.init();

  Future<VerifyUserNameModel> verifyUserName({
    required int miId,
    required String userName,
    required String base,
  }) async {
    final String apiURL = base + URLS.verifyUser;
    final Dio dio = getGlobalDio();
    try {
      final Response response = await dio.post(
        apiURL,
        options: Options(headers: getSession()),
        data: {
          "username": userName,
        },
      );
      final VerifyUserNameModel verifyUserNameModel =
          VerifyUserNameModel.fromJson(response.data);

      if (response.statusCode != 200) {
        return Future.error({
          {
            "errorTitle": "Request not fullfill successfully",
            "errorMsg":
                "Currently server is not fullfilling the request successfully, try again after some time.",
          }
        });
      }

      if (verifyUserNameModel.userNameVerifyStatus!.toLowerCase() == "fail") {
        return Future.error({
          "errorTitle": "UserName not Verified",
          "errorMsg":
              "No account associated with this particular username,check and try again",
        });
      }

      return Future.value(verifyUserNameModel);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server not reachable",
        "errorMsg":
            "We are unable to connect to server right now or server is returing error, try again after some time.",
      });
    }
  }
}
