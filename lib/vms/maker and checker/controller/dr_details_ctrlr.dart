import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/department_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/dr_details_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_details.dart';

class DrDetailsCtrlr extends GetxController {
  RxBool drIsLoading = RxBool(false);
  RxBool drErrorLaodig = RxBool(false);
  RxBool tabLoading = RxBool(false);

  void updateIsLoadign(bool val) {
    drIsLoading.value = val;
  }

  void updatempErrorLoading(bool val) {
    drErrorLaodig.value = val;
  }

  void updateTabLoading(bool val) {
    tabLoading.value = val;
  }

  RxList<DrDetailModelValues> drdList = <DrDetailModelValues>[].obs;
  void getList(List<DrDetailModelValues> drd) {
    if (drdList.isNotEmpty) {
      drdList.clear();
    }
    for (int i = 0; i < drd.length; i++) {
      drdList.add(drd.elementAt(i));
    }
  }

  RxList<GetEmployeeDetailValues> empDetails = <GetEmployeeDetailValues>[].obs;
  RxList<String> statusList = <String>[].obs;
  RxList<String> sList = <String>[].obs;
  RxList<TextEditingController> statusET = <TextEditingController>[].obs;
  RxList<TextEditingController> etHoursList = <TextEditingController>[].obs;
  RxList<TextEditingController> etMinutesList = <TextEditingController>[].obs;
  RxList<TextEditingController> etRemakeList = <TextEditingController>[].obs;
}
