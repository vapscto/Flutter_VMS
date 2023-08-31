import 'package:get/get.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/top_result_model.dart';

class ToperWiseController extends GetxController {
  RxList<TopResultListModelValues> marksDataTableList = RxList();

  final RxBool isErrorOccuredWhileLoadingAcademic = RxBool(false);
  final RxBool isLoadingAcademicYear = RxBool(false);
  final RxBool isLoadingCategory = RxBool(false);

  void updateIsErrorOccuredWhileLoadingAcademic(bool b) {
    isErrorOccuredWhileLoadingAcademic.value = b;
  }

  void updateIsLoadingAcademicYear(bool b) {
    isLoadingAcademicYear.value = b;
  }

  void updateIsLoadingCategory(bool b) {
    isLoadingCategory.value = b;
  }
}
