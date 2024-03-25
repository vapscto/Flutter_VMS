import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';

Future<void> saveDemoResponse(
    {required String base,
    required List<Map<String, dynamic>> saveDataList,
    required BuildContext context}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getSaveDemoResponse;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
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
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: saveDataList);
    if (response.data['return'] == "Update") {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
