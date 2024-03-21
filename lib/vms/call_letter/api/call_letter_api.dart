import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class CallLetterAPI {
  CallLetterAPI.init();
  static final CallLetterAPI i = CallLetterAPI.init();
  var dio = Dio();
}

Future<String?> generateCallLetter(
    {required String base, required int updateBy}) async {
  var dio = Dio();
  var api = base + URLS.generateTemplate;
  try {
    var response = await dio.post(api,
        data: {"HRCD_UpdatedBy": updateBy},
        options: Options(headers: getSession()));
    logger.w(response.data);
    logger.v({"HRCD_UpdatedBy": updateBy});
    logger.i(api);
    return response.data['retrunMsg'];
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
  return null;
}
