import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/total_effort_data.dart';

class TaskListAPI {
  TaskListAPI.init();
  static final TaskListAPI instance = TaskListAPI.init();
  Future<void> getList({
    required String base,
    required PlannerCreationController plannerCreationController,
    required int userId,
    required int miId,
    required int asmayId,
    required String flag,
    required String startDate,
    required String endDate,
    required int hrmeId,
  }) async {
    var dio = Dio();
    var url = base + URLS.assignTaskList;
    try {
      if (plannerCreationController.isErrorLoading.value) {
        plannerCreationController.errorLoading(false);
      }
      plannerCreationController.taskLoading(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Role_flag": "S",
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate,
        "HRME_Id": hrmeId,
      });
      logger.i(url);
      logger.i({
        "UserId": userId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Role_flag": "S",
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate,
        "HRME_Id": hrmeId,
      });
      if (response.statusCode == 200) {
        TotalEffortData totalEffortData =
            TotalEffortData.fromJson(response.data['get_effortdetails']);
        plannerCreationController.effortData(totalEffortData.values!);
        CategoryWisePlanModel categoryWisePlanModel =
            CategoryWisePlanModel.fromJson(response.data['categorylist']);
        plannerCreationController
            .categoryListData(categoryWisePlanModel.values!);
        AssignedTaskList assignedTaskList =
            AssignedTaskList.fromJson(response.data['get_Assignedtasklist']);
        if (assignedTaskList.values!.isNotEmpty) {
          String startDate = '';
          String endDate = '';
          plannerCreationController.createdTaskList.clear();
          for (int i = 0; i < assignedTaskList.values!.length; i++) {
            var val = assignedTaskList.values!.elementAt(i);
            val.iSMTCRASTOEffortInHrs = double.parse(
                convertDecimalToTimeInPlanner(val.iSMTCRASTOEffortInHrs!));
            // Date Calculation

            if (val.iSMTCRASTOStartDate == null ||
                val.iSMTCRASTOStartDate == '') {
              startDate = getCurrentDate();
            } else {
              startDate = DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(val.iSMTCRASTOStartDate!));
            }

            if (val.iSMTCRASTOEndDate == null || val.iSMTCRASTOEndDate == '') {
              endDate = getCurrentDate();
            } else {
              endDate = DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(val.iSMTCRASTOEndDate!));
            }
            //
            if (val.iSMTPLTAPreviousTask == 1) {
              plannerCreationController.addDataToList(val, startDate, endDate);
              logger.i('1');
            } else if (val.periodicity!.toLowerCase() == 'daily' &&
                    val.iSMTPLTAPreviousTask == 0 ||
                val.iSMTPLTAPreviousTask == null) {
              for (var mm in totalEffortData.values!) {
                logger.e('2');
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
                        .add(const Duration(days: 1))
                        .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                    DateTime.parse(mm.pDates!)
                        .subtract(const Duration(days: 1))
                        .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
                }
              }
            } else if ((val.periodicity == " " ||
                    val.periodicity == null ||
                    val.periodicity == '' ||
                    val.periodicity!.toLowerCase() == 'once') &&
                (val.iSMTPLTAPreviousTask == 0 ||
                    val.iSMTPLTAPreviousTask == null)) {
              plannerCreationController.addDataToList(val, startDate, endDate);
            } else if (val.periodicity!.toLowerCase() == 'weekly' &&
                (val.iSMTPLTAPreviousTask == 0 ||
                    val.iSMTPLTAPreviousTask == null)) {
              int wrkd = totalEffortData.values!.length;
              if (wrkd >= int.parse(val.iSMTAPLDay!)) {
                for (var mm in totalEffortData.values!) {
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
                          .add(const Duration(days: 1))
                          .isAfter(DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                      DateTime.parse(mm.pDates!)
                          .subtract(const Duration(days: 1))
                          .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                    plannerCreationController.addDataToList(
                        val, startDate, endDate);
                  }
                }
              } else if (int.parse(wrkd.toString()) <
                  int.parse(val.iSMTAPLDay.toString())) {
                int cnr = 0;
                for (var mm in totalEffortData.values!) {
                  cnr += 1;
                  if (cnr == int.parse(wrkd.toString())) {
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

                    if (DateTime.parse(mm.pDates!)
                            .add(const Duration(days: 1))
                            .isAfter(
                                DateTime.parse(val.iSMTCRASTOStartDate!)) &&
                        DateTime.parse(mm.pDates!)
                            .subtract(const Duration(days: 1))
                            .isBefore(DateTime.parse(val.iSMTCRASTOEndDate!))) {
                      plannerCreationController.addDataToList(
                          val, startDate, endDate);
                    } else if (int.parse(wrkd.toString()) <
                        int.parse(val.iSMTAPLDay!)) {
                      int cnr = 0;
                      for (var mm in totalEffortData.values!) {
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
                              DateTime.parse(mm.pDates!)
                                  .add(const Duration(days: 1))
                                  .isAfter(DateTime.parse(
                                      val.iSMTCRASTOStartDate!)) &&
                              DateTime.parse(mm.pDates!)
                                  .subtract(const Duration(days: 1))
                                  .isBefore(
                                      DateTime.parse(val.iSMTCRASTOEndDate!))) {
                            plannerCreationController.addDataToList(
                                val, startDate, endDate);
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

              for (var mm in totalEffortData.values!) {
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

                if (newDate1 == endDate) {
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
                }

                if (anewDate1 == endDate) {
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
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
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
                }
              } else if (val.weeksecondtrue != 0) {
                if (val.secondtrue != 0) {
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
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
              for (var mm in totalEffortData.values!) {
                startDate = mm.pDates == null || mm.pDates == ''
                    ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                    : DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(mm.pDates!));

                endDate = mm.pDates == null || mm.pDates == ''
                    ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                    : DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(mm.pDates!));

                if (newdate1 == endDate) {
                  plannerCreationController.addDataToList(
                      val, startDate, endDate);
                }
              }
            }
          }
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
      plannerCreationController.errorLoading(true);
    } on Exception catch (e) {
      logger.i(e);
    }
  }
}

String convertDecimalToTimeInPlanner(double decimalHours) {
  int hours = decimalHours.floor();
  int minutes = ((decimalHours - hours) * 60).round();
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');
  return '$hoursStr.$minutesStr';
}

String getCurrentDate() {
  return DateFormat('dd-MM-yyyy').format(DateTime.now());
}
