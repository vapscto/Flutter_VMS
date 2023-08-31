import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_daily_Day_model.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_daily_class_section.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_time_table_stafflist_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_tt_model.dart';

class ManagerTimeTableController extends GetxController {
  final RxBool isLoadingStaffList = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingStaffList = RxBool(false);

  void updateIsLoadingStaffList(bool b) {
    isLoadingStaffList.value = b;
  }

  void updateIsErrorOccuredWhileLoadingStaffList(bool b) {
    isErrorOccuredWhileLoadingStaffList.value = b;
  }

  final RxList<ManagerTimeTableStaffListValues> staffList = RxList();

  void updatestaffList(List<ManagerTimeTableStaffListValues> staff) {
    if (staffList.isNotEmpty) {
      staffList.clear();
    }
    staffList.addAll(staff);
  }

  ManagerTimeTableStaffListValues? selectedStaffList;

  ///////////////

  final RxBool isLoadingDailyDayTT = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingDailyDayTT = RxBool(false);

  void updateIsLoadingDailyDayTT(bool b) {
    isLoadingDailyDayTT.value = b;
  }

  void updateIsErrorOccuredWhileLoadingDailyDayTT(bool b) {
    isErrorOccuredWhileLoadingDailyDayTT.value = b;
  }

  final RxList<ManagerDailyDayModelValues> dayList = RxList();

  void updateDayList(List<ManagerDailyDayModelValues> day) {
    if (dayList.isNotEmpty) {
      dayList.clear();
    }
    dayList.addAll(day);
  }

  ManagerDailyDayModelValues? selectedDayList;

  ///////////// Daily Time Table///

  final RxBool isLoadingDailyTT = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingDailyTT = RxBool(false);

  void updateIsLoadingDailyTT(bool b) {
    isLoadingDailyTT.value = b;
  }

  void updateIsErrorOccuredWhileLoadingDailyTT(bool b) {
    isErrorOccuredWhileLoadingDailyTT.value = b;
  }

  final RxList<ManagerDailyClassSectionModelValues> day = RxList();

  void updateDailyTT(List<ManagerDailyClassSectionModelValues> daily) {
    if (day.isNotEmpty) {
      day.clear();
    }
    day.addAll(daily);
  }

  ManagerDailyClassSectionModelValues? selectedDailyTT;

  /////////////

  final RxBool isLoadingWeeklyTT = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingWeeklyTT = RxBool(false);

  void updateIsLoadingWeeklyTT(bool b) {
    isLoadingWeeklyTT.value = b;
  }

  void updateIsErrorOccuredWhileLoadingWeeklyTT(bool b) {
    isErrorOccuredWhileLoadingWeeklyTT.value = b;
  }

  WeeklyTTData? weeklyTT;

  void updateWeeklyTT(WeeklyTTData week) {
    weeklyTT = week;
  }

  StaffWeeklyTTModel? selectedWeeklyTT;
}
