import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/approved_particular_indent_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/indent_details_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/onchange_approved_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/onload_approved_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/particular_indent_details_model.dart';

class PettyCashApprovalController extends GetxController {


  /// **  ONLOAD APPROVED INDENT DETAILS CONTROLLER  **  ///
   
  
  RxBool isErrorOccuredWhileLoadingOnloadorganization = RxBool(false);
  RxBool isLoadingOnloadorganization = RxBool(false);

  final RxList<PCApprovalOnloadModelValues> organizationList = RxList();

  updateErrorLoadingOnloadorganization(bool val) {
    isErrorOccuredWhileLoadingOnloadorganization.value = val;
  }

  updateisLoadingOnloadorganization(bool val) {
    isLoadingOnloadorganization.value = val;
  }

  /// **  ONCHANGE DROPDOWN APPROVED INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingIndentApprovedDetails = RxBool(false);
  RxBool isLoadingIndentApprovedDetails = RxBool(false);

  RxList<PCApprovalOnChangeModelValues> pcApprovedList = RxList();

  updateErrorLoadingIndentApprovedDetails(bool val) {
    isErrorOccuredWhileLoadingIndentApprovedDetails.value = val;
  }

  updateisLoadingIndentApprovedDetails(bool val) {
    isLoadingIndentApprovedDetails.value = val;
  }

    /// **  APPROVED PARTICULAR INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingApprovedParticularIndent = RxBool(false);
  RxBool isLoadingApprovedParticularIndent = RxBool(false);

  RxList<ParticularApprovedIndentModelValues> approvedparticular = RxList();

  updateErrorLoadingApprovedParticularIndent(bool val) {
    isErrorOccuredWhileLoadingApprovedParticularIndent.value = val;
  }

  updateisLoadingApprovedParticularIndent(bool val) {
    isLoadingApprovedParticularIndent.value = val;
  }

  /// ** APPROVEL INDENT DETAILS (FROM & TO DATE) CONTROLLER  **  ///

  Rx<DateTime> fromSelectedDate = Rx(DateTime.now());
  Rx<DateTime> toSelectedDate = Rx(DateTime.now());

  RxBool isErrorOccuredWhileLoadingIndentDetails = RxBool(false);
  RxBool isLoadingIndentDetails = RxBool(false);

  void updateFromSelectedDate(DateTime now) {
    fromSelectedDate.value = now;
  }

  void updateToSelectedDate(DateTime now) {
    toSelectedDate.value = now;
  }

  updateErrorLoadingIndentDetails(bool val) {
    isErrorOccuredWhileLoadingIndentDetails.value = val;
  }

  updateisLoadingIndentDetails(bool val) {
    isLoadingIndentDetails.value = val;
  }

  RxList<PcApprovalFromtoDateModelValues> pcIndentDetails = RxList();

  /// **  PARTICULAR INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingParticularIndentDetails = RxBool(false);
  RxBool isLoadingParticularIndentDetails = RxBool(false);

  RxList<ParticularIndentDetailsModelValues>  particularIndentDetails = RxList();
 RxList<bool> checkList = <bool>[].obs;
 RxList<TextEditingController> eTapprovalAmount=<TextEditingController>[].obs;

  updateErrorLoadingParticularIndentDetails(bool val) {
    isErrorOccuredWhileLoadingParticularIndentDetails.value = val;
  }

  updateisLoadingParticularIndentDetails(bool val) {
    isLoadingParticularIndentDetails.value = val;
  }


  ////****  SELECT  DATE  ****////


  Rx<DateTime> selectDate = Rx(DateTime.now());
  
   
  
}
