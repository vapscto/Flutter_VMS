import 'package:get/get.dart';
import 'package:m_skool_flutter/student/coe/models/academic_year_model.dart';
import 'package:m_skool_flutter/student/coe/models/coe_data_model.dart';

class CoeDataHandler extends GetxController {
  RxBool showAllLoadingProgress = RxBool(true);
  void updateShowAllLoadingProgress(bool isLoading) {
    showAllLoadingProgress.value = isLoading;
  }

  RxBool showEventLoading = RxBool(true);
  void updateShowEventLoading(bool load) {
    showEventLoading.value = load;
  }

  RxBool isChangeInAcademicYear = RxBool(false);
  RxBool isChangeInMonth = RxBool(false);

  RxList<AttyearlistValues> academicYearList = RxList<AttyearlistValues>();
  RxList<CoereportlistValues> coeReport = RxList<CoereportlistValues>();
  void updateCoeReport(List<CoereportlistValues> newValue) {
    if (coeReport.isNotEmpty) {
      coeReport.clear();
    }
    coeReport.addAll(newValue);
  }

  void updateAcademicYearList(List<AttyearlistValues> attList) {
    if (academicYearList.isNotEmpty) {
      academicYearList.clear();
    }
    academicYearList.addAll(attList);
  }

  RxInt asmayId = RxInt(0);
  void updateAsmayId(int newId) {
    asmayId.value = newId;
  }

  Rx<AttyearlistValues> selectedInDorpDown =
      Rx<AttyearlistValues>(AttyearlistValues());
  void updateSelectedInDropDown(AttyearlistValues newSelectedValue) {
    selectedInDorpDown.value = newSelectedValue;
  }
}
