import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<bool> feacthGpsClient({
  required String base,
  required int userId,
  required int miId,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.gpsFeacth;

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId});

    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    return false;
  }
}
