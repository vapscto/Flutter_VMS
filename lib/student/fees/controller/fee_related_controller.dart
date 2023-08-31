import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/apis/fee_related_api.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_details_model.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_year_list_model.dart';
import '../model/feeModel.dart';
import '../model/fee_receipt_no_model.dart';

class FeeController extends GetxController {
  RxList<OverAllAnalysisValue> overAllAnalysisData =
      <OverAllAnalysisValue>[].obs;

  RxList<HeadwiseAnalysisData> headWiseAnalysisData =
      <HeadwiseAnalysisData>[].obs;

  RxList<YearlistValues> feeReceiptYearList = <YearlistValues>[].obs;

  RxList<ReceiptNoList> feeReceiptNoList = <ReceiptNoList>[].obs;

  RxList<FillStudentViewDetails> feeReceiptDetailsList =
      <FillStudentViewDetails>[].obs;
  RxList<CurrpaymentdetailsValues> currentPaymentDetailList =
      <CurrpaymentdetailsValues>[].obs;

  RxBool isLoading = RxBool(false);
  RxBool isFeeLoading = RxBool(false);
  RxBool isReceipt = RxBool(false);
  RxBool isFeeDetail = RxBool(false);

  void isfeeDetail(bool loading) {
    isFeeDetail.value = loading;
  }

  void isreceipt(bool loading) {
    isReceipt.value = loading;
  }

  void isloading(bool loading) {
    isLoading.value = loading;
  }

  void isfeeloading(bool loading) {
    isFeeLoading.value = loading;
  }

  Future<bool> getFeeAnalysisData({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
  }) async {
    try {
      FeeDetails? feeDetails = await getFeeAnalysisList(
          miId: miId, asmayId: asmayId, amstId: amstId, base: base);
      if (feeDetails!.feeAnalysisList!.values != null ||
          feeDetails.feeAnalysisList != null) {
        overAllAnalysisData.clear();
        overAllAnalysisData.add(feeDetails.feeAnalysisList!.values!.first);

        if (feeDetails.studentfeedetails != null ||
            feeDetails.studentfeedetails!.values != null) {
          headWiseAnalysisData.clear();
          for (var i = 0;
              i < feeDetails.studentfeedetails!.values!.length;
              i++) {
            headWiseAnalysisData
                .add(feeDetails.studentfeedetails!.values!.elementAt(i)!);
          }
        }
        logger.d(headWiseAnalysisData.first.toString());

        return true;
      }
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> getFeeReceiptYearData({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
  }) async {
    try {
      FeeReceiptYearListModel? feeReceiptYearListModel =
          await getFeeReceiptYearList(
              miId: miId, asmayId: asmayId, amstId: amstId, base: base);

      if (feeReceiptYearListModel!.yearlist != null ||
          feeReceiptYearListModel.yearlist!.values != null) {
        feeReceiptYearList.clear();
        for (var i = 0;
            i < feeReceiptYearListModel.yearlist!.values!.length;
            i++) {
          feeReceiptYearList
              .add(feeReceiptYearListModel.yearlist!.values!.elementAt(i));
        }

        return true;
      }

      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> getFeeReceiptNoListData({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
  }) async {
    try {
      FeeReceiptNoModel? receiptNoList = await getFeeReceiptNoList(
          miId: miId, asmayId: asmayId, amstId: amstId, base: base);

      if (receiptNoList!.recnolist != null ||
          receiptNoList.recnolist!.values != null) {
        feeReceiptNoList.clear();
        for (var i = 0; i < receiptNoList.recnolist!.values!.length; i++) {
          feeReceiptNoList.add(receiptNoList.recnolist!.values!.elementAt(i));
        }

        logger.d('This one', feeReceiptNoList);

        return true;
      }

      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> getFeeReceiptDetail({
    required int miId,
    required int asmayId,
    required int amstId,
    required int fypId,
    required String base,
  }) async {
    try {
      FeeReceiptDetailsModel? feeReceiptDetailsModel =
          await getFeeReceiptDetails(
              fypId: fypId,
              miId: miId,
              asmayId: asmayId,
              amstId: amstId,
              base: base); //////////////////////

      if (feeReceiptDetailsModel!.fillstudentviewdetails != null ||
          feeReceiptDetailsModel.fillstudentviewdetails!.values != null) {
        feeReceiptDetailsList
            .add(feeReceiptDetailsModel.fillstudentviewdetails!);
        if (feeReceiptDetailsModel.currpaymentdetails != null ||
            feeReceiptDetailsModel.currpaymentdetails!.values != null) {
          currentPaymentDetailList
              .addAll(feeReceiptDetailsModel.currpaymentdetails!.values!);
        }
        return true;
      }

      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
