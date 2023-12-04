import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/file_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_edit_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_time.dart';

class TadaApprovalController extends GetxController {
  RxBool isDataLoading = RxBool(false);
  RxBool isDetailsLoading = RxBool(false);
  void updateIsLoading(bool loading) {
    isDetailsLoading.value = loading;
  }

  void dataLoading(bool loading) {
    isDataLoading.value = loading;
  }

  RxList<TadaApprovalListModelValues> tadaApprovalList =
      <TadaApprovalListModelValues>[].obs;
  void getTada(List<TadaApprovalListModelValues> tada) {
    if (tadaApprovalList.isNotEmpty) {
      tadaApprovalList.clear();
    }
    for (int index = 0; index < tada.length; index++) {
      tadaApprovalList.add(tada.elementAt(index));
    }
  }

  RxList<TadaApprovalTimeArrayModelValues> timeArray =
      <TadaApprovalTimeArrayModelValues>[].obs;
  void getTimeArray(List<TadaApprovalTimeArrayModelValues> time) {
    if (timeArray.isNotEmpty) {
      timeArray.clear();
    }
    for (int i = 0; i < time.length; i++) {
      timeArray.add(time.elementAt(i));
    }
  }

  RxList<TadaApprovaEditArrayModelValues> editArrayList =
      <TadaApprovaEditArrayModelValues>[].obs;
  void getEditArray(List<TadaApprovaEditArrayModelValues> time) {
    if (editArrayList.isNotEmpty) {
      editArrayList.clear();
      selectedValue.clear();
      textEditingControllerList.clear();
      approvalTextEditingControllerList.clear();
      percentageListController.clear();
    }
    editArrayList.addAll(time);
    for (int i = 0; i < editArrayList.length; i++) {
      textEditingControllerList.add(TextEditingController(
          text: editArrayList[i].vTADAAAHSactionedAmount.toString()));
      selectedValue.add(editArrayList[i].vTADAAStatusFlg.toString());
    }
  }

  RxList<TextEditingController> textEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> approvalTextEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> percentageListController =
      <TextEditingController>[].obs;
  List<String> selectedValue = [];
  void addToSelectedValueList(List<String> value) {
    selectedValue.add(value.toString());
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

  RxList<TadaApprovaFileModelValues> tadaApprovalFileList =
      <TadaApprovaFileModelValues>[].obs;
  void getFileList(List<TadaApprovaFileModelValues> tadaApprovalFile) {
    if (tadaApprovalFileList.isNotEmpty) {
      tadaApprovalFileList.clear();
    }
    for (int i = 0; i < tadaApprovalFile.length; i++) {
      tadaApprovalFileList.add(tadaApprovalFile.elementAt(i));
    }
  }
}
