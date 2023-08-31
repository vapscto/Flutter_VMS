import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/punch_report/model/punch_report_model.dart';

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

  void updatePunchReports(List<PunchReportModelValues> va) {
    if (reports.isNotEmpty) {
      reports.clear();
    }
    reports.addAll(va);
  }
}
