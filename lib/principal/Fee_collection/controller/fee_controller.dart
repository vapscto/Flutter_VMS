import 'package:get/get.dart';
import 'package:m_skool_flutter/principal/Fee_collection/model/detail_fee_model.dart';
 import 'package:m_skool_flutter/principal/Fee_collection/model/fees_detaills_model.dart';

class FeeController extends GetxController {
  RxBool isFromDateProvided = RxBool(false);
  RxBool isLoadingFee = RxBool(false);
  Rx<DateTime> fromSelectedDate = Rx(DateTime.now());
  Rx<DateTime> toSelectedDate = Rx(DateTime.now());

  void updateIsFromDateProvided(bool isProvided) {
    isFromDateProvided.value = isProvided;
  }

  void updateIsLoadingFee(bool isLoading) {
    isLoadingFee.value = isLoading;
  }

  void updateFromSelectedDate(DateTime now) {
    fromSelectedDate.value = now;
  }

  void updateToSelectedDate(DateTime now) {
    toSelectedDate.value = now;
  }

  RxList<FeesDetailsValues> FeeGroupList = RxList();
  RxList<DetailsFeeValues>  SectionList = RxList();

  void updateFeeGroupList(List<FeesDetailsValues> mList) {
    if (FeeGroupList.isNotEmpty) {
      FeeGroupList.clear();
    }
    FeeGroupList.addAll(mList);
  }

  RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool error) {
    isErrorOccured.value = error;
  }
}
