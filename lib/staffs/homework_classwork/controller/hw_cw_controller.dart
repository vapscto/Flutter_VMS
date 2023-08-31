import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/classwork_view_work_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/homework_view_work_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_classes_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_section_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_subject_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_classwork_topic_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_sub_list_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_homework_topic_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

class HwCwController extends GetxController {
  RxBool showFilter = RxBool(false);
  void updateShowFilter(bool b) {
    showFilter.value = b;
  }

  RxInt filterCount = RxInt(0);

  void updateFilterCount(int b) {
    filterCount.value = b;
  }

  RxBool isWholePageLoading = RxBool(true);
  void updateIsWholePageLoading(bool ok) {
    isWholePageLoading.value = ok;
  }

  RxBool isAcademicYearLoading = RxBool(false);
  void updateIsAcademicYearLoading(bool ok) {
    isAcademicYearLoading.value = ok;
  }

  RxBool isErrorOccuredLoadingAcademicYear = RxBool(false);
  void updateIsErrorOccuredLoadingAcademicYear(bool ok) {
    isErrorOccuredLoadingAcademicYear.value = ok;
  }

  RxBool isClassLoading = RxBool(false);
  void updateIsClassLoading(bool ok) {
    isClassLoading.value = ok;
  }

  RxBool isErrorOccuredLoadingClass = RxBool(false);
  void updateIsErrorOccuredLoadingClass(bool ok) {
    isErrorOccuredLoadingClass.value = ok;
  }

  RxBool isSectionLoading = RxBool(false);
  void updateIsSectionLoading(bool ok) {
    isSectionLoading.value = ok;
  }

  RxBool isErrorOccuredLoadingSection = RxBool(false);
  void updateIsErrorOccuredLoadingSection(bool ok) {
    isErrorOccuredLoadingSection.value = ok;
  }

  RxBool isSubjectLoading = RxBool(false);
  void updateIsSubjectLoading(bool o) {
    isSubjectLoading.value = o;
  }

  RxBool isErrorOccuredLoadingSubject = RxBool(false);
  void updateIsErrorOccuredLoadingSubject(bool o) {
    isErrorOccuredLoadingSubject.value = o;
  }

  RxList<ViewNoticeSessionModelValues> session = RxList();
  void updateSession(List<ViewNoticeSessionModelValues> list) {
    if (session.isNotEmpty) {
      session.clear();
    }
    session.addAll(list);
  }

  RxList<HwCwClassesListModelValues> classes = RxList();

  void updateClasses(List<HwCwClassesListModelValues> clas) {
    if (classes.isNotEmpty) {
      classes.clear();
    }
    classes.addAll(clas);
  }

  RxList<HwCwSectionListModelValue> sections = RxList();
  void updateSections(List<HwCwSectionListModelValue> li) {
    if (sections.isNotEmpty) {
      sections.clear();
    }
    sections.addAll(li);
  }

  RxList<HwCwSubjectListModelValues> subjects = RxList();

  void updateSubjects(List<HwCwSubjectListModelValues> sub) {
    if (subjects.isNotEmpty) {
      subjects.clear();
    }
    subjects.addAll(sub);
  }

  RxString loadingStatus = RxString("");
  void updateLoadingStatus(String status) {
    loadingStatus.value = status;
  }

  RxString errorStatus = RxString("");
  void updateErrorStatus(String status) {
    errorStatus.value = status;
  }

  Rx<ViewNoticeSessionModelValues> selectedSession =
      Rx(ViewNoticeSessionModelValues());

  void updateSelectedSession(ViewNoticeSessionModelValues selected) {
    selectedSession.value = selected;
  }

  Rx<HwCwClassesListModelValues> selectedClass =
      Rx(HwCwClassesListModelValues());

  void updateSelectedClass(HwCwClassesListModelValues selClass) {
    selectedClass.value = selClass;
  }

  RxList<HwCwSectionListModelValue> selectedSection = RxList();

  void updateSelectedSection(HwCwSectionListModelValue val) {
    selectedSection.add(val);
  }

  Rx<HwCwSectionListModelValue> verifySelectedSection =
      Rx<HwCwSectionListModelValue>(HwCwSectionListModelValue());

  void updateVerifySelectedSection(HwCwSectionListModelValue val) {
    verifySelectedSection.value = val;
  }

  Rx<HwCwSubjectListModelValues> selectedSubject =
      Rx(HwCwSubjectListModelValues());
  void updateSelectedSubject(HwCwSubjectListModelValues sub) {
    selectedSubject.value = sub;
  }

  Rx<DateTime> hwDate = Rx<DateTime>(DateTime.now());

  void updateHwDate(DateTime now) {
    hwDate.value = now;
  }

  RxList<VerifyCwSubjectListModelValues> cwSubjectList = RxList();

  void updateCwSubjectList(List<VerifyCwSubjectListModelValues> cw) {
    if (cwSubjectList.isNotEmpty) {
      cwSubjectList.clear();
    }
    cwSubjectList.addAll(cw);
  }

  Rx<VerifyCwSubjectListModelValues> selectedCwSub =
      Rx<VerifyCwSubjectListModelValues>(VerifyCwSubjectListModelValues());

  void updateSelectedCwSubject(VerifyCwSubjectListModelValues val) {
    selectedCwSub.value = val;
  }

  RxBool isWorkLoading = RxBool(false);

  void updateIsWorkLoading(bool b) {
    isWorkLoading.value = b;
  }

  RxBool isErrorOccuredWhileLoadingWork = RxBool(false);
  void updateIsErrorOccuredWhileLoadingWork(bool b) {
    isErrorOccuredWhileLoadingWork.value = b;
  }

  RxList<HomeWorkViewWorkValues> homeWorks = RxList();

  void updateHomeWorks(List<HomeWorkViewWorkValues> hw) {
    if (homeWorks.isNotEmpty) {
      homeWorks.clear();
    }
    homeWorks.addAll(hw);
  }

  RxList<ClassWorkViewWorkValues> classWorks = RxList();

  void updateClassWorks(List<ClassWorkViewWorkValues> cw) {
    if (classWorks.isNotEmpty) {
      classWorks.clear();
    }
    classWorks.addAll(cw);
  }

  RxString viewWorkLoadingStatus =
      RxString("Please wait while we are loading your assigned work");

  void updateViewWorkLoadingStatus(String status) {
    viewWorkLoadingStatus.value = status;
  }

  final RxList<TextEditingController> textEditors = RxList([]);

  void addToEditors(TextEditingController controller) {
    textEditors.add(controller);
  }

  void removeEditor(int index) {
    textEditors.removeAt(index);
  }

  final List<XFile?> attachment = RxList();
  final List<PlatformFile> attFiles = RxList();

  void addMultipleAttachment(List<XFile?> att) {
    attachment.addAll(att);
  }

  void addToAttachment(XFile f) {
    attachment.add(f);
  }

  void removeAttachment(int index) {
    attachment.removeAt(index);
  }

  void addMultipleAttFiles(List<PlatformFile> att) {
    attFiles.addAll(att);
  }

  void addToFile(PlatformFile f) {
    attFiles.add(f);
  }

  void removeAtt(int index) {
    attFiles.removeAt(index);
  }

  RxBool isSaving = RxBool(false);
  RxBool isErrorOccuredSavingHw = RxBool(false);
  RxBool isUploadingFiles = RxBool(false);

  RxString saveStatus = RxString("Connecting to server");

  void updateIsUploadingFiles(bool b) {
    isUploadingFiles.value = b;
  }

  void updateSaveStatus(String status) {
    saveStatus.value = status;
  }

  void updateIsSaving(bool b) {
    isSaving.value = b;
  }

  void updateIsErrorOccuredSavingHw(bool f) {
    isErrorOccuredSavingHw.value = f;
  }

  RxBool isTopicLoading = RxBool(false);

  void updateIsTopicLoading(bool b) {
    isTopicLoading.value = b;
  }

  RxBool isErrorOccuredWhileLoadingTopic = RxBool(false);

  void updateIsErrorOccuredWhileLoadingTopic(bool b) {
    isErrorOccuredWhileLoadingTopic.value = b;
  }

  RxList<HomeworkTopicModelValues> homeworkTopic = RxList();
  RxList<ClassworkTopicModelValues> classWorkTopic = RxList();
  Rx<HomeworkTopicModelValues> selectedHwTopic = Rx<HomeworkTopicModelValues>(
    HomeworkTopicModelValues(
      iHWId: 0,
    ),
  );
  Rx<ClassworkTopicModelValues> selectedCwTopic = Rx<ClassworkTopicModelValues>(
    ClassworkTopicModelValues(
      iCWId: 0,
    ),
  );
  void updateHomeworkTopic(List<HomeworkTopicModelValues> hw) {
    if (homeworkTopic.isNotEmpty) {
      homeworkTopic.clear();
    }
    homeworkTopic.addAll(hw);
  }

  void updateClassworkTopic(List<ClassworkTopicModelValues> cw) {
    if (classWorkTopic.isNotEmpty) {
      classWorkTopic.clear();
    }
    classWorkTopic.addAll(cw);
  }

  void updateSelectedHwTopic(HomeworkTopicModelValues hwTopic) {
    selectedHwTopic.value = hwTopic;
  }

  void updateSelectedCwTopic(ClassworkTopicModelValues cwTopic) {
    selectedCwTopic.value = cwTopic;
  }
}
