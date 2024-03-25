import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';

Future<void> saveDemoResponse(
    {required String base,
    required int mIId,
    required int userId,
    required List<Map<String, dynamic>> saveDataList,
    required String latitude,
    required String longitude,
    required BuildContext context}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getSaveDemoResponse;

  try {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            child: Center(
              child: Text(
                "Please wait...",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .merge(const TextStyle(fontSize: 16)),
              ),
            ),
          ),
        );
      },
    );
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": mIId,
      "UserId": userId,
      "product_demo_master_temp2": saveDataList,
      "ILRR_Lat": latitude,
      "ILRR_Long": longitude,
    });
    // logger.i(apiUrl);
      logger.d( {
       "MI_Id": mIId,
      "UserId": userId,
      "product_demo_master_temp2": saveDataList,
      "ILRR_Lat": latitude,
      "ILRR_Long": longitude,
      });
      logger.i(response);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
