import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/new_table_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/total_effort_data.dart';

import '../../../../main.dart';

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
  List<Map<String, dynamic>> categoryListModel = [];
  categoryList(List<CategoryWisePlanModelValues> value) {
    if (categoryWisePlan.isNotEmpty) {
      categoryWisePlan.clear();
    }
    for (int i = 0; i < value.length; i++) {
      categoryWisePlan.add(value.elementAt(i));
      // effortDataValues.forEach((tt) {
      //   double ddd = 0;
      //   assignedTaskList.forEach((dd) {
      //     if (int.parse(tt.ismmtcaTId.toString()) ==
      //         int.parse(dd.ismmtcaTId.toString())) {
      //       ddd += double.parse(dd.ismtcrastOEffortInHrs.toString());
      //     }
      //   });

      //   double pp;
      //   if (ddd != 0) {
      //     pp = (double.parse(tt.ismmtcaTTaskPercentage.toString()) / 100) *
      //         mineffort;
      //   } else {
      //     pp = (double.parse(tt.ismmtcaTTaskPercentage.toString()) / 100) *
      //         mineffort;
      //     categoryListModel.add({
      //       'CATNAME': tt.ismmtcaTTaskCategoryName,
      //       'RP': tt.ismmtcaTTaskPercentage,
      //       'CWP': 0,
      //       'CRE': pp,
      //       'CCE': 0,
      //     });
      //   }

      //   if (pp > ddd && ddd != 0) {
      //     categoryListModel.add({
      //       'CATNAME': tt.ismmtcaTTaskCategoryName,
      //       'RP': tt.ismmtcaTTaskPercentage,
      //       'CRE': pp,
      //       'CCE': ddd,
      //     });
      //   }
      // });
    }
  }

  //Assigned plan list
  RxList<AssignedTaskListValues> assignedTaskList =
      <AssignedTaskListValues>[].obs;
  List<NewTableModel> createdTaskList = [];
  assignedTask(List<AssignedTaskListValues> value) {
    if (createdTaskList.isNotEmpty) {
      assignedTaskList.clear();
      createdTaskList.clear();
    }
    for (int i = 0; i < value.length; i++) {
      assignedTaskList.add(value.elementAt(i));
      var val = value.elementAt(i);
      double min = 0.0;
      double taskEffort = val.iSMTCRASTOEffortInHrs!;
      int hrsEff = taskEffort.toInt();
      var minEff = ((taskEffort - hrsEff) * 60).round();
      logger.w(taskEffort);
      logger.i(minEff);
      logger.e(hrsEff.toString().length);
      if (hrsEff.toString().length == 1) {
        hrsEff = int.parse('0${hrsEff.toString()}');
      } else if (minEff.toString().length == 1) {
        logger.v(minEff.toString().length);
        String minEffString = (minEff.toString().padLeft(2, '0'));
        minEff = int.parse('0${minEff.toString()}');
        logger.d('==$minEffString');
      }
      val.iSMTCRASTOEffortInHrs = double.parse('$hrsEff.$minEff');
      if (val.iSMTPLTAPreviousTask == 1 || val.iSMTPLTAPreviousTask == '1') {
        createdTaskList.add(NewTableModel(
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

          var endDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          if (mm.pDates != null &&
              mm.pDates != '' &&
              DateTime.parse(mm.pDates!)
                  .isBefore(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
              DateTime.parse(mm.pDates!)
                  .isAfter(DateTime.parse(val.iSMTCRASTOEndDate!))) {
            createdTaskList.add(NewTableModel(
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
          } else if (val.periodicity!.toLowerCase() == 'weekly' &&
              (val.iSMTPLTAPreviousTask == 0 ||
                  val.iSMTPLTAPreviousTask == null ||
                  val.iSMTPLTAPreviousTask == '' ||
                  val.iSMTPLTAPreviousTask == '0')) {
            int wrkd = effortDataValues.length;
            if (wrkd >= int.parse(val.iSMTAPLDay!)) {
              int cnr = 0;
              effortDataValues.forEach((mm) {
                String startDate, endDate;
                if (mm.pDates == null || mm.pDates == '') {
                  startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                } else {
                  startDate = DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(mm.pDates!));
                }

                if (mm.pDates == null || mm.pDates == '') {
                  endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                } else {
                  endDate = DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(mm.pDates!));
                }
                if (DateTime.parse(mm.pDates!)
                        .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                    DateTime.parse(mm.pDates!)
                        .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                  createdTaskList.add(NewTableModel(
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
                }
              });
            } else if (int.parse(wrkd.toString()) <
                int.parse(val.iSMTAPLDay.toString())) {
              int cnr = 0;
              effortDataValues.forEach((mm) {
                cnr += 1;
                if (cnr == int.parse(wrkd.toString())) {
                  String startDate, endDate;
                  if (mm.pDates == null || mm.pDates == '') {
                    startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  } else {
                    startDate = DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(mm.pDates!));
                  }

                  if (mm.pDates == null || mm.pDates == '') {
                    endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  } else {
                    endDate = DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(mm.pDates!));
                  }

                  if (DateTime.parse(mm.pDates!)
                          .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                      DateTime.parse(mm.pDates!)
                          .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                    createdTaskList.add(NewTableModel(
                        flag: true,
                        iSMTCRASTOId: val.iSMTCRASTOId,
                        iSMTCRId: val.iSMTCRId,
                        hRMDId: val.hRMDId,
                        hRMDDepartmentName: val.hRMDDepartmentName,
                        hRMPRId: val.hRMPRId,
                        hRMPName: val.hRMPName,
                        iSMTCRBugOREnhancementFlg:
                            val.iSMTCRBugOREnhancementFlg,
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
                  } else if (int.parse(wrkd.toString()) <
                      int.parse(val.iSMTAPLDay!)) {
                    int cnr = 0;
                    effortDataValues.forEach((mm) {
                      cnr += 1;
                      if (cnr == int.parse(wrkd.toString())) {
                        String startDate, endDate;
                        if (mm.pDates == null || mm.pDates == '') {
                          startDate =
                              DateFormat('dd-MM-yyyy').format(DateTime.now());
                        } else {
                          startDate = DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(mm.pDates!));
                        }

                        if (mm.pDates == null || mm.pDates == '') {
                          endDate =
                              DateFormat('dd-MM-yyyy').format(DateTime.now());
                        } else {
                          endDate = DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(mm.pDates!));
                        }

                        if (mm.pDates != null &&
                            DateTime.parse(mm.pDates!).isAfter(
                                DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                            DateTime.parse(mm.pDates!).isBefore(
                                DateTime.parse(val.iSMTCRASTOEndDate!))) {
                          createdTaskList.add(NewTableModel(
                              flag: true,
                              iSMTCRASTOId: val.iSMTCRASTOId,
                              iSMTCRId: val.iSMTCRId,
                              hRMDId: val.hRMDId,
                              hRMDDepartmentName: val.hRMDDepartmentName,
                              hRMPRId: val.hRMPRId,
                              hRMPName: val.hRMPName,
                              iSMTCRBugOREnhancementFlg:
                                  val.iSMTCRBugOREnhancementFlg,
                              iSMTCRCreationDate: val.iSMTCRCreationDate,
                              iSMTCRTitle: val.iSMTCRTitle,
                              iSMTCRDesc: val.iSMTCRDesc,
                              iSMTCRStatus: val.iSMTCRStatus,
                              iSMTCRReOpenFlg: val.iSMTCRReOpenFlg,
                              iSMTCRReOpenDate: val.iSMTCRReOpenDate,
                              iSMTCRTaskNo: val.iSMTCRTaskNo,
                              iSMMCLTId: val.iSMMCLTId,
                              iSMMCLTClientName: val.iSMMCLTClientName,
                              iSMTCRASTOAssignedDate:
                                  val.iSMTCRASTOAssignedDate,
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
                              iSMMTCATTaskCategoryName:
                                  val.iSMMTCATTaskCategoryName,
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
                      }
                    });
                  }
                }
              });
            }
          } else if (val.periodicity!.toLowerCase() == 'once in fortnight' &&
              (val.iSMTPLTAPreviousTask == 0 ||
                  val.iSMTPLTAPreviousTask == null ||
                  val.iSMTPLTAPreviousTask == '' ||
                  val.iSMTPLTAPreviousTask == '0')) {
            int ddcnt = int.parse(val.iSMTAPLDay!) - 1;
            int wrkd = effortDataValues.length;
            DateTime date = DateTime.now();
            DateTime firstDay = DateTime(date.year, date.month, 1);
            DateTime newDate = firstDay.add(Duration(days: ddcnt));
            DateTime anewDate = firstDay.add(Duration(days: ddcnt + 15));

            String newDate1 = DateFormat('dd-MM-yyyy').format(newDate);
            String anewDate1 = DateFormat('dd-MM-yyyy').format(anewDate);

            int cnr = 0;
            effortDataValues.forEach((mm) {
              if (mm.pDates == null || mm.pDates == '') {
                startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
              } else {
                startDate =
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));
              }
              if (mm.pDates == null || mm.pDates == '') {
                endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
              } else {
                endDate =
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));
              }

              if (newDate1 == endDate) {
                createdTaskList.add(NewTableModel(
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
              }

              if (anewDate1 == endDate) {
                createdTaskList.add(NewTableModel(
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
              }
            });
          }
        });
      } else if (val.periodicity!.toLowerCase() == 'monthly' &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              val.iSMTPLTAPreviousTask == '' ||
              val.iSMTPLTAPreviousTask == '0')) {
        String ttdate1 =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(val.addeddate1!));
        String ttdate2 =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(val.addeddate2!));

        if (val.weekfirsttrue != 0) {
          if (val.firsttrue != 0) {
            createdTaskList.add(NewTableModel(
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
          }
        } else if (val.weeksecondtrue != 0) {
          if (val.secondtrue != 0) {
            createdTaskList.add(NewTableModel(
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
          }
        }
      } else if ((val.periodicity!.toLowerCase() == 'yearly once' ||
              val.periodicity!.toLowerCase() == 'specific day') &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              val.iSMTPLTAPreviousTask == '' ||
              val.iSMTPLTAPreviousTask == '0')) {
        String newdate1 = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(val.oFFDate ?? '1970-01-01T00:00:00'));
        int cnr = 0;

        for (var mm in effortDataValues) {
          String startDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          String endDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          if (newdate1 == endDate) {
            createdTaskList.add(NewTableModel(
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
          }
        }
      }
    }
  }

  //effort list
  double totalDay = 0.0;
  double totalHour = 0.0;
  double hour = 0.0;
  RxList<TotalEffortDataValues> effortDataValues =
      <TotalEffortDataValues>[].obs;
  effortData(List<TotalEffortDataValues> data) {
    if (effortDataValues.isNotEmpty) {
      effortDataValues.clear();
    }
    totalHour = 0.0;
    totalDay = 0.0;
    hour = 0.0;
    totalDay += (data.length);
    for (int i = 0; i < data.length; i++) {
      effortDataValues.add(data.elementAt(i));
      hour = data[i].wORKINGHOURS!;
    }
  }

  String maxDate = '';
}
