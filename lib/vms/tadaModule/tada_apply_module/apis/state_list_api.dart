import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/get_save_data_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_saved_data_model.dart';

class StateListAPI {
  StateListAPI.init();
  static final StateListAPI instance = StateListAPI.init();
  tadastateList(
      {required int miId,
      required int userId,
      required String base,
      required TadaApplyDataController tadaApplyController}) async {
    var dio = Dio();
    var api = base + URLS.stateAndClintList;
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
      if (response.statusCode == 200) {
        // logger.i(api);
        // logger.i(response.data['state']);
        StateListModel stateListModel =
            StateListModel.fromJson(response.data['state']);
        tadaApplyController.getStateList(stateListModel.values!);
        ClintListModel clintListModel =
            ClintListModel.fromJson(response.data['client_Master']);
        tadaApplyController.getClintList(clintListModel.values!);
        if (response.data['getReport'] != null) {
          TadaSavedModel getSaveDataModel =
              TadaSavedModel.fromJson(response.data['getReport']);
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
