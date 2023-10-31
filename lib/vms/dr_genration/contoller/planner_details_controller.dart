import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';

class PlannerDetails extends GetxController {
  RxList<PlanerDeatails> planerDeatails = <PlanerDeatails>[].obs;
  RxBool loadPlanerDeatails = RxBool(false);
  // Close TaskCount List
  RxList<CloseTaskCoutnModelValues> closeTaskCoutnList =
      <CloseTaskCoutnModelValues>[].obs;
// getAllTask Lists
RxList<GetTaskDrListModelValues> getTaskDrList = <GetTaskDrListModelValues>[].obs;
  RxString day = "today".obs;
  Rx<TextEditingController> plannernameEditingController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> plannernameDateController =
      TextEditingController(text: "").obs;
  RxString otherDaysEditingController = "".obs;

  updatePlannerDeatails(bool val) {
    loadPlanerDeatails.value = val;
  }

  updateDayRadio(String val) {
    day.value = val;
  }
}
