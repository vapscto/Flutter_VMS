import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_leave_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_lop_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_tt_model.dart';

class StaffDashboardController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccured = RxBool(false);

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  RxList<DashboardLeaveModelValues> dashboardLeaves = RxList();

  void updateDashboardLeaves(List<DashboardLeaveModelValues> leaves) {
    if (dashboardLeaves.isNotEmpty) {
      dashboardLeaves.clear();
    }
    dashboardLeaves.addAll(leaves);
  }

  RxList<DashboardLopModelValues> dashboardLop = RxList();

  void updateDashboardLop(List<DashboardLopModelValues> lop) {
    if (dashboardLop.isNotEmpty) {
      dashboardLop.clear();
    }
    dashboardLop.addAll(lop);
  }

  RxList<StaffDashboardTimetableModelValues> dashboardTT = RxList();

  void updateDashboardTT(List<StaffDashboardTimetableModelValues> dTT) {
    if (dashboardTT.isNotEmpty) {
      dashboardTT.clear();
    }
    dashboardTT.addAll(dTT);
  }

  RxList<DashboardPunchReportModelValues> dashboardPunch = RxList();

  void updateDashboardPunch(List<DashboardPunchReportModelValues> punch) {
    if (dashboardPunch.isNotEmpty) {
      dashboardPunch.clear();
    }
    dashboardPunch.addAll(punch);
  }

  RxList<DashboardCoeDataModelValues> dashboardCoe = RxList();

  void updateDashboardCoe(List<DashboardCoeDataModelValues> coe) {
    if (dashboardCoe.isNotEmpty) {
      dashboardCoe.clear();
    }
    dashboardCoe.addAll(coe);
  }
}
