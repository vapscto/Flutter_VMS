import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';

class PlannerDetails extends GetxController{
  RxList<PlanerDeatails> planerDeatails = <PlanerDeatails>[].obs;
  RxBool loadPlanerDeatails = RxBool(false);
  RxString day = "today".obs;
   Rx<TextEditingController> plannernameEditingController =  TextEditingController(text: "").obs;
   Rx<TextEditingController> plannernameDateController =  TextEditingController(text: "").obs;
   RxString otherDaysEditingController =  "".obs;
 
  updatePlannerDeatails(bool val){
    loadPlanerDeatails.value = val;
  }
  updateDayRadio(String val){
  day.value=val;
  }

}