import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/student_birthday/model/student_bday_model.dart';

class BdayController extends GetxController {
  RxBool isFromDateProvided = RxBool(false);
  RxBool isLoadingBday = RxBool(false);
  Rx<DateTime> fromSelectedDate = Rx(DateTime.now());
  Rx<DateTime> toSelectedDate = Rx(DateTime.now());

  void updateIsFromDateProvided(bool isProvided) {
    isFromDateProvided.value = isProvided;
  }

  void updateIsLoadingBday(bool isLoading) {
    isLoadingBday.value = isLoading;
  }

  void updateFromSelectedDate(DateTime now) {
    fromSelectedDate.value = now;
  }

  void updateToSelectedDate(DateTime now) {
    toSelectedDate.value = now;
  }

  RxList<StudentBdayModelValues> studentBdayList = RxList();
  void updateStudentBdayList(List<StudentBdayModelValues> mList) {
    if (studentBdayList.isNotEmpty) {
      studentBdayList.clear();
    }
    studentBdayList.addAll(mList);
  }

  RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool error) {
    isErrorOccured.value = error;
  }

  RxMap<String, dynamic> errorMap = RxMap();

  void updateErrorMap(Map<String, dynamic> err) {
    errorMap.value = err;
  }
}
