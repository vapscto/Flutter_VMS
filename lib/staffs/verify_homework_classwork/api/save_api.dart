import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class SaveApi {
  SaveApi.init();
  static final SaveApi instance = SaveApi.init();

  Future<String> saveNow(
      {required String base,
      required Map<String, dynamic> body,
      required bool forHw}) async {
    final Dio ins = getGlobalDio();
    String api = forHw ? base + URLS.saveVerifyHw : base + URLS.saveVerifyCw;
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: body);

      if (response.statusCode != 200) {
        return Future.error({
          "errorTitle": "Unable to update",
          "errorMsg": "Sorry!! but we are unable to update the marks"
        });
      }

      logger.d(response.data);

      return Future.value("Updated Successfully");
    } on DioError catch (e) {
      return Future.error({
        "errorTitle": "Unable to update",
        "errorMsg": e.message,
      });
    } on Exception {
      return Future.error({
        "errorTitle": "Unable to update",
        "errorMsg": "An Internal error Occured while updating the values",
      });
    }
  }
}
