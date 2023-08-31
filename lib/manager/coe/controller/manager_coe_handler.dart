import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_academic_data_model.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_event_data_model.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_month_data.dart';

class ManagerCoeHandler extends GetxController {
  RxBool isErrorOccuredWhileLoadingAcademic = RxBool(false);
  void updateIsErrorOccuredWhileLoadingAcademic(bool b) {
    isErrorOccuredWhileLoadingAcademic.value = b;
  }

  RxBool isErrorOccuredWhileLoadingMonth = RxBool(false);

  void updateIsErrorOccuredWhileLoadingMonth(bool b) {
    isErrorOccuredWhileLoadingMonth.value = b;
  }

  RxString status = RxString("");

  void updateStatus(String sts) {
    status.value = sts;
  }

  RxBool isLoadingMonth = RxBool(false);

  void updateIsLoadingMonth(bool b) {
    isLoadingMonth.value = b;
  }

  RxBool isLoadingYear = RxBool(false);

  void updateIsLoadingYear(bool b) {
    isLoadingYear.value = b;
  }

  RxList<CoeMonthDataModelValues> months = RxList();
  void updateMonths(List<CoeMonthDataModelValues> month) {
    if (months.isNotEmpty) {
      months.clear();
    }
    months.addAll(month);
  }

  RxList<CoeAcademicDataModelValues> academic = RxList();

  void updateAcademics(List<CoeAcademicDataModelValues> aca) {
    if (academic.isNotEmpty) {
      academic.clear();
    }
    academic.addAll(aca);
  }

  RxBool isErrorOccuredWhileLoadingCoe = RxBool(false);

  void updateIsErrorOccuredWhileLoadingCoe(bool b) {
    isErrorOccuredWhileLoadingCoe.value = b;
  }

  RxList<CoeDataModelValues> coeEvent = RxList();

  void updateCoeEvent(List<CoeDataModelValues> coe) {
    if (coeEvent.isNotEmpty) {
      coeEvent.clear();
    }
    coeEvent.addAll(coe);
  }

  RxBool isLoadingCoe = RxBool(false);
  void updateIsLoadingCoe(bool b) {
    isLoadingCoe.value = b;
  }

  Rx<CoeAcademicDataModelValues> selectedYear =
      Rx<CoeAcademicDataModelValues>(CoeAcademicDataModelValues());
  void updateSelectedAcademicYear(
      CoeAcademicDataModelValues coeAcademicDataModelValues) {
    selectedYear.value = coeAcademicDataModelValues;
  }

  Rx<CoeMonthDataModelValues> selectedMonth =
      Rx<CoeMonthDataModelValues>(CoeMonthDataModelValues());

  void updateSelectedMonth(CoeMonthDataModelValues coeMonthDataModelValues) {
    selectedMonth.value = coeMonthDataModelValues;
  }
}
