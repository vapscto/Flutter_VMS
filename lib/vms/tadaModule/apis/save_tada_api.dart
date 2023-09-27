import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';

class SaveTADAAPI {
  SaveTADAAPI.init();
  static final SaveTADAAPI instance = SaveTADAAPI.init();

  saveTADA({required Map<String, dynamic> body, required String base}) async {
    var dio = Dio();
    var url = 'https://vmsstaging.vapssmartecampus.com:40015/${URLS.tadaSave}';
    try {
      var response = await dio.post(
        url,
        data: body,
      );
      logger.d(body);
      logger.i(response.data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "TADA Saved Successfully");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
