import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/constants/api_constants.dart';
import 'package:m_skool_flutter/vms/tadaModule/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/tada_apply_list.dart';

class TADAApplyListAPI {
  TADAApplyListAPI.init();

  static final TADAApplyListAPI instance = TADAApplyListAPI.init();

  showApplyList(
      {required String base,
      required int userId,
      required TADAController tadaController}) async {
    final dio = Dio();
    // var url = base + APIConstant().tadaShow;
    var url2 = base + URLS.tadaList;

    try {
      if (tadaController.isErrorOccured.value) {
        tadaController.updateIsErrorOccured(false);
      }

      tadaController.updateIsLoading(true);

      var response = await dio.post(
        url2,
        data: {"UserId": userId},
        //  options: Options(headers: getSession())
      );
      if (response.statusCode == 200) {
        Getadvancetada getadvancetada =
            Getadvancetada.fromJson(response.data['getadvancetada']);
        tadaController.getTADALIst(getadvancetada.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
