import 'package:get/get.dart';

class VhwVCwController extends GetxController {
  final RxBool isErrorOccuredWhileLoadingAcademics = RxBool(false);

  void updateIsErrorOccuredWhileLoadingAcademics(bool v) {
    isErrorOccuredWhileLoadingAcademics.value = v;
  }

  final RxBool isAcademicsLoading = RxBool(true);

  void updateIsAcademicsLoading(bool v) {
    isAcademicsLoading.value = v;
  }

  final RxBool isErrorOccuredLoadingClass = RxBool(false);

  final RxBool isClassLoading = RxBool(false);

  void updateIsErrorOccuredLoadingClass(bool v) {
    isErrorOccuredLoadingClass.value = v;
  }

  void updateIsClassLoading(bool v) {
    isClassLoading.value = v;
  }

  final RxBool isErrorOccuredLoadingSection = RxBool(false);

  void updateIsErrorOccuredLoadingSection(bool v) {
    isErrorOccuredLoadingSection.value = v;
  }

  final RxBool isSectionLoading = RxBool(false);

  void updateIsSectionLoading(bool b) {
    isSectionLoading.value = b;
  }

  final RxBool isSubjectLoading = RxBool(false);

  void updateIsSubjectLoading(bool b) {
    isSubjectLoading.value = b;
  }

  final RxBool isErrorOccuredWhileLoadingSubject = RxBool(false);

  void updateIsErrorOccuredWhileLoadingSubject(bool b) {
    isErrorOccuredWhileLoadingSubject.value = b;
  }
}
