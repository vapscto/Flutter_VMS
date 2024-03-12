import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/vms/coe/model/holiday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/birthday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/dash_board_leave_model.dart';
import 'package:m_skool_flutter/vms/profile/model/issues_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/late_in_model.dart';
import 'package:m_skool_flutter/vms/profile/model/periodicity_model.dart';
import 'package:m_skool_flutter/vms/profile/model/profile_model.dart';
import 'package:m_skool_flutter/vms/profile/model/rating_data_model.dart';

class ProfileController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  RxBool isProfileLoading = RxBool(false);
  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  void profileLoading(bool loading) {
    isProfileLoading.value = loading;
  }

  RxList<ProfileDataModelValues> profileDataValue =
      <ProfileDataModelValues>[].obs;
  void getProfile(List<ProfileDataModelValues> profile) {
    if (profileDataValue.isNotEmpty) {
      profileDataValue.clear();
    }
    for (int i = 0; i < profile.length; i++) {
      profileDataValue.add(profile.elementAt(i));
    }
  }

  RxList<BirthDayListModelValues> birthdayList =
      <BirthDayListModelValues>[].obs;
  void birthday(List<BirthDayListModelValues> birthday) {
    if (birthdayList.isNotEmpty) {
      birthdayList.clear();
    }
    for (int i = 0; i < birthday.length; i++) {
      birthdayList.add(birthday.elementAt(i));
    }
  }

  //Holiday\
  RxList<HolidayListModelValues> holidayList = <HolidayListModelValues>[].obs;
  void getHoliday(List<HolidayListModelValues> holiday) {
    if (holidayList.isNotEmpty) {
      holidayList.clear();
    }
    holidayList.addAll(holiday);
  }

  RxList<PeriodicityListModelValues> periodicityList =
      <PeriodicityListModelValues>[].obs;
  RxBool taskLoading = RxBool(false);
  void taskDataLoading(bool l) {
    taskLoading.value = l;
  }

  RxList<TaskIssuesListModelValues> issuesList =
      <TaskIssuesListModelValues>[].obs;
  RxInt present = 0.obs;
  RxInt absent = 0.obs;
  RxInt holiday = 0.obs;
  RxDouble rating = 0.0.obs;
  RxList<RatingDataModelValues> ratingDataModelValues =
      <RatingDataModelValues>[].obs;

  String lateInMinute = '';
  void newData(List<LateInModelValues> lateIn) {
    lateInMinute = '';
    if (lateIn.isNotEmpty) {
      DateTime todayDate = DateTime.now();
      List<LateInModelValues> lateEarlyList = lateIn;
      // for (int i = 0; i < lateEarlyList.length; i++) {
      if (DateFormat('yyyy-MM-dd').format(DateTime.parse(
                  lateEarlyList[lateIn.length - 1].punchdate!)) ==
              DateFormat('yyyy-MM-dd').format(todayDate) &&
          lateEarlyList[lateIn.length - 1].fOEPDInOutFlg == 'O') {
        lateEarlyList.removeAt(lateIn.length - 1);
      }
      // }

      int totHour = 0;
      int totMin = 0;

      // LATE IN
      for (var late in lateEarlyList) {
        int hourVal = int.parse(late.lateby!.split(':')[0]);
        int minVal = int.parse(late.lateby!.split(':')[1]);
        if (hourVal < 3) {
          totHour += hourVal;
          totMin += minVal;
        }
      }

      // EARLY OUT
      for (var late in lateEarlyList) {
        int hourVal = int.parse(late.earlyby!.split(':')[0]);
        int minVal = int.parse(late.earlyby!.split(':')[1]);
        if (hourVal < 3) {
          totHour += hourVal;
          totMin += minVal;
        }
      }

      if (totMin > 60) {
        totHour += totMin ~/ 60;
        totMin = totMin % 60;
      }

      lateInMinute =
          '$totHour Hr $totMin Min'; // Assign to your lateinminute variable
    }
  }

  RxList<DashBoardLeaveModelValues> leaveDataList =
      <DashBoardLeaveModelValues>[].obs;
}
