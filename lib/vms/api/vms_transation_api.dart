import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/model/transation_config_model.dart';

class VmsTransationAPI {
  VmsTransationAPI.init();
  static final VmsTransationAPI instance = VmsTransationAPI.init();
  getTransation({
    required String base,
    required VmsTransationController vmsTransationController,
    required String userName,
    required String password,
    required int miId,
    required int roleId,
  }) async {
    var dio = Dio();
    var url = base + URLS.logintransation;
    // var url2 =
    //     'https://vmsstaging.vapssmartecampus.com:40002/${URLS.logintransation}';
    try {
      var response = await dio.post(url,
          options: Options(headers: getSession()),
          data: {
            "IVRM_MI_Id": miId,
            "username": userName,
            "password": password,
            "roleId": roleId
          });
      if (response.statusCode == 200) {
        TransationConfigModel transationConfigModel =
            TransationConfigModel.fromJson(response.data['transnumconfig']);
        vmsTransationController
            .getUserTransation(transationConfigModel.values!);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
