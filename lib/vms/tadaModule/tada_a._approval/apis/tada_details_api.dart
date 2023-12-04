import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/edit_array_tada.dart';
import '../model/time_array_tada.dart';

class TADADetailsAPI {
  TADADetailsAPI.init();

  static final TADADetailsAPI instance = TADADetailsAPI.init();

  tadaDetails(
      {required String base,
      required int userId,
      required TADAController tadaController,
      required int vtaDaaaId}) async {
    final dio = Dio();
    var url2 = base + URLS.tadaDetails;

    try {
      if (tadaController.isErrorOccured.value) {
        tadaController.updateIsErrorOccured(false);
      }

      tadaController.updateIsLoading(true);

      var response = await dio.post(url2,
          data: {"UserId": userId, "VTADAAA_Id": vtaDaaaId},
          options: Options(headers: getSession()) //60064 71
          );
      logger.i(url2);
      logger.i({"UserId": userId, "VTADAAA_Id": vtaDaaaId});
      if (response.statusCode == 200) {
        logger.d(response.data);
        TimeArrayTADAData timeArrayDADADataValues =
            TimeArrayTADAData.fromJson(response.data['timeArray']);
        tadaController.getTimeArray(timeArrayDADADataValues.values!);

        EditArrayTADAData editArrayTADAData =
            EditArrayTADAData.fromJson(response.data['editArray']);
        tadaController.getEditArray(editArrayTADAData.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
