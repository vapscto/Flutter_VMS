import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/balance_apply_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/file_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_edit_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_time.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/widgets/tada_approval_table.dart';

import '../../../../main.dart';

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
  double foodAmount = 0.0;
  double accommodationAmount = 0.0;
  void getEditArray(List<TadaApprovaEditArrayModelValues> time) {
    if (editArrayList.isNotEmpty) {
      editArrayList.clear();
      selectedValue.clear();
      textEditingControllerList.clear();
      approvalTextEditingControllerList.clear();
      percentageListController.clear();
    }
    for (int i = 0; i < time.length; i++) {
      editArrayList.add(time.elementAt(i));
      textEditingControllerList.add(TextEditingController(
          text: time[i].vTADAAAHSactionedAmount.toString()));

      foodAmount = time.elementAt(i).vTADACMFoodAmt!;
      accommodationAmount = time.elementAt(i).vTADACMAccommodationAmt!;
    }
  }

  RxList<TextEditingController> textEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> approvalTextEditingControllerList =
      <TextEditingController>[].obs;
  RxList<TextEditingController> percentageListController =
      <TextEditingController>[].obs;
  List<Item> selectedValue = [];
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

  RxList<BalanceApplyModelValues> balanceApplyList =
      <BalanceApplyModelValues>[].obs;
  RxList<BalanceApplyModelValues> balanceApplySecondList =
      <BalanceApplyModelValues>[].obs;
  int count = 0;
  void getBalanceApply(List<BalanceApplyModelValues> balanceApply) {
    if (balanceApplyList.isNotEmpty) {
      balanceApplyList.clear();
    }
    for (int index = 0; index < balanceApply.length; index++) {
      for (int i = 1; i < 10; i++) {
        count = i;
        if (balanceApply.elementAt(index).vTADAAAASanctioningLevel == i) {
          balanceApplyList.add(balanceApply.elementAt(index));
        }
      }
    }
  }
}
