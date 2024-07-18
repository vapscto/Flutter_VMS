import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/version_change.dart';

class VersionControlApi {
  VersionControlApi.init();
  static final VersionControlApi instance = VersionControlApi.init();

  Future<VersionChangeModel?> checkVersionAndShowUpgrade({
    required int miId,
    required String version,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    String api = base + URLS.versionControl;

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "version": version,
      });
      if (response.statusCode == 200) {
        VersionChangeModel versionChangeModel =
            VersionChangeModel.fromJson(response.data['versiondetailslist']);
        return versionChangeModel;
      }

      logger.d("message");
    } on DioError catch (e) {
      logger.e(e.stackTrace);
    }
    return null;
  }
}
