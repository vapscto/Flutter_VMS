import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
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

  //Planner category List
  RxList<CategoryWisePlanModelValues> categoryWisePlan =
      <CategoryWisePlanModelValues>[].obs;

  categoryList(List<CategoryWisePlanModelValues> value) {
    if (categoryWisePlan.isNotEmpty) {
      categoryWisePlan.clear();
    }
    for (int i = 0; i < value.length; i++) {
      categoryWisePlan.add(value.elementAt(i));
    }
  }

  //Assigned plan list
  RxList<AssignedTaskListValues> assignedTaskList =
      <AssignedTaskListValues>[].obs;
  List<NewTableModel> createdTaskList = [];
  assignedTask(List<AssignedTaskListValues> value) {
    if (assignedTaskList.isNotEmpty) {
      assignedTaskList.clear();
    }
    for (int i = 0; i < value.length; i++) {
      // assignedTaskList.add(value.elementAt(i));
      var val = value.elementAt(i);
      var taskEffort = val.iSMTCRASTOEffortInHrs;
      var hrsEff = int.parse(taskEffort.toString());
      var minEff =
          ((double.parse(taskEffort.toString()) - hrsEff) * 60).round();

      if (hrsEff.toString().length == 1) {
        hrsEff = 0 + hrsEff.toInt();
      }

      if (minEff.toString().length == 1) {
        minEff = 0 + minEff;
      }
      if (val.iSMTPLTAPreviousTask == 1 || val.iSMTPLTAPreviousTask == '1') {
        createdTaskList.add(NewTableModel(
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
            iSMTCRASTOStartDate: val.iSMTCRASTOStartDate,
            iSMTCRASTOEndDate: val.iSMTCRASTOEndDate,
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
      } else if ((val.periodicity == " " ||
              val.periodicity == null ||
              val.periodicity == '' ||
              val.periodicity!.toLowerCase() == 'once') &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              val.iSMTPLTAPreviousTask == '' ||
              val.iSMTPLTAPreviousTask == '0')) {
        createdTaskList.add(NewTableModel(
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
            iSMTCRASTOStartDate: val.iSMTCRASTOStartDate,
            iSMTCRASTOEndDate: val.iSMTCRASTOEndDate,
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
      } else if (val.periodicity!.toLowerCase() == 'daily' &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              val.iSMTPLTAPreviousTask == '' ||
              val.iSMTPLTAPreviousTask == '0')) {
        effortDataValues.forEach((mm) {
          var startDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          // var endDate = mm['PDates'] == null || mm['PDates'] == ''
          //     ? DateFormat('dd-MM-yyyy').format(DateTime.now())
          //     : DateFormat('dd-MM-yyyy').format(mm['PDates']);

          // if (mm['PDates'] != null &&
          //     mm['PDates'] != '' &&
          //     mm['PDates'] >= tt['ISMTCRASTO_StartDate'] &&
          //     mm['PDates'] <= tt['ISMTCRASTO_EndDate']) {

          // }
        });
      }
    }
  }

  //effort list
  double totalDay = 0.0;
  double totalHour = 0.0;
  RxList<TotalEffortDataValues> effortDataValues =
      <TotalEffortDataValues>[].obs;
  effortData(List<TotalEffortDataValues> data) {
    if (effortDataValues.isNotEmpty) {
      effortDataValues.clear();
    }
    for (int i = 0; i < data.length; i++) {
      effortDataValues.add(data.elementAt(i));
      // totalDay = 0.0;
      // totalHour = 0.0;
      // totalDay += num.parse(data[i].nOOFDAYS.toString());
      // totalHour += num.parse(data[i].wORKINGHOURS.toString());
    }
  }

  String maxDate = '';
}
