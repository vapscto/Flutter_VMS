import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/allowence_table_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/check_planner.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_applied_data_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_edit_image_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_saved_data_model.dart';

class TadaApplyDataController extends GetxController {
  RxBool isStateLoading = RxBool(false);
  RxBool isCityLoading = RxBool(false);
  RxBool isErrorLoading = RxBool(false);
  RxBool isAllowenseLoading = RxBool(false);
  RxBool isSave = RxBool(false);
  RxBool isEdit = RxBool(false);
  RxBool isPlannerCreate = RxBool(false);
  RxBool isAppliedDataLoading = RxBool(false);
  RxBool isDocumentUpload = RxBool(false);

  void appliedData(bool loading) {
    isAppliedDataLoading.value = loading;
  }

  void plannerCreate(bool loading) {
    isPlannerCreate.value = loading;
  }

  void saveData(bool loading) {
    isSave.value = loading;
  }

  void editData(bool loading) {
    isEdit.value = loading;
  }

//
  RxList<String> addressListController = <String>[].obs;
  double foodAmount = 0.0;
  double accomodationAmount = 0.0;

  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  void stateLoading(bool loading) {
    isStateLoading.value = loading;
  }

  void cityLoading(bool loading) {
    isCityLoading.value = loading;
  }

  void allowenseLoading(bool loading) {
    isAllowenseLoading.value = loading;
  }

  //**State List* *//
  RxList<StateListModelValues> stateList = <StateListModelValues>[].obs;
  RxList<TadaSavedModelValues> getSavedData = <TadaSavedModelValues>[].obs;

  void getStateList(List<StateListModelValues> states) {
    if (stateList.isNotEmpty) {
      stateList.clear();
    }
    for (int i = 0; i < states.length; i++) {
      stateList.add(states.elementAt(i));
    }
  }

  void getSavedDataValue(List<TadaSavedModelValues> data) {
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

  //** Table List **//
  RxList<TextEditingController> slotController = <TextEditingController>[].obs;
  void getSlots(TextEditingController slots) {
    slotController.add(slots);
  }

  RxList<TextEditingController> totalAmountController =
      <TextEditingController>[].obs;
  void getTotalAmount(TextEditingController amount) {
    totalAmountController.add(amount);
  }

  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  void getremarks(TextEditingController remarks) {
    remarksController.add(remarks);
  }

  //** Allowense Data **//

  RxList<AllowenseTableModelValues> allowenseData =
      <AllowenseTableModelValues>[].obs;
  void getAllowense(List<AllowenseTableModelValues> data) {
    if (allowenseData.isNotEmpty) {
      allowenseData.clear();
    }
    for (int i = 0; i < data.length; i++) {
      allowenseData.add(data.elementAt(i));
      foodAmount = data.elementAt(i).vtadacMFoodAmt!;
      accomodationAmount = data.elementAt(i).vtadacMAccommodationAmt!;
    }
  }

  //** Check Planner **//
  RxList<CheckPlannerModelValues> checkPlanner =
      <CheckPlannerModelValues>[].obs;
  void checkPlan(List<CheckPlannerModelValues> plan) {
    if (checkPlanner.isNotEmpty) {
      checkPlanner.clear();
    }
    for (int i = 0; i < plan.length; i++) {
      checkPlanner.add(plan.elementAt(i));
    }
  }

  // attachment
  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
  RxList<int> newList = <int>[].obs;

  RxList<TextEditingController> newRemarksController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> fileNameController =
      <TextEditingController>[].obs;
  // Saved Data
  RxList<TadaSavedDataModelValues> tadaSavedDataValues =
      <TadaSavedDataModelValues>[].obs;
  RxList<TadaSavedDataModelValues> tadaSavedData =
      <TadaSavedDataModelValues>[].obs;

  void appliedSaved(List<TadaSavedDataModelValues> values) {
    if (tadaSavedDataValues.isNotEmpty) {
      tadaSavedDataValues.clear();
      tadaSavedData.clear();
    }
    for (int i = 0; i < values.length; i++) {
      tadaSavedDataValues.add(values.elementAt(i));
    }
  }

  // NewEnhancement
  RxList<TextEditingController> uploadedImageRemarkController =
      <TextEditingController>[].obs;
  void getRemarks(TextEditingController textEditingController) {
    uploadedImageRemarkController.add(textEditingController);
  }

  // edit APi
  RxBool isUpdate = RxBool(false);
  void updateData(bool loading) {
    isUpdate.value = loading;
  }

  void getEditImage(List<EditUploadImageModelValues> edituploadImage) {
    if (addUpdatedImageList.isNotEmpty) {
      addUpdatedImageList.clear();
      imageList.clear();
    }
    for (int i = 0; i < edituploadImage.length; i++) {
      addUpdatedImageList.add(edituploadImage.elementAt(i));
    }
  }

  RxList<EditUploadImageModelValues> addUpdatedImageList =
      <EditUploadImageModelValues>[].obs;
  RxList<AtachmentFileList> imageList = <AtachmentFileList>[].obs;
}

class AtachmentFileList {
  int? id;
  String? fileName;
  String? filePath;
  String? remarks;
  String? status;
  int? vtadaaId;
  AtachmentFileList(
      {required this.id,
      required this.fileName,
      this.filePath,
      this.remarks,
      this.status,
      this.vtadaaId});
}

class AtachmentFile {
  int? id;
  // ignore: non_constant_identifier_names
  String? FileName;
  XFile? file;
  // ignore: non_constant_identifier_names
  AtachmentFile({required this.id, required this.FileName, this.file});
}

class UploadAttachment {
  String? iSMTCRATAttatchment;
  String? iSMTCRATFile;

  UploadAttachment(
      {required this.iSMTCRATAttatchment, required this.iSMTCRATFile});

  UploadAttachment.fromJson(Map<String, dynamic> json) {
    iSMTCRATAttatchment = json['ISMTCRAT_Attatchment'];
    iSMTCRATFile = json['ISMTCRAT_File'];
  }

  factory UploadAttachment.fromMap(Map<String, dynamic> map) {
    return UploadAttachment(
        iSMTCRATAttatchment: map['ISMTCRAT_Attatchment'] as String,
        iSMTCRATFile: map['ISMTCRAT_File'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ISMTCRAT_Attatchment'] = iSMTCRATAttatchment;
    data['ISMTCRAT_File'] = iSMTCRATFile;
    return data;
  }
}
