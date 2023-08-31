import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_academic_year.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_class_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_section_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_student_model.dart';

class StudentDetailsController extends GetxController {
  RxBool isAcademicYearLoading = RxBool(false);
  RxBool isErrorOccuredWhileLoadingAcademicYear = RxBool(false);
  RxString status = RxString("");
  RxList<ManagerAcademiCYearModelValues> academicYear = RxList();
  Rx<ManagerAcademiCYearModelValues> selectedAcademicYear =
      Rx(ManagerAcademiCYearModelValues());

  void updateIsAcademicYearLoading(bool v) {
    isAcademicYearLoading.value = v;
  }

  void updateIsErrorOccuredWhileLoadingAcademicYear(bool b) {
    isErrorOccuredWhileLoadingAcademicYear.value = b;
  }

  void updateStatus(String sta) {
    status.value = sta;
  }

  void updateAcademicYear(List<ManagerAcademiCYearModelValues> aca) {
    if (academicYear.isNotEmpty) {
      academicYear.clear();
    }
    academicYear.addAll(aca);
  }

  void updateSelectedAcademicYear(ManagerAcademiCYearModelValues sel) {
    selectedAcademicYear.value = sel;
  }

  RxBool isErrorOccuredWhileLoadingClass = RxBool(false);
  RxBool isLoadingClasses = RxBool(false);

  RxList<ManagerClassModelValues> className = RxList();
  Rx<ManagerClassModelValues> selectedClass = Rx(ManagerClassModelValues());

  void updateIsErrorOccuredWhileLoadingClass(bool b) {
    isErrorOccuredWhileLoadingClass.value = b;
  }

  void updateIsLoadingClass(bool b) {
    isLoadingClasses.value = b;
  }

  void updateClassName(List<ManagerClassModelValues> classes) {
    if (className.isNotEmpty) {
      className.clear();
    }
    className.addAll(classes);
  }

  void updateSelectedClass(ManagerClassModelValues sel) {
    selectedClass.value = sel;
  }

  RxBool isSectionLoading = RxBool(false);
  RxBool isErrorOccuredWhileLoadingSection = RxBool(false);
  RxList<ManagerSectionModelValues> sections = RxList();
  Rx<ManagerSectionModelValues> selectedSections =
      Rx(ManagerSectionModelValues());

  void updateIsSectionLoading(bool u) {
    isSectionLoading.value = u;
  }

  void updateIsErrorOccuredWhileLoadingSection(bool b) {
    isErrorOccuredWhileLoadingSection.value = b;
  }

  void updateSections(List<ManagerSectionModelValues> sec) {
    if (sections.isNotEmpty) {
      sections.clear();
    }

    sections.addAll(sec);
  }

  void updateSelectedSection(ManagerSectionModelValues se) {
    selectedSections.value = se;
  }

  RxBool isStudentLoading = RxBool(false);
  RxBool isErrorOccuredWhileLoadingStudent = RxBool(false);
  RxList<ManagerStudentModelValues> students = RxList();
  Rx<ManagerStudentModelValues> selectedStudent =
      Rx(ManagerStudentModelValues());

  void updateIsStudentLoading(bool b) {
    isStudentLoading.value = b;
  }

  void updateIsErrorOccuredWhileLoadingStudent(bool b) {
    isErrorOccuredWhileLoadingStudent.value = b;
  }

  void updateStudents(List<ManagerStudentModelValues> stu) {
    if (students.isNotEmpty) {
      students.clear();
    }

    students.addAll(stu);
  }

  void updateSelectedStudent(ManagerStudentModelValues st) {
    selectedStudent.value = st;
  }
}
