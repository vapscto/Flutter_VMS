import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  RxDouble hour = 0.0.obs;
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

  String convertDecimalToTimeInPlanner(double decimalHours) {
    int hours = decimalHours.floor();
    int minutes = ((decimalHours - hours) * 60).round();
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    return '$hoursStr.$minutesStr';
  }

  RxList<CategoryWisePlanModelValues> categoryWisePlan =
      <CategoryWisePlanModelValues>[].obs;
  List<CategoryPlanTable> categoryList = [];
  int effhrcat = 0;
  int effmicat = 0;
  String data = '';
  double time = 0.0;
  String newDatePlanner = '';
  String formattedTime = '';
  double totalEffort = 0.0;
  double requiredEff = 0.0;
  double totalDays = 0.0;
  double totalhour = 0.0;
  //Assigned plan list
  RxList<AssignedTaskListValues> assignedTaskList =
      <AssignedTaskListValues>[].obs;
  List<NewTableModel> createdTaskList = [];
  double plannerDate = 0.0;
  assignedTask(List<AssignedTaskListValues> value) {
    if (createdTaskList.isNotEmpty) {
      assignedTaskList.clear();
      createdTaskList.clear();
    }
    String startDate = '';
    String endDate = '';
    totalhour = 0.0;
    for (int i = 0; i < value.length; i++) {
      assignedTaskList.add(value.elementAt(i));
      var val = value.elementAt(i);
      val.iSMTCRASTOEffortInHrs = double.parse(
          convertDecimalToTimeInPlanner(val.iSMTCRASTOEffortInHrs!));
      if (val.iSMTCRASTOStartDate == null || val.iSMTCRASTOStartDate == '') {
        startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      } else {
        startDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(val.iSMTCRASTOStartDate!));
      }
      if (val.iSMTCRASTOEndDate == null || val.iSMTCRASTOEndDate == '') {
        endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      } else {
        endDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(val.iSMTCRASTOEndDate!));
      }
      if (val.iSMTPLTAPreviousTask == 1) {
        _addDataToList(data, val, startDate, endDate);
      } else if ((val.periodicity == " " ||
              val.periodicity == null ||
              val.periodicity == '' ||
              val.periodicity!.toLowerCase() == 'once') &&
          (val.iSMTPLTAPreviousTask == 0 || val.iSMTPLTAPreviousTask == null)) {
        _addDataToList(data, val, startDate, endDate);
      } else if (val.periodicity!.toLowerCase() == 'daily' &&
          (val.iSMTPLTAPreviousTask == 0 || val.iSMTPLTAPreviousTask == null)) {
        for (var mm in effortDataValues) {
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

          if (DateTime.parse(mm.pDates!)
                  .add(const Duration(days: 1))
                  .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
              DateTime.parse(mm.pDates!)
                  .subtract(const Duration(days: 1))
                  .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
            totalEffort += val.iSMTCRASTOEffortInHrs!;
            _addDataToList(data, val, startDate, endDate);
          }
        }
      } else if (val.periodicity!.toLowerCase() == 'weekly' &&
          (val.iSMTPLTAPreviousTask == 0 || val.iSMTPLTAPreviousTask == null)) {
        int wrkd = effortDataValues.length;
        if (wrkd >= int.parse(val.iSMTAPLDay!)) {
          for (var mm in effortDataValues) {
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
            if (DateTime.parse(mm.pDates!)
                    .add(const Duration(days: 1))
                    .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                DateTime.parse(mm.pDates!)
                    .subtract(const Duration(days: 1))
                    .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
              _addDataToList(data, val, startDate, endDate);
            }
          }
        } else if (int.parse(wrkd.toString()) <
            int.parse(val.iSMTAPLDay.toString())) {
          int cnr = 0;
          for (var mm in effortDataValues) {
            cnr += 1;
            if (cnr == int.parse(wrkd.toString())) {
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

              if (DateTime.parse(mm.pDates!)
                      .add(const Duration(days: 1))
                      .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                  DateTime.parse(mm.pDates!)
                      .subtract(const Duration(days: 1))
                      .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                _addDataToList(data, val, startDate, endDate);
              } else if (int.parse(wrkd.toString()) <
                  int.parse(val.iSMTAPLDay!)) {
                int cnr = 0;
                for (var mm in effortDataValues) {
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
                      endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                    } else {
                      endDate = DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(mm.pDates!));
                    }

                    if (mm.pDates != null &&
                        DateTime.parse(mm.pDates!)
                            .add(const Duration(days: 1))
                            .isAfter(
                                DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                        DateTime.parse(mm.pDates!)
                            .subtract(const Duration(days: 1))
                            .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                      _addDataToList(data, val, startDate, endDate);
                    }
                  }
                }
              }
            }
          }
        }
      } else if (val.periodicity!.toLowerCase() == 'once in fortnight' &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '' ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '0')) {
        int ddcnt = int.parse(val.iSMTAPLDay!) - 1;
        DateTime date = DateTime.now();
        DateTime firstDay = DateTime(date.year, date.month, 1);
        DateTime newDate = firstDay.add(Duration(days: ddcnt));
        DateTime anewDate = firstDay.add(Duration(days: ddcnt + 15));

        String newDate1 = DateFormat('dd-MM-yyyy').format(newDate);
        String anewDate1 = DateFormat('dd-MM-yyyy').format(anewDate);

        for (var mm in effortDataValues) {
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
            _addDataToList(data, val, startDate, endDate);
          }

          if (anewDate1 == endDate) {
            _addDataToList(data, val, startDate, endDate);
          }
        }
      } else if (val.periodicity!.toLowerCase() == 'monthly' &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '' ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '0')) {
        if (val.weekfirsttrue != 0) {
          if (val.firsttrue != 0) {
            _addDataToList(data, val, startDate, endDate);
          }
        } else if (val.weeksecondtrue != 0) {
          if (val.secondtrue != 0) {
            _addDataToList(data, val, startDate, endDate);
          }
        }
      } else if ((val.periodicity!.toLowerCase() == 'yearly once' ||
              val.periodicity!.toLowerCase() == 'specific day') &&
          (val.iSMTPLTAPreviousTask == 0 ||
              val.iSMTPLTAPreviousTask == null ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '' ||
              // ignore: unrelated_type_equality_checks
              val.iSMTPLTAPreviousTask == '0')) {
        String newdate1 = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(val.oFFDate ?? '1970-01-01T00:00:00'));
        for (var mm in effortDataValues) {
          startDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          endDate = mm.pDates == null || mm.pDates == ''
              ? DateFormat('dd-MM-yyyy').format(DateTime.now())
              : DateFormat('dd-MM-yyyy').format(DateTime.parse(mm.pDates!));

          if (newdate1 == endDate) {
            _addDataToList(data, val, startDate, endDate);
          }
        }
      }
    }
  }

  //effort list

  void categoryListData(List<CategoryWisePlanModelValues> value) {
    if (categoryWisePlan.isNotEmpty) {
      categoryWisePlan.clear();
    }
    categoryWisePlan.addAll(value);
  }

  _addDataToList(String data, AssignedTaskListValues val, String startDate,
      String endDate) {
    createdTaskList.add(NewTableModel(
        // newTime: time,
        time: data,
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
        iSMTCRASTOStartDate: val.iSMTCRASTOStartDate, // startDate,
        iSMTCRASTOEndDate: val.iSMTCRASTOEndDate, //endDate,
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
