import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/state_list_model.dart';

class TadaApplyController extends GetxController {
  RxBool isStateLoading = RxBool(false);
  RxBool isCityLoading = RxBool(false);
  RxBool isErrorLoading = RxBool(false);
  RxList<String> addressListController = <String>[].obs;

  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  void stateLoading(bool loading) {
    isStateLoading.value = loading;
  }

  void cityLoading(bool loading) {
    isCityLoading.value = loading;
  }

  //**State List* *//
  RxList<StateListModelValues> stateList = <StateListModelValues>[].obs;

  void getStateList(List<StateListModelValues> states) {
    if (stateList.isNotEmpty) {
      stateList.clear();
    }
    for (int i = 0; i < states.length; i++) {
      stateList.add(states.elementAt(i));
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

  void addSelectedValues(ClintListModelValues value) {
    clintSelectedValues.add(value);
  }

  void removeSelectedValues(ClintListModelValues value) {
    clintSelectedValues.remove(value);
  }

  void addAddress(String controller) {
    addressListController.add(controller);
  }

  void removeAddress(String controller) {
    addressListController.remove(controller);
  }

  //**City List**//
  RxList<CityListModelValues> cityListValues = <CityListModelValues>[].obs;
  void getCity(List<CityListModelValues> cityList) {
    if (cityListValues.isNotEmpty) {
      cityListValues.clear();
    }
    for (int i = 0; i < cityList.length; i++) {
      cityListValues.add(cityList.elementAt(i));
    }
  }
}
