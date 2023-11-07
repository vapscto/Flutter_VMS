import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/rating_report/model/month_rating_report_model.dart';
import 'package:m_skool_flutter/vms/rating_report/model/report_data_model.dart';
import 'package:m_skool_flutter/vms/rating_report/model/year_list_rating_model.dart';

class RatingReportController extends GetxController {
  //*** YEAR LIST ***//

  RxBool isErrorOccuredWhileLoadingOnloadYearList = RxBool(false);
  RxBool isLoadingOnloadYearList = RxBool(false);

  final RxList<YearListRatingReportModelValues> yearList = RxList();

  updateErrorLoadingOnloadYearList(bool val) {
    isErrorOccuredWhileLoadingOnloadYearList.value = val;
  }

  updateisLoadingOnloadYearList(bool val) {
    isLoadingOnloadYearList.value = val;
  }

  //*** MONTH  LIST ***//

  RxBool isErrorOccuredWhileLoadingMonth = RxBool(false);
  RxBool isLoadingMonth = RxBool(false);

  final RxList<MonthRatingReportModelValues> monthList = RxList();

  updateErrorLoadingMonth(bool val) {
    isErrorOccuredWhileLoadingMonth.value = val;
  }

  updateisLoadingMonth(bool val) {
    isLoadingMonth.value = val;
  }

  //*** RATING REPORT DATA ***//

  RxBool isErrorOccuredWhileLoadingRatingReportData = RxBool(false);
  RxBool isLoadingRatingReportData = RxBool(false);

  final RxList<ReportDataModelValues> ratingReportData = RxList();

  updateErrorLoadingRatingReportData(bool val) {
    isErrorOccuredWhileLoadingRatingReportData.value = val;
  }

  updateisLoadingRatingReportData(bool val) {
    isLoadingRatingReportData.value = val;
  }

  ////////////////      rxlist      ////////////////

  RxList<bool> checkListBoxs = <bool>[].obs;

  List<String> yearSelectedSeperated = [];

  bool selectAll = false;

  List<int>? checkList = <int>[].obs;

  bool selectAllMonth = false;

  // Method to reset data and checkboxes
  // void resetDataAndCheckboxes() {
  //   // Clear data and reset checkboxes based on your data structure
  //   for (var data in ratingReportData) {
  //     data.january = null;
  //     data.february = null;
  //     data.march = null;
  //     data.april = null;
  //     data.may = null;
  //     data.june = null;
  //     data.july = null;
  //     data.august = null;
  //     data.september = null;
  //     data.october = null;
  //     data.november = null;
  //     data.december = null;
  //   }

  //   // Reset the checkboxes
  //   checkListBoxs.value = List.generate(monthList.length, (index) => false);
  //   selectAll = false;
  //   checkList!.clear();
  // }
}
