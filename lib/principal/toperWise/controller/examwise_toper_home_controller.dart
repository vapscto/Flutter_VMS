import 'package:get/get.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/academic_year_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/exam_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/section_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/subject_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/top_class_model.dart';

class ExamWiseToperController extends GetxController {
  final RxBool isErrorOccuredWhileLoadingAcademic = RxBool(false);
  final RxBool isLoadingAcademicYear = RxBool(false);
  final RxBool isLoadingCategory = RxBool(false);
  final RxBool selectSubjectWise = RxBool(false);

/**
 *   Academic year  list
 */

  RxList<AcademicListModelValues> academicYearTop = RxList();
  AcademicListModelValues? selectedAcademicYear;

  void updateAcademic(List<AcademicListModelValues> newAca) {
    if (academicYearTop.isNotEmpty) {
      academicYearTop.clear();
    }
    academicYearTop.addAll(newAca);
  }

/**
 *   Academic  class  list
 */
  RxList<TopClassListModelValues> classTop = RxList();
  TopClassListModelValues? selectedClass;
  void updateClass(List<TopClassListModelValues> newAca) {
    if (classTop.isNotEmpty) {
      classTop.clear();
    }
    classTop.addAll(newAca);
  }

/**
 *   Academic  section  list
 */
  RxList<TopSectonListModelValues> sectionTop = RxList();
  TopSectonListModelValues? selectedSection;
  void updateSection(List<TopSectonListModelValues> newAca) {
    if (sectionTop.isNotEmpty) {
      sectionTop.clear();
    }
    sectionTop.addAll(newAca);
  }

/**
 *   Academic  exam  list
 */
  RxList<TopExamListModelValues> examTop = RxList();
  TopExamListModelValues? selectedExam;
  void updateExam(List<TopExamListModelValues> newAca) {
    if (examTop.isNotEmpty) {
      examTop.clear();
    }
    examTop.addAll(newAca);
  }

/**
 *   Academic  subject  list
 */

  RxList<TopSubjectListModelValues> subjectTop = RxList();
  TopSubjectListModelValues? selectedExamSubject;
  void updateSubject(List<TopSubjectListModelValues> newAca) {
    if (subjectTop.isNotEmpty) {
      subjectTop.clear();
    }
    subjectTop.addAll(newAca);
  }

  void updateIsErrorOccuredWhileLoadingAcademic(bool b) {
    isErrorOccuredWhileLoadingAcademic.value = b;
  }

  void updateIsLoadingAcademicYear(bool b) {
    isLoadingAcademicYear.value = b;
  }

  void updateIsLoadingCategory(bool b) {
    isLoadingAcademicYear.value = b;
  }
}
