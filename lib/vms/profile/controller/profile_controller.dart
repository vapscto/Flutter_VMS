import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/coe/model/holiday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/birthday_list_model.dart';
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

  RxList<LateInModelValues> lateInData = <LateInModelValues>[].obs;
  double hour = 0;
  double data = 0;
  void newData(List<LateInModelValues> lateIn) {
    data = 0;
    hour = 0;
    if (lateInData.isNotEmpty) {
      lateInData.clear();
    }
    for (int i = 0; i < lateInData.length; i++) {
      data = double.parse(lateInData.elementAt(i).lateby!.replaceAll(":", "."));
      hour += data;
    }
  }
}
