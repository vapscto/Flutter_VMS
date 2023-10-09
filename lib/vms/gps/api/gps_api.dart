import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/gps/model/gps_result_model.dart';

Future<bool> feacthGpsClient( {
  required latitude,
  required logitude,
  required GetEmpDetailsController  controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =  "";

  try {
    final Response response = await ins.request(apiUrl,
        options: Options(headers: getSession()),
         );
    GpsResult result = GpsResult.fromJson(response.data['formatted']);
  controller.getGpsLocation.value = result.formatted.toString();
    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    return false;
  }
}
