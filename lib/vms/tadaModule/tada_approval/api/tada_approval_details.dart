import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/controller/tada_approval_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_edit_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_time.dart';

class TADAApprovalDetailsAPI {
  TADAApprovalDetailsAPI.init();

  static final TADAApprovalDetailsAPI instance = TADAApprovalDetailsAPI.init();

  tadaDetails(
      {required String base,
      required int userId,
      required TadaApprovalController tadaController,
      required int vtaDaaId}) async {
    final dio = Dio();
    var url2 = base + URLS.tadaApprovalDetails;

    try {
      tadaController.updateIsLoading(true);

      var response = await dio.post(url2,
          data: {"UserId": userId, "VTADAA_Id": vtaDaaId},
          options: Options(headers: getSession()) //60064 71
          );
      logger.i(url2);
      logger.i({"UserId": userId, "VTADAA_Id": vtaDaaId});
      if (response.statusCode == 200) {
        logger.d(response.data);
        TadaApprovalTimeArrayModel timeArrayDADADataValues =
            TadaApprovalTimeArrayModel.fromJson(response.data['timeArray']);
        tadaController.getTimeArray(timeArrayDADADataValues.values!);

        TadaApprovaEditArrayModel editArrayTADAData =
            TadaApprovaEditArrayModel.fromJson(response.data['editArray']);
        tadaController.getEditArray(editArrayTADAData.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
