import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/classes_model_data_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/department_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/designation_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/notice_employee_data.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/notice_student_data_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/section_detail_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/view_notice_data_model.dart';

class NoticeBoardController extends GetxController {
  RxList<ViewNoticeDetailsModelValuesValues> viewNoticeList = RxList();

  RxBool isErrorOccuredWhileLoadingWork = RxBool(false);

  RxBool isErrorOccuredWhileLoadingSection = RxBool(false);

  RxBool isErrorOccuredWhileLoadingDepartment = RxBool(false);

  RxBool isDesignationLoading = RxBool(false);

  void updateIsDesignationLoading(bool b) {
    isDesignationLoading.value = b;
  }

  void updateIsErrorOccuredWhileLoadingDepartment(bool b) {
    isErrorOccuredWhileLoadingDepartment.value = b;
  }

  void updateIsErrorOccuredWhileLoadingSection(bool b) {
    isErrorOccuredWhileLoadingSection.value = b;
  }

  RxBool isSectionLoading = RxBool(false);

  void updateIsSectionLoading(bool b) {
    isSectionLoading.value = b;
  }

  RxList<SectionDetailsModelValues> sections = RxList();

  void updateSection(List<SectionDetailsModelValues> c) {
    if (sections.isNotEmpty) {
      sections.clear();
    }
    sections.addAll(c);
  }

  void updateIsErrorOccuredWhileLoadingNotice(bool b) {
    isErrorOccuredWhileLoadingWork.value = b;
  }

  RxBool isErrorOccuredWhileLoadingClass = RxBool(false);

  void updateIsErrorOccuredWhileLoadingClass(bool b) {
    isErrorOccuredWhileLoadingClass.value = b;
  }

  RxString viewWorkLoadingStatus =
      RxString("Please wait while we are loading all notices");

  void updateViewWorkLoadingStatus(String status) {
    viewWorkLoadingStatus.value = status;
  }

  RxBool isWorkLoading = RxBool(false);

  void updateIsWorkLoading(bool b) {
    isWorkLoading.value = b;
  }

  RxBool isClassLoading = RxBool(false);

  void updateIsClassLoading(bool b) {
    isClassLoading.value = b;
  }

  void updateViewNoticeList(
      List<ViewNoticeDetailsModelValuesValues> val) async {
    if (viewNoticeList.isNotEmpty) {
      viewNoticeList.clear();
    }
    viewNoticeList.addAll(val);
  }

  RxList<ClassNameDetailsModelValues> classesList = RxList();

  void updateClassesList(List<ClassNameDetailsModelValues> val) async {
    if (classesList.isNotEmpty) {
      classesList.clear();
    }
    classesList.addAll(val);
  }

  RxList<ClassNameDetailsModelValues> selectedClasses = RxList();

  void addToSelectedClasses(ClassNameDetailsModelValues value) {
    selectedClasses.add(value);
  }

  void removeSelectedClass(ClassNameDetailsModelValues re) {
    selectedClasses.remove(re);
  }

  RxBool studentSelection = RxBool(false);

  void updateStudentSeclection(bool b) {
    studentSelection.value = b;
  }

  RxBool isErrorOccuredWhileLoadingStudent = RxBool(false);

  void updateIsErrorOccuredWhileLoadingStudent(bool b) {
    isErrorOccuredWhileLoadingStudent.value = b;
  }

  RxBool isStudentLoading = RxBool(false);

  void updateIsStudentLoading(bool b) {
    isStudentLoading.value = b;
  }

  RxList<NoticeStudentDetailsModelValues> students = RxList();

  void updateStudents(List<NoticeStudentDetailsModelValues> stu) {
    if (students.isNotEmpty) {
      students.clear();
    }
    students.addAll(stu);
  }

  RxList<NoticeStudentDetailsModelValues> selectedStuden = RxList();

  void addToSelectedStudent(NoticeStudentDetailsModelValues stu) {
    selectedStuden.add(stu);
  }

  void removeToSelectedStudent(NoticeStudentDetailsModelValues re) {
    selectedStuden.remove(re);
  }

  void addAllToStudent(List<NoticeStudentDetailsModelValues> st) {
    if (selectedStuden.isNotEmpty) {
      selectedStuden.clear();
    }
    selectedStuden.addAll(st);
  }

  RxList<SectionDetailsModelValues> selectedSections = RxList();

  void addToSection(SectionDetailsModelValues sec) {
    selectedSections.add(sec);
  }

  void removeFromSection(SectionDetailsModelValues v) {
    selectedSections.remove(v);
  }

  RxBool isDepartmentLoading = RxBool(false);

  void updateIsDepartmentLoading(bool b) {
    isDepartmentLoading.value = b;
  }

  RxList<DepartmentListModelValues> departments = RxList();

  void updateDepartment(List<DepartmentListModelValues> mList) {
    if (departments.isNotEmpty) {
      departments.clear();
    }
    departments.addAll(mList);
  }

  RxBool isErrorOccuredWhileLoadingDesignation = RxBool(false);

  void updateIsErrorOccuredWhileLoadingDesignation(bool b) {
    isErrorOccuredWhileLoadingDesignation.value = b;
  }

  RxList<DesignationDataModelValues> designation = RxList();
  void updateDesignation(List<DesignationDataModelValues> dsgn) {
    if (designation.isNotEmpty) {
      designation.clear();
    }
    designation.addAll(dsgn);
  }

  RxList<DepartmentListModelValues> selectedDepartment = RxList();

  void addToSelectedDepartment(DepartmentListModelValues dept) {
    selectedDepartment.add(dept);
  }

  void selectAllDept(List<DepartmentListModelValues> dept) {
    if (selectedDepartment.isNotEmpty) {
      selectedDepartment.clear();
    }
    selectedDepartment.addAll(dept);
  }

  void removeFromSelectedDepartment(DepartmentListModelValues re) {
    selectedDepartment.remove(re);
  }

  RxList<DesignationDataModelValues> selectedDesignation = RxList();

  void addToSelectedDesignation(DesignationDataModelValues dept) {
    if (!selectedDesignation.contains(dept)) {
      selectedDesignation.add(dept);
    }
  }

  void selectAllDesignation(List<DesignationDataModelValues> dept) {
    if (selectedDesignation.isNotEmpty) {
      selectedDesignation.clear();
    }
    selectedDesignation.addAll(dept);
  }

  void removeFromSelectedDesignation(DesignationDataModelValues re) {
    selectedDesignation.remove(re);
  }

  RxBool isErrorOccuredWhileLoadingEmployee = RxBool(false);
  void updateIsErrorOccuredWhileLoadingEmployee(bool b) {
    isErrorOccuredWhileLoadingEmployee.value = b;
  }

  RxList<NoticeEmployeeDataModelValues> employee = RxList();

  void updateNoticeEmployeeDataModel(List<NoticeEmployeeDataModelValues> emp) {
    if (employee.isNotEmpty) {
      employee.clear();
    }
    employee.addAll(emp);
  }

  RxList<NoticeEmployeeDataModelValues> selectedEmployee = RxList();

  void addToSelectedEmployee(NoticeEmployeeDataModelValues emp) {
    selectedEmployee.add(emp);
  }

  void removeFromSelectedEmployee(NoticeEmployeeDataModelValues emp) {
    selectedEmployee.remove(emp);
  }

  RxBool isEmpLoading = RxBool(false);

  void updateIsEmpLoading(bool v) {
    isEmpLoading.value = v;
  }

  void selectAllEmployee(List<NoticeEmployeeDataModelValues> emp) {
    if (selectedEmployee.isNotEmpty) {
      selectedEmployee.clear();
    }
    selectedEmployee.addAll(emp);
  }

  RxString noticeType = RxString("Others");
  Rx<TextEditingController> noticeTitle =
      Rx<TextEditingController>(TextEditingController());

  Rx<TextEditingController> desc =
      Rx<TextEditingController>(TextEditingController());

  Rx<DateTime> startDt = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDt = Rx<DateTime>(DateTime.now());
  Rx<DateTime> displayDt = Rx<DateTime>(DateTime.now());
}
