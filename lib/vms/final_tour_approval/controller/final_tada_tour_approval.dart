import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/approval_final_submission.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/file_plan_dmo.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tada_adavance.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tada_tour_approval_lists.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tour_plan_details.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/lead_final_submision.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/lead_status_list.dart';

class TadaTourApprovalController extends GetxController{
  RxList<FinalTadaTourApprovalValues> finaltadaTourApprovalList = RxList();
  RxBool showFinalTadaTourApprovalList =  RxBool(false);
  RxList<FinalTourPlanDetailsValues> finalPalnerDetails = <FinalTourPlanDetailsValues>[].obs;
  RxList<TourPlanFileDmoValues> fileList = <TourPlanFileDmoValues>[].obs;
  RxList<FinalViewAdvancDetailsValues> finalViewAdvance = <FinalViewAdvancDetailsValues>[].obs;
  RxList<LeadStatusNameModelValues> leadStatusList = <LeadStatusNameModelValues>[].obs;
  RxList<LeadFinalSubmissionValues> leadFinalSubmission = <LeadFinalSubmissionValues>[].obs;
  RxList<ApprovalSubmisionValues>  approvalSubmission = <ApprovalSubmisionValues>[].obs;
  Rx<TextEditingController> etPlanedAmount = TextEditingController(text: "").obs;
  Rx<TextEditingController> etEligibleAmount = TextEditingController(text: '').obs;
  Rx<TextEditingController> etDebitAmount = TextEditingController(text: '').obs;
  Rx<TextEditingController> etRemarks = TextEditingController(text: '').obs;
  Rx<TextEditingController> etPaidAmount = TextEditingController(text:'').obs;
  Rx<TextEditingController> etDeductectedAmount = TextEditingController(text: '').obs;
  Rx<TextEditingController> etSnactionedAmount = TextEditingController(text:'').obs;
  
  RxDouble totalSancationedAmount = RxDouble(0.0);
  RxDouble totalFinalappliedAmount = RxDouble(0.0);
  RxDouble totalFinalSanctionAmount = RxDouble(0.0);
  RxDouble totalFinalElgibleAmount = RxDouble(0.0);
 } 