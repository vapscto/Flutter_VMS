import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/coe/model/staff_coe_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

class CoeDataHandler extends GetxController {
  final RxBool isWholePageLoading = RxBool(true);
  final RxBool isAcademicYearLoaded = RxBool(false);

  void updateIsWholePageLoading(bool ok) {
    isWholePageLoading.value = ok;
  }

  void updateIsAcademicYearLoaded(bool ok) {
    isAcademicYearLoaded.value = ok;
  }

  final RxBool isCoeLoading = RxBool(false);

  void updateIsCoeLoading(bool ok) {
    isCoeLoading.value = ok;
  }

  final RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool ok) {
    isErrorOccured.value = ok;
  }

  final RxMap<String, dynamic> error = RxMap();

  void updateErrorInfo(Map<String, dynamic> err) {
    error.value = err;
  }

  RxList<ViewNoticeSessionModelValues> sessions = RxList();

  void updateSessions(List<ViewNoticeSessionModelValues> newSessions) {
    if (sessions.isNotEmpty) {
      sessions.clear();
    }

    sessions.addAll(newSessions);
  }

  RxList<StaffCoeModelValues> coeLists = RxList();

  void updateCoeLists(List<StaffCoeModelValues> list) {
    if (coeLists.isNotEmpty) {
      coeLists.clear();
    }
    coeLists.addAll(list);
  }

  String loadingAcademicYearString =
      "We are in process to load academic year, your view will be visible soon";

  String loadingCoeData =
      "We are loading coe for selected academic year and month, your view will be visible soon";

  RxString coeLoadingStatus = RxString("");
  void updateCoeLoadingStatus(String status) {
    coeLoadingStatus.value = status;
  }

  RxBool errorOccuredWhileLoadingCoe = RxBool(false);
  void updateIsErrorOccuredWhileLoadingCoe(bool ok) {
    errorOccuredWhileLoadingCoe.value = ok;
  }

  Rx<ViewNoticeSessionModelValues> selectedAcademicYear =
      Rx(ViewNoticeSessionModelValues());

  void updateSelectedAcademicYear(ViewNoticeSessionModelValues model) {
    selectedAcademicYear.value = model;
  }

  RxInt selectedMonth = RxInt(DateTime.now().month);
  void updateSelectedMonth(int value) {
    selectedMonth.value = value;
  }
}
