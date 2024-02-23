import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_emp_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_month.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_year_model.dart';

class EmpRatingController extends GetxController {
  RxBool isEmpLoading = RxBool(false);
  RxBool isAcademicyearLoading = RxBool(false);
  RxBool ismonthLoading = RxBool(false);
  void empLoad(bool l) {
    isEmpLoading.value = l;
  }

  void academicLoad(bool l) {
    isAcademicyearLoading.value = l;
  }

  void monthLoad(bool l) {
    ismonthLoading.value = l;
  }

  RxList<RatingEmpModelValues> employeeList = <RatingEmpModelValues>[].obs;
  RxList<RatingMonthModelValues> monthList = <RatingMonthModelValues>[].obs;
  RxList<RatingYearModelValues> yearList = <RatingYearModelValues>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
  RxList<RatingEmpModelValues> selectedEmployeeList =
      <RatingEmpModelValues>[].obs;
  void addToSelectedEmployee(RatingEmpModelValues sele) {
    selectedEmployeeList.add(sele);
  }

  void removeFromSelectedEmployee(RatingEmpModelValues sele) {
    selectedEmployeeList.remove(sele);
  }

  //
  RxList<RatingMonthModelValues> selectedMonthList =
      <RatingMonthModelValues>[].obs;
  void addToSelectedMonth(RatingMonthModelValues sele) {
    selectedMonthList.add(sele);
  }

  void removeFromSelectedMonth(RatingMonthModelValues sele) {
    selectedMonthList.remove(sele);
  }

  //
  RxList<RatingYearModelValues> selectedYearList =
      <RatingYearModelValues>[].obs;
  void addToSelectedYear(RatingYearModelValues sele) {
    selectedYearList.add(sele);
  }

  void removeFromSelectedYear(RatingYearModelValues sele) {
    selectedYearList.remove(sele);
  }
}
