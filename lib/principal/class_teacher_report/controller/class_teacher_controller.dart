import 'package:get/get.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/model/class_teacher_model.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/model/teacher_report_yearlist_model.dart';

class ClassTeacherController extends GetxController {
  final RxBool isLoadingYearList = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingYearList = RxBool(false);

  RxString selectedradio = ''.obs;
  RxString grpOrInd = '1'.obs;
  RxInt setacademic = RxInt(0);
   void groupOrIndividual(String value) {
    grpOrInd.value = value;
  }
  void setacademicYear(int val){
    setacademic.value = val;
  }

  void selectedValue(String value) {
    selectedradio.value = value;
  }

  void updateIsLoadingYearList(bool b) {
    isLoadingYearList.value = b;
  }

  void updateIsErrorOccuredWhileLoadingYearList(bool b) {
    isErrorOccuredWhileLoadingYearList.value = b;
  }

  final RxList<YearListModelValues> yearList = RxList();

  void updateYearList(List<YearListModelValues> year) {
    if (yearList.isNotEmpty) {
      yearList.clear();
    }
    yearList.addAll(year);
  }

  YearListModelValues? selectedYearList;

  /////////////
  ///**    **//

  final RxBool isLoadingClassTeacherList = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingClassTeacherList = RxBool(false);

  void updateIsLoadingClassTeacherList(bool b) {
    isLoadingClassTeacherList.value = b;
  }

  void updateIsErrorOccuredWhileLoadingClassTeacherList(bool b) {
    isErrorOccuredWhileLoadingClassTeacherList.value = b;
  }

  final RxList<ClassTeacherListModelValues> classTeacherList = RxList();

  void updateClassTeacherList(RxList<ClassTeacherListModelValues> val) {
    if (classTeacherList.isNotEmpty) {
      classTeacherList.clear();
    }
    classTeacherList.addAll(val);
  }

  ClassTeacherListModelValues? selectedClassTeacherList;
}
