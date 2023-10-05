import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';

class TadaCityListAPI {
  TadaCityListAPI.init();
  static final TadaCityListAPI instance = TadaCityListAPI.init();
  tadaCityList(
      {required int miId,
      required int userId,
      required String base,
      required int countryId,
      required int stateId,
      required TadaApplyController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.cityList;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.cityLoading(true);
      var response = await dio.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "UserId": userId,
          "ivrmmS_Id": stateId,
          "ivrmmC_Id": countryId,
          "MI_Id": miId
        },
      );
      logger.i({
        "UserId": userId,
        "ivrmmS_Id": stateId,
        "ivrmmC_Id": countryId,
        "MI_Id": miId
      });
      if (response.statusCode == 200) {
        logger.i(api);

        CityListModel stateListModel =
            CityListModel.fromJson(response.data['city_Type']);
        tadaApplyController.getCity(stateListModel.values!);

        tadaApplyController.cityLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
