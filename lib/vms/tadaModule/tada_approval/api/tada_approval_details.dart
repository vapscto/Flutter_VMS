import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/controller/tada_approval_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/balance_apply_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/file_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_edit_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_time.dart';

class TADAApprovalDetailsAPI {
  TADAApprovalDetailsAPI.init();

  static final TADAApprovalDetailsAPI instance = TADAApprovalDetailsAPI.init();

  tadaDetails(
      {required String base,
      required int userId,
      required TadaApprovalController tadaController,
      required int vtaDaaId,
      required int vtadaaaaId}) async {
    final dio = Dio();
    var url2 = base + URLS.tadaApprovalDetails;

    try {
      tadaController.updateIsLoading(true);

      var response = await dio.post(url2,
          data: {
            "UserId": userId,
            "VTADAA_Id": vtaDaaId,
            "VTADAAAAA_Id": vtadaaaaId
          },
          options: Options(headers: getSession()));
      logger.i(url2);
      logger.i({
        "UserId": userId,
        "VTADAA_Id": vtaDaaId,
        "VTADAAAAA_Id": vtadaaaaId
      });
      if (response.statusCode == 200) {
        logger.d(response.data);
        TadaApprovalTimeArrayModel timeArrayDADADataValues =
            TadaApprovalTimeArrayModel.fromJson(response.data['timeArray']);
        tadaController.getTimeArray(timeArrayDADADataValues.values!);
        TadaApprovaEditArrayModel editArrayTADAData =
            TadaApprovaEditArrayModel.fromJson(response.data['editArray']);
        tadaController.getEditArray(editArrayTADAData.values!);
        for (int i = 0; i < editArrayTADAData.values!.length; i++) {
          logger.i('Slot :- ${editArrayTADAData.values![i].vTADAADSlots}');
        }
        if (response.data['getFile'] != null) {
          TadaApprovaFileModel tadaApprovaFileModel =
              TadaApprovaFileModel.fromJson(response.data['getFile']);
          tadaController.getFileList(tadaApprovaFileModel.values!);
        }
        if (response.data['veiwdetails'] != null) {
          BalanceApplyModel balanceApplyModel =
              BalanceApplyModel.fromJson(response.data['veiwdetails']);
          tadaController.getBalanceApply(balanceApplyModel.values!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
