import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/assigned_task_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_wise_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_list.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/total_effort_data.dart';

class PlannerCreationController extends GetxController {
  RxBool isstatusLoading = RxBool(false);
  RxBool isErrorLoading = RxBool(false);
  RxBool isCategoryTask = RxBool(false);
  RxBool isAssignedTask = RxBool(false);
  RxBool isPlannerCreate = RxBool(false);
  void statusLoading(bool loading) {
    isstatusLoading.value = loading;
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
  assignedTask(List<AssignedTaskListValues> value) {
    if (assignedTaskList.isNotEmpty) {
      assignedTaskList.clear();
    }
    for (int i = 0; i < value.length; i++) {
      if (value.elementAt(i).iSMTPLTAPreviousTask == 1 ||
          value.elementAt(i).iSMTPLTAPreviousTask == '1') {
        assignedTaskList.add(value.elementAt(i));
      } else if ((value.elementAt(i).periodicity == " " ||
              value.elementAt(i).periodicity == null ||
              value.elementAt(i).periodicity == "undefined" ||
              value.elementAt(i).periodicity == '' ||
              value.elementAt(i).periodicity!.toLowerCase() == 'once') &&
          (value.elementAt(i).iSMTPLTAPreviousTask == 0 ||
              value.elementAt(i).iSMTPLTAPreviousTask == null ||
              value.elementAt(i).iSMTPLTAPreviousTask == '' ||
              value.elementAt(i).iSMTPLTAPreviousTask == '0')) {
      } else if (value.elementAt(i).periodicity.toString().toLowerCase() ==
              'daily' &&
          (value.elementAt(i).iSMTPLTAPreviousTask == 0 ||
              value.elementAt(i).iSMTPLTAPreviousTask == null ||
              value.elementAt(i).iSMTPLTAPreviousTask == '' ||
              value.elementAt(i).iSMTPLTAPreviousTask == '0')) {
        assignedTaskList.add(value.elementAt(i));
      }
    }
  }

  //effort list
  RxList<TotalEffortDataValues> effortDataValues =
      <TotalEffortDataValues>[].obs;
  effortData(List<TotalEffortDataValues> data) {
    if (effortDataValues.isNotEmpty) {
      effortDataValues.clear();
    }
    for (int i = 0; i < data.length; i++) {
      effortDataValues.add(data.elementAt(i));
    }
  }
}
