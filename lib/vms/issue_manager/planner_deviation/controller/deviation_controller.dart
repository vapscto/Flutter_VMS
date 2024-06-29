import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/model/dev_details_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/model/dev_emp_list_model.dart';

class DeviationController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxList<bool> selectCheckBox = <bool>[].obs;

  RxList<DeviationEmpModelValues> empList = <DeviationEmpModelValues>[].obs;
  RxList<DeviationEmpModelValues> addedEmpList =
      <DeviationEmpModelValues>[].obs;
  RxList<DeviationEmpModelValues> filterEmpList =
      <DeviationEmpModelValues>[].obs;
  RxBool isDeviation = RxBool(false);
  void deviation(bool b) {
    isDeviation.value = b;
  }

  String startDate = '';
  String endDate = '';
  RxList<DeviationDetailsModelValues> deviationDetails =
      <DeviationDetailsModelValues>[].obs;
  void getDeviation(List<DeviationDetailsModelValues> deviation) {
    deviationDetails.value = deviation;
  }

  List<EmployeeDeviationDetails> processDeviationReport(
      List<DeviationDetailsModelValues> report) {
    List<EmployeeDeviationDetails> employeeId = [];

    for (var dev in report) {
      if (employeeId.isEmpty) {
        employeeId.add(EmployeeDeviationDetails(
            hRMEId: dev.hRMEId,
            employeename: dev.employeename,
            deviationPercentage: dev.deviationPercentage,
            plannerdetails: [
              DeviationDetailsModelValues(
                iSMTPLId: dev.iSMTPLId,
                hRMEId: dev.hRMEId,
                iSMTPLPlannerName: dev.iSMTPLPlannerName,
                employeename: dev.employeename,
                iSMTPLStartDate: dev.iSMTPLStartDate,
                iSMTPLEndDate: dev.iSMTPLEndDate,
                totalEffort: dev.totalEffort,
                completedEffort: dev.completedEffort,
                notCompletedEffort: dev.notCompletedEffort,
                completedPercentage: dev.completedPercentage,
                deviationPercentage: dev.deviationPercentage,
              )
            ]));
      } else {
        int count = 0;
        for (var emp in employeeId) {
          if (emp.hRMEId == dev.hRMEId) {
            count += 1;
          }
        }
        if (count == 0) {
          employeeId.add(EmployeeDeviationDetails(
              hRMEId: dev.hRMEId,
              employeename: dev.employeename,
              deviationPercentage: dev.deviationPercentage,
              plannerdetails: [
                DeviationDetailsModelValues(
                  iSMTPLId: dev.iSMTPLId,
                  hRMEId: dev.hRMEId,
                  iSMTPLPlannerName: dev.iSMTPLPlannerName,
                  employeename: dev.employeename,
                  iSMTPLStartDate: dev.iSMTPLStartDate,
                  iSMTPLEndDate: dev.iSMTPLEndDate,
                  totalEffort: dev.totalEffort,
                  completedEffort: dev.completedEffort,
                  notCompletedEffort: dev.notCompletedEffort,
                  completedPercentage: dev.completedPercentage,
                  deviationPercentage: dev.deviationPercentage,
                )
              ]));
        }
      }
    }

    for (var ddd in employeeId) {
      List<DeviationDetailsModelValues> templist = [];
      double sumDeviation = 0;
      for (var dd in report) {
        if (dd.hRMEId == ddd.hRMEId) {
          sumDeviation += dd.deviationPercentage ?? 0;
          templist.add(dd);
        }
      }
      ddd.plannerdetails = templist;
      ddd.percentage = (sumDeviation / templist.length).toStringAsFixed(2);
    }

    return employeeId;
  }
}

class EmployeeDeviationDetails {
  int? hRMEId;
  String? employeename;
  double? deviationPercentage;
  List<DeviationDetailsModelValues> plannerdetails;
  String? percentage;

  EmployeeDeviationDetails({
    this.hRMEId,
    this.employeename,
    this.deviationPercentage,
    this.plannerdetails = const [],
    this.percentage,
  });
}
