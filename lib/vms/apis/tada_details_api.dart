import 'package:dio/dio.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/constants/api_constants.dart';
import 'package:m_skool_flutter/vms/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/model/edit_array_tada.dart';
import 'package:m_skool_flutter/vms/model/time_array_tada.dart';

class TADADetailsAPI {
  TADADetailsAPI.init();

  static final TADADetailsAPI instance = TADADetailsAPI.init();

  showApplyList(
      {required String base,
      required String userId,
      required TADAController tadaController,
      required String vtaDaaaId}) async {
    final dio = Dio();
    var url = base + APIConstant().tadaShow;
    var url2 =
        'https://vmsstaging.vapssmartecampus.com:40015/api/TADAAdvanceApprovalFacade/edit';

    try {
      if (tadaController.isErrorOccured.value) {
        tadaController.updateIsErrorOccured(false);
      }

      tadaController.updateIsLoading(true);

      var response = await dio.post(
        url2,
        data: {"UserId": 60064, "VTADAAA_Id": 71},
        //  options: Options(headers: getSession())
      );
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
