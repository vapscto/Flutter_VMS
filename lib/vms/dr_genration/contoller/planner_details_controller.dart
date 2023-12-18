import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/DeptWise_Devitaion_Model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/advance_tada_applied.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/category_check_list_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_status_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotapprovedmessage_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotsent_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/get_planner_details.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/hrplannerdetails_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/tada_not_approve_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';

class PlannerDetails extends GetxController {
  RxList<PlanerDeatails> planerDeatails = <PlanerDeatails>[].obs;
  RxBool loadPlanerDeatails = RxBool(false);
  // Close TaskCount List
  RxList<CloseTaskCoutnModelValues> closeTaskCoutnList =
      <CloseTaskCoutnModelValues>[].obs;
// getAllTask Lists
  RxList<GetTaskDrListModelValues> getTaskDrList =
      <GetTaskDrListModelValues>[].obs;
// response text
  RxList<TextEditingController> responseTextField =
      <TextEditingController>[].obs;
// hours textField and minutes textField
  RxList<TextEditingController> hoursEt = <TextEditingController>[].obs;
// minutes text
  RxList<TextEditingController> minutesEt = <TextEditingController>[].obs;
  RxList<TextEditingController> statusEtField = <TextEditingController>[].obs;
  RxList<TextEditingController> deveationEtField =
      <TextEditingController>[].obs;
  // adding status in the list
  RxList<DrstatusListModelValues> statusDrList =
      <DrstatusListModelValues>[].obs;
  // list of depertment devation list
  RxList<DepartwisedeviationModelValues> depWiseDevitnList =
      <DepartwisedeviationModelValues>[].obs;
  // checkbox List
  RxList<bool> checkBoxList = <bool>[].obs;
  // category checklist array
  RxList<CategoryCheckListModelValues> categoryCheckList =
      <CategoryCheckListModelValues>[].obs;
  // drnotapproved list
  RxList<DrnotapprovedmessageValues> drnotapprovedList =
      <DrnotapprovedmessageValues>[].obs;
  // drnotset list
  RxList<GetdrnotsentdetailsValues> drnotSentdetailsList =
      <GetdrnotsentdetailsValues>[].obs;
  RxList<TextEditingController> etResponse = <TextEditingController>[].obs;
  void drNotSend(List<GetdrnotsentdetailsValues> drnotSent) {
    if (drnotSentdetailsList.isNotEmpty) {
      drnotSentdetailsList.clear();
    }
    for (int i = 0; i < drnotSent.length; i++) {
      drnotSentdetailsList.add(drnotSent.elementAt(i));
      logger.e(drnotSent.elementAt(i).fromDate);
    }
  }

  // drnotsent remarks list
  RxList<TextEditingController> etRemark = <TextEditingController>[].obs;
  // hrplannerDetails
  RxList<HrplannerdetailsValues> hrplannerDetailsList =
      <HrplannerdetailsValues>[].obs;
  RxString day = "today".obs;
  Rx<TextEditingController> plannernameEditingController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> plannernameDateController =
      TextEditingController(text: "").obs;
  RxString otherDaysEditingController = "".obs;
  Rx<TextEditingController> etSearchController = TextEditingController().obs;
  updatePlannerDeatails(bool val) {
    loadPlanerDeatails.value = val;
  }

  updateDayRadio(String val) {
    day.value = val;
  }

  RxList<AtachmenDrtFile> addListBrowser = <AtachmenDrtFile>[].obs;
  RxBool isSaveLoading = RxBool(false);
  void saveLoading(bool loading) {
    isSaveLoading.value = loading;
  }

  RxInt daviationId = 0.obs;
  RxList<GetPlannerDetailsModelValues> getplannerdetails =
      <GetPlannerDetailsModelValues>[].obs;
  void getPlannerData(List<GetPlannerDetailsModelValues> getplanner) {
    if (getplannerdetails.isNotEmpty) {
      getplannerdetails.clear();
    }
    for (int i = 0; i < getplanner.length; i++) {
      getplannerdetails.add(getplanner.elementAt(i));
    }
  }

  RxList<AdvanceApplyModelValues> advanceApplyDataList =
      <AdvanceApplyModelValues>[].obs;
  void getAdvanceApply(List<AdvanceApplyModelValues> advanceApply) {
    if (advanceApplyDataList.isNotEmpty) {
      advanceApplyDataList.clear();
    }
    for (int i = 0; i < advanceApply.length; i++) {
      advanceApplyDataList.add(advanceApply.elementAt(i));
    }
  }

  RxList<TADAApplyListModelValues> tadaApplyList =
      <TADAApplyListModelValues>[].obs;
  void getList(List<TADAApplyListModelValues> tadaApply) {
    if (tadaApplyList.isNotEmpty) {
      tadaApplyList.clear();
    }
    for (int i = 0; i < tadaApply.length; i++) {
      tadaApplyList.add(tadaApply.elementAt(i));
    }
  }

  List<Map<String, dynamic>> uploadImages = [];
}

class AtachmenDrtFile {
  int? id;
  String? FileName;
  File? file;
  AtachmenDrtFile({required this.id, required this.FileName, this.file});
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISMTCRAT_Attatchment'] = this.iSMTCRATAttatchment;
    data['ISMTCRAT_File'] = this.iSMTCRATFile;
    return data;
  }
}
