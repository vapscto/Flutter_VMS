import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/feehead/model/fee_details_selected_year_model.dart';
import 'package:m_skool_flutter/manager/feehead/model/fee_fill_details_model.dart';
import 'package:m_skool_flutter/manager/feehead/model/fill_head_data_model.dart';

class FeeheadDetailsController extends GetxController {
  final RxBool isloadingSelectedYear = RxBool(false);
  final RxBool isErrorOccurredWhileLoadingSelectedYear = RxBool(false);

  void updateIsLoadingSelectedYear(bool b) {
    isloadingSelectedYear.value = b;
  }

  void updateIsErrorOccuredWhileLoadingSelectedYear(bool b) {
    isErrorOccurredWhileLoadingSelectedYear.value = b;
  }

  final RxList<FeeDetailsSelectedYearValues> selectedYear = RxList();

  void updateSelectedYear(List<FeeDetailsSelectedYearValues> selected) {
    if (selectedYear.isNotEmpty) {
      selectedYear.clear();
    }
    selectedYear.addAll(selected);
  }

  final RxBool isloadingFillFeeDetails = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingFillFeeDetails = RxBool(false);

  void updateIsLoadingFillFeeDetails(bool b) {
    isloadingFillFeeDetails.value = b;
  }

  void updateIsErrorOccuredWhileLoadingFillFeeDetails(bool b) {
    isErrorOccuredWhileLoadingFillFeeDetails.value = b;
  }

  FeeDetailsSelectedYearValues? selectedacademicyear;

  final RxList<FillFellDetailsModelValues> feefilldetails = RxList();

  void updateFeeFillDetails(List<FillFellDetailsModelValues> filldetails) {
    if (feefilldetails.isNotEmpty) {
      feefilldetails.clear();
    }
    feefilldetails.addAll(filldetails);
  }

  final RxBool isloadingFillHeadDetails = RxBool(false);
  final RxBool isErrorOccuredWhileLoadingFillHeadDetails = RxBool(false);

  void updateIsLoadingFillHeadDetails(bool b) {
    isloadingFillHeadDetails.value = b;
  }

  void updateIsErrorOccuredWhileLoadingFillHeadDetails(bool b) {
    isErrorOccuredWhileLoadingFillHeadDetails.value = b;
  }

  final RxList<FillHeadDataModelValues> feeheaddetails = RxList();

  void updateFeeheadDetails(List<FillHeadDataModelValues> feedetails) {
    if (feeheaddetails.isNotEmpty) {
      feeheaddetails.clear();
    }
    feeheaddetails.addAll(feedetails);
  }
}
