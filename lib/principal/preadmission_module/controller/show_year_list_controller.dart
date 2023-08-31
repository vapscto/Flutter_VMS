import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_class_data.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_redg_count.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_year_data.dart';

class ShowYearListController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccured = RxBool(false);
  RxInt totalRegdCount = 0.obs;
  RxInt notFilledForm = 0.obs;
  RxInt filledForm = 0.obs;
  RxInt paymentDone = 0.obs;
  RxInt paymentNotDone = 0.obs;
  RxInt totalTransfer = 0.obs;
  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  RxList<YearGetDataValues> yearSectionData = RxList();
  void getYearListData(List<YearGetDataValues> yearList) {
    if (yearSectionData.isNotEmpty) {
      yearSectionData.clear();
    }
    yearSectionData.addAll(yearList);
  }

  RxList<ClassGetDataValues> classSectionData = RxList();

  void getClassData(List<ClassGetDataValues> lop) {
    if (classSectionData.isNotEmpty) {
      classSectionData.clear();
    }
    classSectionData.addAll(lop);
  }

  RxList<GetCountDataValues> regdCountData = RxList();

  void getRegdCount(List<GetCountDataValues> dTT) {
    if (regdCountData.isNotEmpty) {
      regdCountData.clear();
    }
    regdCountData.addAll(dTT);
    logger.i(regdCountData.first.reg);
  }
}
