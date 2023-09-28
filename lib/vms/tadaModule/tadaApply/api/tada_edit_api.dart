import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/controller/tada_apply_controller.dart';

class TadaEditAPI {
  TadaEditAPI.init();
  static final TadaEditAPI instance = TadaEditAPI.init();
  tadaEditData(
      {required String base,
      required int userId,
      required int miId,
      required int vtadaaaId,
      required TadaApplyController tadaApplyController}) async {
    var dio = Dio();
    var api = 'https://vmsstaging.vapssmartecampus.com:40015/${URLS.tadaEdit}';

    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.editData(true);
      var response = await dio.post(
        api,
        // options: Options(headers: getSession()),
        data: {"UserId": 60934, "MI_Id": 17, "VTADAAA_Id": 0},
      );
      if (response.statusCode == 200) {
        if (response.data['client_Master']['values'] == null) {
          if (response.data['client_Master']['values'] != null) {
            tadaApplyController.checkPlanner
                .addAll(response.data['client_Master']['values']);
          }
          return true;
        }
        tadaApplyController.editData(false);
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Error catch (e) {
      logger.e(e);
    }
  }
}
