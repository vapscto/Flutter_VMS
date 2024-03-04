import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/punch_report/model/current_punch_details.dart';
import 'package:m_skool_flutter/vms/punch_report/model/punch_report_model.dart';

class PunchFilterController extends GetxController {
  final RxBool startFilteration = RxBool(false);
  final RxBool isErrorOccured = RxBool(false);

  final RxString message = RxString("");

  void updateStartFilteration(bool v) {
    startFilteration.value = v;
  }

  void updateIsErrorOccured(bool v) {
    isErrorOccured.value = v;
  }

  final Rx<DateTime> startFrom = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> endTo = Rx<DateTime>(DateTime.now());

  final RxString displayAbleStartFrom = RxString("Start Date");
  final RxString displayAbleEndTo = RxString("End Date");

  final RxInt start = RxInt(0);

  void updateDisplayAbleStartFrom(String start) {
    displayAbleStartFrom.value = start;
  }

  void updateDisplayAbleEndTo(String end) {
    displayAbleEndTo.value = end;
  }

  void updateStartFrom(DateTime now) {
    startFrom.value = now;
  }

  void updateEndTo(DateTime now) {
    endTo.value = now;
  }

  RxList<PunchReportModelValues> reports = RxList();
  int makeMinutes(String time1) {
    List<String> timeParts = time1.split(':');
    int hour1 = int.parse(timeParts[0]);
    int minute1 = int.parse(timeParts[1]);

    int totMin = 0;

    if (hour1 > 0) {
      totMin = hour1 * 60;
    }

    totMin += minute1;
    return totMin;
  }

  void updatePunchReports(List<PunchReportModelValues> va) {
    if (reports.isNotEmpty) {
      reports.clear();
    }
    reports.addAll(va);
  }

  RxBool isPunchLoading = RxBool(false);
  void punchLoading(bool loading) {
    isPunchLoading.value = loading;
  }

  Map<String, dynamic> newCol = {};
  RxList<CurrentPunchDetailsModelValues> currentPunchList =
      <CurrentPunchDetailsModelValues>[].obs;
  void getPunch(List<CurrentPunchDetailsModelValues> currentPunch) {
    if (currentPunchList.isNotEmpty) {
      currentPunchList.clear();
    }
    for (int i = 0; i < currentPunch.length; i++) {
      currentPunchList.add(currentPunch.elementAt(i));
    }
  }
}
