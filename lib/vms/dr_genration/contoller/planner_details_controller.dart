import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/DeptWise_Devitaion_Model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_status_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';

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
  RxList<DrstatusListModelValues> statusDrList = <DrstatusListModelValues>[].obs;
  // list of depertment devation list
  RxList<DepartwisedeviationModelValues> depWiseDevitnList = <DepartwisedeviationModelValues>[].obs;
  // checkbox List 
  RxList<bool> checkBoxList = <bool>[].obs;
  RxString day = "today".obs;
  Rx<TextEditingController> plannernameEditingController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> plannernameDateController =
      TextEditingController(text: "").obs;
  RxString otherDaysEditingController = "".obs;
Rx<TextEditingController> etSearchController =TextEditingController().obs;
  updatePlannerDeatails(bool val) {
    loadPlanerDeatails.value = val;
  }

  updateDayRadio(String val) {
    day.value = val;
  }
}
