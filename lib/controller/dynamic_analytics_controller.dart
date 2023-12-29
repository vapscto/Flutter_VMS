import 'package:get/get.dart';
import 'package:m_skool_flutter/model/exam_graph_model.dart';
import 'package:m_skool_flutter/model/exam_list.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_leave_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_lop_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_tt_model.dart';

class DynamicAnalyticsController extends GetxController {
  //Staff

  RxList<DashboardLeaveModelValues> dashboardLeaves = RxList([]);

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

  //Manager

  //Student

  final RxList<BirthdayListValues> birthday = RxList<BirthdayListValues>([]);
  final RxList<ExamGraphListValues> examGraphVal = RxList();
  final RxList<ExamListNewValues> examList = RxList();
  final RxList<AttendanceListValues> attendance = RxList();
  final RxList<FeesListValues> feeList = RxList();
  final RxList<TimeTableListValues> timeTableList = RxList();

  Rx<ExamListNewValues> selectedOption =
      Rx<ExamListNewValues>(ExamListNewValues());

  void updateBirthday(List<BirthdayListValues> bday) {
    if (birthday.isNotEmpty) {
      birthday.clear();
    }
    birthday.addAll(bday);
  }

  void updateExamGraph(List<ExamGraphListValues> graph) {
    if (examGraphVal.isNotEmpty) {
      examGraphVal.clear();
    }
    examGraphVal.addAll(graph);
  }

  void updateExamList(List<ExamListNewValues> exam) {
    if (examList.isNotEmpty) {
      examList.clear();
    }
    examList.addAll(exam);
  }

  void updateFeeList(List<FeesListValues> fee) {
    if (feeList.isNotEmpty) {
      feeList.clear();
    }
    feeList.addAll(fee);
  }

  void updateAttendance(List<AttendanceListValues> att) {
    if (attendance.isNotEmpty) {
      attendance.clear();
    }
    attendance.addAll(att);
  }

  void updateStudentTT(List<TimeTableListValues> tt) {
    if (timeTableList.isNotEmpty) {
      timeTableList.clear();
    }
    timeTableList.addAll(tt);
  }

  RxBool isLoadingGraphData = RxBool(false);

  void updateIsLoadingGraphData(bool val) {
    isLoadingGraphData.value = val;
  }
}
