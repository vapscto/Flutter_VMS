import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/gps/model/gps_result_model.dart';

Future<bool> feacthGps({
  required latitude,
  required logitude,
  required GetEmpDetailsController controller,
}) async {
  final Dio ins = getGlobalDio();
  controller.updateMapLoading(true);
  String apiUrl =
      "https://api.opencagedata.com/geocode/v1/json?q=$latitude+$logitude&key=bbb18659a9b24fb1889a430863a2abbb&q&pretty=1";
  logger.d(apiUrl);
  try {
    final Response response = await ins.request(
      apiUrl,
      options: Options(headers: getSession()),
    );

    for (int i = 0; i < response.data['results'].length; i++) {
      GetGpsLocation result =
          GetGpsLocation.fromJson(response.data['results'][i]);
      controller.getGpsLocation.value = result.formatted!;
      logger.d(result.formatted!);
    }

    controller.updateMapLoading(false);
    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    controller.updategpsErrorLoading(true);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updategpsErrorLoading(true);
    return false;
  }
}
