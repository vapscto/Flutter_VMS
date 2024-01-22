import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_plan_table.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/new_table_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/total_effort_data.dart';

class PlannerCreationController extends GetxController {
  RxBool isstatusLoading = RxBool(false);
  RxBool isErrorLoading = RxBool(false);
  RxBool isCategoryTask = RxBool(false);
  RxBool isAssignedTask = RxBool(false);
  RxBool isPlannerCreate = RxBool(false);
  RxBool isPlannerLoading = RxBool(false);
  void statusLoading(bool loading) {
    isstatusLoading.value = loading;
  }

  void plannerLoading(bool loading) {
    isPlannerLoading.value = loading;
  }

  void taskLoading(bool loading) {
    isAssignedTask.value = loading;
  }

  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  RxList<PlannerStatusListModelValues> plannerStatus =
      <PlannerStatusListModelValues>[].obs;

  getPlannerStatus(List<PlannerStatusListModelValues> value) {
    if (plannerStatus.isNotEmpty) {
      plannerStatus.clear();
    }
    for (int index = 0; index < value.length; index++) {
      plannerStatus.add(value.elementAt(index));
    }
  }

  double totalHour = 0.0;
  RxList<TotalEffortDataValues> effortDataValues =
      <TotalEffortDataValues>[].obs;
  List<double> newHour = [];
  effortData(List<TotalEffortDataValues> data) {
    if (effortDataValues.isNotEmpty) {
      effortDataValues.clear();
    }
    effortDataValues.addAll(data);
  }

  //Planner category List
  String convertDecimalToTime(double decimalHours) {
    int hours = decimalHours.floor();
    int minutes = ((decimalHours - hours) * 60).round();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr';
  }

  RxList<CategoryWisePlanModelValues> categoryWisePlan =
      <CategoryWisePlanModelValues>[].obs;
  List<CategoryPlanTable> categoryList = [];
  List<NewTableModel> createdTaskList = [];
  //effort list
  void categoryListData(List<CategoryWisePlanModelValues> value) {
    if (categoryWisePlan.isNotEmpty) {
      categoryWisePlan.clear();
    }
    categoryWisePlan.addAll(value);
  }

  void addDataToList(
      AssignedTaskListValues val, String startDate, String endDate) {
    createdTaskList.add(NewTableModel(
        time: '',
        flag: true,
        iSMTCRASTOId: val.iSMTCRASTOId,
        iSMTCRId: val.iSMTCRId,
        hRMDId: val.hRMDId,
        hRMDDepartmentName: val.hRMDDepartmentName,
        hRMPRId: val.hRMPRId,
        hRMPName: val.hRMPName,
        iSMTCRBugOREnhancementFlg: val.iSMTCRBugOREnhancementFlg,
        iSMTCRCreationDate: val.iSMTCRCreationDate,
        iSMTCRTitle: val.iSMTCRTitle,
        iSMTCRDesc: val.iSMTCRDesc,
        iSMTCRStatus: val.iSMTCRStatus,
        iSMTCRReOpenFlg: val.iSMTCRReOpenFlg,
        iSMTCRReOpenDate: val.iSMTCRReOpenDate,
        iSMTCRTaskNo: val.iSMTCRTaskNo,
        iSMMCLTId: val.iSMMCLTId,
        iSMMCLTClientName: val.iSMMCLTClientName,
        iSMTCRASTOAssignedDate: val.iSMTCRASTOAssignedDate,
        iSMTCRASTORemarks: val.iSMTCRASTORemarks,
        iSMTCRASTOStartDate: startDate,
        iSMTCRASTOEndDate: endDate,
        iSMTCRASTOEffortInHrs: val.iSMTCRASTOEffortInHrs,
        assignedby: val.assignedby,
        periodicity: val.periodicity,
        iSMTAPLDay: val.iSMTAPLDay,
        oFFDate: val.oFFDate,
        iSMTPLTAId: val.iSMTPLTAId,
        iSMMTCATId: val.iSMMTCATId,
        iSMMTCATTaskCategoryName: val.iSMMTCATTaskCategoryName,
        iSMMTCATCompulsoryFlg: val.iSMMTCATCompulsoryFlg,
        iSMTPLTAStatus: val.iSMTPLTAStatus,
        iSMTPLTAPreviousTask: val.iSMTPLTAPreviousTask,
        iSMTPLTAApprovalFlg: val.iSMTPLTAApprovalFlg,
        iSMTPLTAStartDate: val.iSMTPLTAStartDate,
        iSMTPLTAEndDate: val.iSMTPLTAEndDate,
        yrplan: val.yrplan,
        priorityswitch: val.priorityswitch,
        firstDate1: val.firstDate1,
        firstDate2: val.firstDate2,
        weekStartDate: val.weekStartDate,
        weekEndDate: val.weekEndDate,
        addeddate1: val.addeddate1,
        addeddate2: val.addeddate2,
        firsttrue: val.firsttrue,
        secondtrue: val.secondtrue,
        weekfirsttrue: val.weekfirsttrue,
        weeksecondtrue: val.weeksecondtrue));
  }

  String maxDate = '';
}
