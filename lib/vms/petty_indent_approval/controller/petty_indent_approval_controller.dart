import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/indent_details_approved_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/indent_view_data_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/onChange_ins_indent_approval_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/onload_ins_indent_approve_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/particular_details_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/requisition_details_indent_approval_model.dart';

class PettyIndentApprovalController extends GetxController {
  /// **  ONLOAD PETTY INDENT DETAILS CONTROLLER  **  ///
//  RxList<bool> checkBoxList = <bool>[].obs;
  RxBool isErrorOccuredWhileLoadingOnloadorganization = RxBool(false);
  RxBool isLoadingOnloadorganization = RxBool(false);

  final RxList<InstitutionIndentApprovalModelValues> organizationList =
      RxList();

  updateErrorLoadingOnloadorganization(bool val) {
    isErrorOccuredWhileLoadingOnloadorganization.value = val;
  }

  updateisLoadingOnloadorganization(bool val) {
    isLoadingOnloadorganization.value = val;
  }

  /// **  ONCHANGE DROPDOWN INS INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingOnchangeIndent = RxBool(false);
  RxBool isLoadingOnchangeIndent = RxBool(false);

  RxList<OnChangeInsIndentApprovalModelValues> getapproveddata = RxList();

  updateErrorLoadingOnchangeIndent(bool val) {
    isErrorOccuredWhileLoadingOnchangeIndent.value = val;
  }

  updateisLoadingOnchangeIndent(bool val) {
    isLoadingOnchangeIndent.value = val;
  }

  ///*** DATE ***///

  Rx<DateTime> fromSelectedDate = Rx(DateTime.now());
  Rx<DateTime> toSelectedDate = Rx(DateTime.now());
  RxList<bool> checkBoxList = <bool>[].obs;
  RxList<TextEditingController> eTapprovalAmount=<TextEditingController>[].obs;
  Rx<DateTime> selectDate = Rx(DateTime.now());


    /// **  ONCHANGE DATE INDENT CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingrequisitiondetais = RxBool(false);
  RxBool isLoadingrequisitiondetais = RxBool(false);

  RxList<RequestIndentDetailsModelValues> requisitiondetais = RxList();

  updateErrorLoadingrequisitiondetais(bool val) {
    isErrorOccuredWhileLoadingrequisitiondetais.value = val;
  }

  updateisLoadingrequisitiondetais(bool val) {
    isLoadingrequisitiondetais.value = val;
  }


  /// **  PARTICULAR INDENT CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingParticularrequisitiondetais = RxBool(false);
  RxBool isLoadingParticularrequisitiondetais = RxBool(false);

  RxList<RequisitionParticularDetailsModelValues> particularRequisitionDetais = RxList();

  updateErrorLoadingParticularrequisitiondetais(bool val) {
    isErrorOccuredWhileLoadingParticularrequisitiondetais.value = val;
  }

  updateisLoadingParticularrequisitiondetais(bool val) {
    isLoadingParticularrequisitiondetais.value = val;
  }

    /// ** INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingIndentDetails = RxBool(false);
  RxBool isLoadingIndentDetails = RxBool(false);

  RxList<IndentDetailsApprovedModelValues> approvedIndentList = RxList();

  updateErrorLoadingIndentDetails(bool val) {
    isErrorOccuredWhileLoadingIndentDetails.value = val;
  }

  updateisLoadingIndentDetails(bool val) {
    isLoadingIndentDetails.value = val;
  }

  /// ** VIEW INDENT DETAILS CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingIndentViewData = RxBool(false);
  RxBool isLoadingIndentViewData = RxBool(false);

  RxList<IndentViewDataModelValues> viewDataList = RxList();

  updateErrorLoadingIndentViewData(bool val) {
    isErrorOccuredWhileLoadingIndentViewData.value = val;
  }

  updateisLoadingIndentViewData(bool val) {
    isLoadingIndentViewData.value = val;
  }
}
