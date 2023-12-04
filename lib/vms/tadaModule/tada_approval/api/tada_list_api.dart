import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/controller/tada_approval_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_list_model.dart';

class TADAApprovalListAPI {
  TADAApprovalListAPI.init();

  static final TADAApprovalListAPI instance = TADAApprovalListAPI.init();

  showApplyList(
      {required String base,
      required int userId,
      required TadaApprovalController tadaController}) async {
    final dio = Dio();
    var url2 = base + URLS.tadaApprovalList;

    try {
      tadaController.dataLoading(true);

      var response = await dio.post(
        url2,
        data: {"UserId": userId},
        options: Options(headers: getSession()),
      );
      logger.i(url2);
      logger.i({"UserId": userId});
      if (response.statusCode == 200) {
        TadaApprovalListModel getadvancetada =
            TadaApprovalListModel.fromJson(response.data['getadvancetada']);
        tadaController.getTada(getadvancetada.values!);
        tadaController.dataLoading(false);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
