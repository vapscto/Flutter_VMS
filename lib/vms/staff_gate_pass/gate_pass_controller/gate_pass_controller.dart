import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_dep_list.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_list_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_staff_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_deg_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_inst_model.dart';

class GatePassController extends GetxController {
  RxBool isOnload = RxBool(false);
  void onload(bool b) {
    isOnload.value = b;
  }

  RxList<GatePassInstModelValues> institutionList =
      <GatePassInstModelValues>[].obs;
  RxList<GatePassListModelValues> gatePassedList =
      <GatePassListModelValues>[].obs;
  RxList<GatePassDepartmentModelValues> departmentList =
      <GatePassDepartmentModelValues>[].obs;
  RxList<GatePassDesignationModelValues> degList =
      <GatePassDesignationModelValues>[].obs;
  RxList<GatePassStaffModelValues> staffList = <GatePassStaffModelValues>[].obs;
}
