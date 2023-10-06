import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/get_save_data_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';

class TadaApplyDataController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  // state List
  RxBool isStateLoading = RxBool(false);
  void stateLoading(bool loading) {
    isStateLoading.value = loading;
  }

  RxList<StateListModelValues> stateList = <StateListModelValues>[].obs;
  void getState(List<StateListModelValues> state) {
    if (stateList.isNotEmpty) {
      stateList.clear();
    }
    for (int i = 0; i < state.length; i++) {
      stateList.add(state.elementAt(i));
    }
  }

  RxList<GetSaveDataModelValues> getSavedData = <GetSaveDataModelValues>[].obs;
  void getSavedDataValue(List<GetSaveDataModelValues> data) {
    if (getSavedData.isNotEmpty) {
      getSavedData.clear();
    }
    for (int i = 0; i < data.length; i++) {
      getSavedData.add(data.elementAt(i));
    }
  }

  //**Clint List **//
  RxList<ClintListModelValues> clintListValues = <ClintListModelValues>[].obs;
  RxList<ClintListModelValues> clintSelectedValues =
      <ClintListModelValues>[].obs;
  void getClintList(List<ClintListModelValues> clintList) {
    if (clintListValues.isNotEmpty) {
      clintListValues.clear();
    }
    for (int i = 0; i < clintList.length; i++) {
      clintListValues.add(clintList.elementAt(i));
    }
  }

  //city List controller
  RxList<CityListModelValues> cityList = <CityListModelValues>[].obs;
  RxBool isCityLoading = RxBool(false);
  void cityLoading(bool loading) {
    isCityLoading.value = loading;
  }

  void getCity(List<CityListModelValues> city) {
    if (cityList.isNotEmpty) {
      cityList.clear();
    }
    for (int i = 0; i < city.length; i++) {
      cityList.add(city.elementAt(i));
    }
  }

  // attachment
  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
}
