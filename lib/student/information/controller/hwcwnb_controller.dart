import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/notice/model/notice_data_model.dart';
import 'package:m_skool_flutter/student/classwork/model/class_work_model.dart';
import 'package:m_skool_flutter/student/homework/model/date_wise.dart';
import 'package:m_skool_flutter/student/homework/model/homework_data_model_values.dart';

class HwCwNbController extends GetxController {
  final RxInt filter = RxInt(0);
  final RxList<DateTime> dtList = RxList();
  final RxString startBy = RxString("Start Date");
  final RxString endBy = RxString("End Date");
  final RxBool startDateProvided = RxBool(false);

  RxBool isErrorHappendWhileLoadingNotice = RxBool(false);

  void updateIsErrorHappendWhileLoadingNotice(bool value) {
    isErrorHappendWhileLoadingNotice.value = value;
  }

  void updateStartBy(String start) {
    startBy.value = start;
  }

  void updateEndby(String end) {
    endBy.value = end;
  }

  void updateShowFilter(int show) {
    filter.value = show;
  }

  void updatedtList(List<DateTime> values) {
    if (dtList.isNotEmpty) {
      dtList.clear();
    }

    dtList.addAll(values);
  }

  void updateStartDateProvided(bool provide) {
    startDateProvided.value = provide;
  }

  RxBool isClassWorkDataLoading = RxBool(true);

  void updateIsClassWorkDataLoading(bool isLoading) {
    isClassWorkDataLoading.value = isLoading;
  }

  RxList<ClassWorkModelValues> classWorkList = RxList<ClassWorkModelValues>();

  void updateClassWorkList(List<ClassWorkModelValues> values) {
    if (classWorkList.isNotEmpty) {
      classWorkList.clear();
    }
    classWorkList.addAll(values);
  }

  RxBool isNoticeDataLoading = RxBool(true);

  void updateIsNoticeDataLoading(bool isLoading) {
    isNoticeDataLoading.value = isLoading;
  }

  RxList<NoticeDataModelValues> noticeList = RxList<NoticeDataModelValues>();

  void updateNoticeDataModelValues(List<NoticeDataModelValues> values) {
    if (noticeList.isNotEmpty) {
      noticeList.clear();
    }
    noticeList.addAll(values);
  }

  final RxList<DateWiseModel> dateWiseModelList = RxList<DateWiseModel>();

  void updateDateWiseModel(List<DateWiseModel> monthList) {
    if (dateWiseModelList.isNotEmpty) {
      dateWiseModelList.clear();
    }
    dateWiseModelList.addAll(monthList);
  }

  RxInt selectedIndex = RxInt(0);

  RxBool isHomeWorkLoading = RxBool(true);
  RxBool isErrorHappendInHomeWorkLoading = RxBool(false);

  RxList<HomeWorkDataModelValues> homeWorkList =
      RxList<HomeWorkDataModelValues>();
  void updateHomeWorkDataModel(List<HomeWorkDataModelValues> values) {
    if (homeWorkList.isNotEmpty) {
      homeWorkList.clear();
    }
    homeWorkList.addAll(values);
  }

  void updateIsHomeWorkLoading(bool b) {
    isHomeWorkLoading.value = b;
  }

  void updateIsErrorHappendInHomeWorkLoading(bool v) {
    isErrorHappendInHomeWorkLoading.value = v;
  }

  RxList<XFile> assignmentPic = RxList<XFile>();

  void updateAssignmentPic(List<XFile> xfile) {
    assignmentPic.addAll(xfile);
  }

  RxBool errorHappendWhileLoadingClsWrk = RxBool(false);

  void updateErrorHappendWhileLoadingClsWrk(bool v) {
    errorHappendWhileLoadingClsWrk.value = v;
  }
}
