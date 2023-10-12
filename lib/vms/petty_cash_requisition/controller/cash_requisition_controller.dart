import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/department_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/employee_list_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/particulars_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/requested_details_pc_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/view_data_model.dart';

class CashRequisitionController extends GetxController {
  /// **  DEPARTMENT ONLOAD CASH REQUISITION CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingOnloadDepartment = RxBool(false);
  RxBool isLoadingOnloadDepartment = RxBool(false);

  final RxList<DepartmentPcRequestModelValues> departmentList = RxList();

  updateErrorLoadingOnloadDepartment(bool val) {
    isErrorOccuredWhileLoadingOnloadDepartment.value = val;
  }

  updateisLoadingOnloadDepartment(bool val) {
    isLoadingOnloadDepartment.value = val;
  }

  /// **  EMPLOYEE LIST CASH REQUISITION CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingOnloadEmployee = RxBool(false);
  RxBool isLoadingOnloadEmployee = RxBool(false);

  final RxList<EmployeeListPcReqModelValues> employeeList = RxList();

  updateErrorLoadingOnloadEmployee(bool val) {
    isErrorOccuredWhileLoadingOnloadEmployee.value = val;
  }

  updateisLoadingOnloadEmployee(bool val) {
    isLoadingOnloadEmployee.value = val;
  }

  /// **  PARTICULARS LIST CASH REQUISITION CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingOnloadParticulars = RxBool(false);
  RxBool isLoadingOnloadParticulars = RxBool(false);

  final RxList<ParticularsPcRequestModel> particularsList = RxList();


  RxList<TextEditingController> textCtrlParticular =
      <TextEditingController>[].obs;

  RxList<TextEditingController> amountTexteditCtrl =
      <TextEditingController>[].obs;


  updateErrorLoadingOnloadParticulars(bool val) {
    isErrorOccuredWhileLoadingOnloadParticulars.value = val;
  }

  updateisLoadingOnloadParticulars(bool val) {
    isLoadingOnloadParticulars.value = val;
  }


  RxList<ParticularsPcRequestModelValues> itemsParticularList =
      <ParticularsPcRequestModelValues>[].obs;

  // RxList<TextEditingController> eTapprovalAmount=<TextEditingController>[].obs;

  ParticularsPcRequestModelValues? dropdownValue;
  RxList<TextEditingController> textCtrl = <TextEditingController>[].obs;

  Rx<DateTime> selectDate = Rx(DateTime.now());


  /// **  REQUESTED LOADDATA PARTICULAR NAME CASH REQUISITION CONTROLLER  **  ///

  RxBool isErrorOccuredWhileLoadingRequestedDetails = RxBool(false);
  RxBool isLoadingRequestedDetails = RxBool(false);

  final RxList<RequestedDetailsPCModelValues> getLoadDataList = RxList();

  updateErrorLoadingRequestedDetails(bool val) {
    isErrorOccuredWhileLoadingRequestedDetails.value = val;
  }

  updateisLoadingRequestedDetails(bool val) {
    isLoadingRequestedDetails.value = val;
  }

  /// **  REQUESTED PARTICULAR REQUISITION CONTROLLER VIEW DATA  **  ///

  RxBool isErrorOccuredWhileLoadingViewDataParticular = RxBool(false);
  RxBool isLoadingViewDataParticular = RxBool(false);

  final RxList<ViewDataPcReqModelValues> getViewDataParticular = RxList();

  updateErrorLoadingViewDataParticular(bool val) {
    isErrorOccuredWhileLoadingViewDataParticular.value = val;
  }

  updateisLoadingViewDataParticular(bool val) {
    isLoadingViewDataParticular.value = val;
  }


}
