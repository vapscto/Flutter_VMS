import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class VersionControlApi {
  VersionControlApi.init();
  static final VersionControlApi instance = VersionControlApi.init();

  Future<bool> checkVersionAndShowUpgrade({
    required int miId,
    required String version,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    String api = base + URLS.versionControl;
    logger.d(api);
    logger.d({
      "MI_Id": miId,
      "version": version,
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "version": version,
      });

      if (response.data['versiondetailslist'] == null) {
        return Future.value(false);
      }

      if ((response.data['versiondetailslist']['\$values'] as List).isEmpty) {
        return Future.value(false);
      }
      logger.d("message");
      return Future.value(true);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      return Future.value(false);
    }
  }
}
