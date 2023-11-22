import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/get_save_data_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';

class TadaStateListAPI {
  TadaStateListAPI.init();
  static final TadaStateListAPI instance = TadaStateListAPI.init();
  tadastateList(
      {required int miId,
      required int userId,
      required String base,
      required TadaApplyController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.stateList;
    try {
      if (tadaApplyController.isErrorLoading.value) {
        tadaApplyController.errorLoading(false);
      }
      tadaApplyController.stateLoading(true);
      var response = await dio.post(
        api,
        options: Options(headers: getSession()),
        data: {"UserId": userId, "MI_Id": miId},
      );
      logger.i(api);
      logger.i('====${{"UserId": userId, "MI_Id": miId}}');
      if (response.statusCode == 200) {
        StateListModel stateListModel =
            StateListModel.fromJson(response.data['state']);
        tadaApplyController.getStateList(stateListModel.values!);
        ClintListModel clintListModel =
            ClintListModel.fromJson(response.data['client_Master']);
        tadaApplyController.getClintList(clintListModel.values!);
        if (response.data['getReport'] != null) {
          GetSaveDataModel getSaveDataModel =
              GetSaveDataModel.fromJson(response.data['getReport']);
          tadaApplyController.getSavedDataValue(getSaveDataModel.values!);
        }
        tadaApplyController.stateLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
