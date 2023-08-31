import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/AcademicYearList.dart';
 

class AcadmeicController extends GetxController {
  final RxBool isErrorOccuredWhileLoadingAcademic = RxBool(false);
  final RxBool isLoadingAcademicYear = RxBool(false);

  void updateIsErrorOccuredWhileLoadingAcademic(bool b) {
    isErrorOccuredWhileLoadingAcademic.value = b;
  }

  final RxBool isLoadingCategory = RxBool(false);

  void updateIsLoadingAcademicYear(bool b) {
    isLoadingAcademicYear.value = b;
  }

  final RxList<AcademicYearListValues> academic = RxList();

  void updateAcademic(List<AcademicYearListValues> newAca) {
    if (academic.isNotEmpty) {
      academic.clear();
    }
    academic.addAll(newAca);
  }

  AcademicYearListValues? selectedAcademic;
}
