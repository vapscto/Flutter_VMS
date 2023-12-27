import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class SaveTADAAPI {
  SaveTADAAPI.init();
  static final SaveTADAAPI instance = SaveTADAAPI.init();

  saveTADA({required Map<String, dynamic> body, required String base}) async {
    var dio = Dio();
    var url = base + URLS.tadaSave;
    logger.d(body);
    logger.i(url);
    try {
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
        data: body,
      );

      if (response.statusCode == 200) {
        if (response.data['returnvalue'] == true) {
          Fluttertoast.showToast(msg: "Success");
          if (int.parse(response.data['VTADAAA_TotalSactionedAmount']) > 0) {
            Fluttertoast.showToast(msg: "TADA Saved Successfully");
          } else {
            Fluttertoast.showToast(msg: 'TADA Advance Rejected Successfully');
          }
        } else {
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
