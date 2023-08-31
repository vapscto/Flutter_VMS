import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_filter_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

class ViewNoticeDataController {
  RxBool isCircularPageLoading = RxBool(false);
  void updateIsCircularPageLoading(bool wholePage) {
    isCircularPageLoading.value = wholePage;
  }

  RxBool isSyllabusPageLoading = RxBool(false);

  void updateIsSyllabusPageLoading(bool ok) {
    isSyllabusPageLoading.value = ok;
  }

  RxBool isTimetableLoading = RxBool(false);

  void updateIsTtLoading(bool ok) {
    isTimetableLoading.value = ok;
  }

  RxBool isErrorOccuredWhileLoadingCircular = RxBool(false);
  void updateIsErrorOccuredWhileLoadingCircular(bool ok) {
    isErrorOccuredWhileLoadingCircular.value = ok;
  }

  RxBool isErrorOccuredWhileLoadingSyllabus = RxBool(false);

  void updateErrorOccuredWhileLoadingSyllabus(bool ok) {
    isErrorOccuredWhileLoadingSyllabus.value = ok;
  }

  RxBool isErrorOccuredWhileLoadingTT = RxBool(false);

  void updateErrorOccuredWhileLoadingTT(bool ok) {
    isErrorOccuredWhileLoadingTT.value = ok;
  }

  RxList<ViewNoticeModelValues> circularList = RxList();

  void updateCircularList(List<ViewNoticeModelValues> val) {
    if (circularList.isNotEmpty) {
      circularList.clear();
    }
    circularList.addAll(val);
  }

  RxList<ViewNoticeSessionModelValues> circularSession = RxList();

  void updateCircularSession(List<ViewNoticeSessionModelValues> session) {
    if (circularSession.isNotEmpty) {
      circularSession.clear();
    }
    circularSession.addAll(session);
  }

  RxBool isErrorOccuredWhileLoadingCircularContent = RxBool(false);
  void updateIsErrorOccuredWhileLoadingCircularContent(bool ok) {
    isErrorOccuredWhileLoadingCircularContent.value = ok;
  }

  RxBool isLoadingCircularContent = RxBool(false);

  void updateIsLoadingCircularContent(bool ok) {
    isLoadingCircularContent.value = ok;
  }

  Rx<ViewNoticeSessionModelValues> selectedSession =
      Rx(ViewNoticeSessionModelValues());

  void updateSelectedSession(ViewNoticeSessionModelValues sessionModel) {
    selectedSession.value = sessionModel;
  }

  RxBool isErrorOccuredWhileLoadingFilteration = RxBool(false);
  RxBool isFilterationLoading = RxBool(false);

  RxList<ViewNoticeFilterModelValues> filterList = RxList();

  void addNoticeToFilter(List<ViewNoticeFilterModelValues> val) {
    if (filterList.isNotEmpty) {
      filterList.clear();
    }
    filterList.addAll(val);
  }
}
