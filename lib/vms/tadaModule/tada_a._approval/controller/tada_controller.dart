import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/edit_array_tada.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/tada_apply_list.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/time_array_tada.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/widgets/update_tada_table.dart';

class TADAController {
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccured = RxBool(false);
  RxList<GetadvancetadaValues> tadaData = <GetadvancetadaValues>[].obs;
  RxList<TimeArrayTADADataValues> newTimeArray =
      <TimeArrayTADADataValues>[].obs;
  RxList<EditArrayTADADataValues> tadaEditValues =
      <EditArrayTADADataValues>[].obs;
  double foodAmount = 0.0;
  double accommodationAmount = 0.0;
  RxList<TextEditingController> textEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> approvalTextEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> percentageListController =
      <TextEditingController>[].obs;
  List<Item> selectedValue = [];

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  void getTADALIst(List<GetadvancetadaValues> newtadaData) async {
    if (tadaData.isNotEmpty) {
      tadaData.clear();
    }
    for (int index = 0; index < newtadaData.length; index++) {
      tadaData.add(newtadaData.elementAt(index));
    }
  }

  void getTimeArray(List<TimeArrayTADADataValues> timeArray) async {
    if (newTimeArray.isNotEmpty) {
      newTimeArray.clear();
    }
    newTimeArray.addAll(timeArray);
  }

  void addToSelectedValueList(List<Item> value) {
    selectedValue.addAll(value);
  }

  void addToTextEditingList(TextEditingController textEditingController) {
    textEditingControllerList.add(textEditingController);
  }

  void addApprovalTextEditingList(TextEditingController textEditingController) {
    approvalTextEditingControllerList.add(textEditingController);
  }

  void addApprovalPercentageList(TextEditingController textEditingController) {
    percentageListController.add(textEditingController);
  }

  void getEditArray(List<EditArrayTADADataValues> editArray) async {
    if (tadaEditValues.isNotEmpty) {
      tadaEditValues.clear();
      selectedValue.clear();
      textEditingControllerList.clear();
      approvalTextEditingControllerList.clear();
      percentageListController.clear();
    }
    tadaEditValues.addAll(editArray);
    for (int i = 0; i < editArray.length; i++) {
      textEditingControllerList.add(TextEditingController(
          text: editArray[i].vTADAAAAHSactionedAmount.toString()));
      // selectedValue.add(editArray[i].vTADAAAAHStatusFlg.toString());
      foodAmount = editArray.elementAt(i).vTADACMFoodAmt!;
      accommodationAmount = editArray.elementAt(i).vTADACMAccommodationAmt!;
    }
  }
}
