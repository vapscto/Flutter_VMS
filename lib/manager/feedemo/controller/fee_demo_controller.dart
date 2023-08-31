import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/feedemo/model/category_class_model.dart';
import 'package:m_skool_flutter/manager/feedemo/model/category_sec_model.dart';
import 'package:m_skool_flutter/manager/feedemo/model/fee_demo_year_model.dart';

class FeeDemoController extends GetxController {
  final RxBool isloadingAcademicYear = RxBool(false);

  final RxBool isErrorOccuredWhileLoadingAcademicYear = RxBool(false);

  static var isTable;

  static var value;

  void updateIsLoadingAcademicYear(bool b) {
    isloadingAcademicYear.value = b;
  }

  void updateIsErrorOcuuredWhileLoadingAcademicYear(bool b) {
    isErrorOccuredWhileLoadingAcademicYear.value = b;
  }

  final RxList<FeeDemoAcademicYearValues> academicYear = RxList();

  void updateAcademicYear(List<FeeDemoAcademicYearValues> academic) {
    if (academicYear.isNotEmpty) {
      academicYear.clear();
    }
    academicYear.addAll(academic);
  }

  FeeDemoAcademicYearValues? selectedAcademicYear;

  ClassCategoryListValues? selectedClass;

  ClasssectionValues? selectedsection;
   
  


  final RxBool isloadingclass = RxBool(false);

  final RxBool isErrorOccuredWhileLoadingclass = RxBool(false);

  void updateIsLoadingclass(bool b) {
    isloadingclass.value = b;
  }

  void updateIsErrorOcuuredWhileLoadingclass(bool b) {
    isErrorOccuredWhileLoadingclass.value = b;
  }

  final RxList<ClassCategoryListValues> classes = RxList();

  void updateClasses(List<ClassCategoryListValues> academic) {
    if (classes.isNotEmpty) {
      classes.clear();
    }
    classes.addAll(academic);
  }

    final RxList<ClasssectionValues> section = RxList();

  void updatesection(List<ClasssectionValues> academic) {
    if (section.isNotEmpty) {
      section.clear();
    }
    section.addAll(academic);
  }


  final RxBool isloadingfeereport = RxBool(false);

  final RxBool isErrorOccuredWhileLoadingfeereport = RxBool(false);

  void updateIsLoadingfeereport(bool b) {
    isloadingclass.value = b;
  }

  void updateIsErrorOcuuredWhileLoadingfeereport(bool b) {
    isErrorOccuredWhileLoadingfeereport.value = b;
  }

  // final RxList<SearchDatalistModelValues> report = RxList();

  // void updateReport(List<SearchDatalistModelValues> academic) {
  //   if (report.isNotEmpty) {
  //     report.clear();
  //   }
  //   report.addAll(academic);
  // }



    void updateIsLoadingSection(bool b) {
    isloadingSection.value = b;
  }

  void updateIsErrorOcuuredWhileLoadingSection(bool b) {
    isErrorOccuredWhileLoadingSection.value = b;

    
  }

    final RxBool isloadingSection = RxBool(false);

  final RxBool isErrorOccuredWhileLoadingSection = RxBool(false);
}
