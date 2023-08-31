import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_classes_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';

class StaffTTController extends GetxController {
  RxBool isWholePageLoading = RxBool(true);

  void updateIsWholePageLoading(bool updates) {
    isWholePageLoading.value = updates;
  }

  RxBool isErrorOccuredWhileLoadingPage = RxBool(false);

  void updateIsErrorOccuredWhileLoadingPage(bool error) {
    isErrorOccuredWhileLoadingPage.value = error;
  }

  RxString errorOccuredAt = RxString("Error Occured while loading day");

  void updateErrorOccuredAt(String occuredAt) {
    errorOccuredAt.value = occuredAt;
  }

  RxString loadingStatus = RxString("Loading Day's");

  void updateLoadingStatus(String newLoadingStatus) {
    loadingStatus.value = newLoadingStatus;
  }

  Rx<DailyTTDaysModelValues> selectedDayForDailyTT =
      Rx<DailyTTDaysModelValues>(DailyTTDaysModelValues());

  void updateSelectedDayForDailyTT(DailyTTDaysModelValues value) {
    selectedDayForDailyTT.value = value;
  }

  RxList<DailyTTDaysModelValues> dailyTTDays = RxList();

  void updateDailyTTDays(List<DailyTTDaysModelValues> val) {
    if (dailyTTDays.isNotEmpty) {
      dailyTTDays.clear();
    }

    dailyTTDays.addAll(val);
  }

  RxList<DailyTTClassesModelValues> dailyTT = RxList();

  void updateDailyTT(List<DailyTTClassesModelValues> daily) {
    if (dailyTT.isNotEmpty) {
      dailyTT.clear();
    }

    dailyTT.addAll(daily);
  }

  RxBool isTTLoading = RxBool(false);

  void updateIsTTLoading(bool v) {
    isTTLoading.value = v;
  }

  RxBool isErrorOccuredAtLoadingTT = RxBool(false);

  void updateIsErrorOcurredAtLoadingTT(bool b) {
    isErrorOccuredAtLoadingTT.value = b;
  }
}
