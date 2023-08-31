import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/model/edit_array_tada.dart';
import 'package:m_skool_flutter/vms/model/tada_apply_list.dart';
import 'package:m_skool_flutter/vms/model/time_array_tada.dart';

class TADAController {
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccured = RxBool(false);
  RxList<GetadvancetadaValues> tadaData = <GetadvancetadaValues>[].obs;
  RxList<TimeArrayTADADataValues> newTimeArray =
      <TimeArrayTADADataValues>[].obs;
  RxList<EditArrayTADADataValues> tadaEditValues =
      <EditArrayTADADataValues>[].obs;

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  void getTADALIst(List<GetadvancetadaValues> newtadaData) async {
    if (tadaData.isNotEmpty) {
      tadaData.clear();
    }
    tadaData.addAll(newtadaData);
  }

  void getTimeArray(List<TimeArrayTADADataValues> timeArray) async {
    if (newTimeArray.isNotEmpty) {
      newTimeArray.clear();
    }
    newTimeArray.addAll(timeArray);
  }

  void getEditArray(List<EditArrayTADADataValues> editArray) async {
    if (tadaEditValues.isNotEmpty) {
      tadaEditValues.clear();
    }
    tadaEditValues.addAll(editArray);
  }
}
