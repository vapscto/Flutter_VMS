import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/dr_not_approved_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/leave_approve_popup_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_approval_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_list_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/model/planner_status_model.dart';

class PlannerApprovalController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  RxBool isPlannerLoading = RxBool(false);
  void plannerLoading(bool loading) {
    isPlannerLoading.value = loading;
  }

  RxBool isPlannerStatusLoading = RxBool(false);
  void plannerStatusLoading(bool loading) {
    isPlannerStatusLoading.value = loading;
  }

  RxList<Map<String, dynamic>> newplannerList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> plannerListModel = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> notApproveDates = <Map<String, dynamic>>[].obs;
  RxList<PlannerListModelValues> plannerListValues =
      <PlannerListModelValues>[].obs;
  RxList<DrNotApprovedModelValues> drNotApprovedValues =
      <DrNotApprovedModelValues>[].obs;
  void getPlanner(List<PlannerListModelValues> plannerList,
      List<DrNotApprovedModelValues> drNotApprove) {
    for (var drapp in plannerList) {
      DateTime dt = DateTime.parse(drapp.iSMTPLStartDate!);
      var fromDate = '${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}';
      //
      DateTime dt1 = DateTime.parse(drapp.iSMTPLEndDate!);
      var toDate =
          '${numberList[dt1.day]}-${numberList[dt1.month]}-${dt1.year}';
      plannerListModel.add({
        "name": drapp.plannedby,
        "day": drapp.drappDatecount,
        "startDate": fromDate,
        "endDate": toDate,
        "totalEffort": drapp.iSMTPLTotalHrs,
        "planner": drapp.iSMTPLPlannerName,
        "plannerView": "View & Approve",
        "ismtplId": drapp.iSMTPLId,
      });
    }

    if (drNotApprove != null && drNotApprove.isNotEmpty) {
      for (var drapp in plannerList) {
        DateTime dt = DateTime.parse(drapp.iSMTPLStartDate!);
        var fromDate =
            '${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}';
        //
        DateTime dt1 = DateTime.parse(drapp.iSMTPLEndDate!);
        var toDate =
            '${numberList[dt1.day]}-${numberList[dt1.month]}-${dt1.year}';
        var tempData = [];
        tempData = drNotApprove.where((d) => d.hRMEId == drapp.hRMEId).toList();
        drapp.drappDatecount = tempData.length;
        if (drapp.drappDatecount != 0) {
          newplannerList.add({
            "name": drapp.plannedby,
            "day": drapp.drappDatecount,
            "startDate": fromDate,
            "endDate": toDate,
            "totalEffort": drapp.iSMTPLTotalHrs,
            "planner": drapp.iSMTPLPlannerName,
            "category": 'Task Category',
            "plannerView": "View & Approve"
          });
        }
      }
    }
    if (drNotApprove != null && drNotApprove.isNotEmpty) {
      for (var index in drNotApprove) {
        var tempData = [];
        tempData = plannerList.where((d) => d.hRMEId == index.hRMEId).toList();
        index.hRMEId = tempData.length;
        notApproveDates.add({
          "dailyReportDate": index.drDate,
          "generatedDate": index.dRGDate,
          "othersDay": index.iSMDRPTOrdersDateFlg
        });
      }
    }
  }

  RxList<PlannerStatusModelListValues> plannerStatusModel =
      <PlannerStatusModelListValues>[].obs;
  void getStatus(List<PlannerStatusModelListValues> status) {
    if (plannerStatusModel.isNotEmpty) {
      plannerStatusModel.clear();
    }
    for (int i = 0; i < status.length; i++) {
      plannerStatusModel.add(status.elementAt(i));
    }
  }

  RxBool isPlanner = RxBool(false);
  void approvalLoading(bool loading) {
    isPlanner.value = loading;
  }

  RxList<PlannerApprovalListModelValues> plannerApprovalList =
      <PlannerApprovalListModelValues>[].obs;
  int ismmcId = 0;
  int ivrmrtId = 0;
  int completedCount = 0;
  double effort = 0.0;
  bool flag = false;
  void getPlannerList(List<PlannerApprovalListModelValues> plannerList) {
    if (plannerApprovalList.isNotEmpty) {
      plannerApprovalList.clear();
    }
    for (int index = 0; index < plannerList.length; index++) {
      plannerApprovalList.add(plannerList.elementAt(index));
    }
  }

  RxList<LeaveApprovePopUpValues> leavePopUp = <LeaveApprovePopUpValues>[].obs;

}
