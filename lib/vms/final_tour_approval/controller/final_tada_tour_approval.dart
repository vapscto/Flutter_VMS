import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tada_tour_approval_lists.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tour_plan_details.dart';

class TadaTourApprovalController extends GetxController{
  RxList<FinalTadaTourApprovalValues> finaltadaTourApprovalList = RxList();
  RxBool showFinalTadaTourApprovalList =  RxBool(false);
  RxList<FinalTourPlanDetailsValues> finalPalnerDetails = <FinalTourPlanDetailsValues>[].obs;
}